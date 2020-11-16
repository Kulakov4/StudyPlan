unit CourseStudyPlanEditForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, Vcl.StdCtrls, cxSpinEdit, cxCheckBox, Vcl.Menus,
  cxButtons, CourseGroup, Data.DB, InsertEditMode, FireDAC.Comp.Client,
  cxLabel, DiscNameQry, DiscNameInt, CourseStudyPlanInterface, FDDumb,
  CourseStudyPlanEditInterface;

type
  TfrmCourseStudyPlanEdit = class(TForm, IDiscName, ICourseStudyPlan)
    Label11: TLabel;
    cxdblcbDisciplineName: TcxDBLookupComboBox;
    Label12: TLabel;
    cxteShort: TcxTextEdit;
    Label1: TLabel;
    cxseLec: TcxSpinEdit;
    Label2: TLabel;
    cxseLab: TcxSpinEdit;
    Label3: TLabel;
    cxseSem: TcxSpinEdit;
    cxcbZach: TcxCheckBox;
    cxcbExam: TcxCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    btnClose: TcxButton;
    procedure cxdblcbDisciplineNamePropertiesNewLookupDisplayText
      (Sender: TObject; const AText: TCaption);
    procedure cxdblcbDisciplineNamePropertiesEditValueChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxseLecPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  strict private
    function GetDisciplineName: string;
    function GetIDChair: Integer;
    function GetIDSPECIALITYEDUCATION: Integer;
    function GetID_DisciplineName: Integer;
    function GetID_StudyPlan: Integer;
    function GetShortDisciplineName: String;
    function GetType_Discipline: Integer;
  private
    FCourseStudyPlanEditI: ICourseStudyPlanEdit;
    FMode: TMode;
    FqDisciplineNameDumb: TFDDumb;
    function GetExam: Boolean;
    function GetIDDisciplineName: Integer;
    function GetLec: Integer;
    function GetLab: Integer;
    function GetSem: Integer;
    function GetZach: Boolean;
    procedure SetExam(const Value: Boolean);
    procedure SetIDDisciplineName(const Value: Integer);
    procedure SetLec(const Value: Integer);
    procedure SetLab(const Value: Integer);
    procedure SetSem(const Value: Integer);
    procedure SetMode(const Value: TMode);
    procedure SetZach(const Value: Boolean);
    { Private declarations }
  protected
    procedure Check;
  public
    constructor Create(AOwner: TComponent;
      ACourseStudyPlanEditI: ICourseStudyPlanEdit; AMode: TMode); reintroduce;
    property Exam: Boolean read GetExam write SetExam;
    property IDDisciplineName: Integer read GetIDDisciplineName
      write SetIDDisciplineName;
    property Lec: Integer read GetLec write SetLec;
    property Lab: Integer read GetLab write SetLab;
    property Sem: Integer read GetSem write SetSem;
    property Mode: TMode read FMode write SetMode;
    property Zach: Boolean read GetZach write SetZach;
    { Public declarations }
  end;

implementation

uses
  System.Math, DBLookupComboBoxHelper;

{$R *.dfm}

constructor TfrmCourseStudyPlanEdit.Create(AOwner: TComponent;
  ACourseStudyPlanEditI: ICourseStudyPlanEdit; AMode: TMode);
begin
  inherited Create(AOwner);
  Assert(ACourseStudyPlanEditI <> nil);

  FCourseStudyPlanEditI := ACourseStudyPlanEditI;

  // **********************************************
  // Наименования дисциплин
  // **********************************************
  FqDisciplineNameDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbDisciplineName, FqDisciplineNameDumb.W.ID,
    FCourseStudyPlanEditI.DiscNameW.DisciplineName, lsEditList);

  Mode := AMode;
end;

procedure TfrmCourseStudyPlanEdit.Check;
begin
  if cxdblcbDisciplineName.Text = '' then
    raise Exception.Create('Не задано наименование дисциплины');

  // if cxteShort.Text = '' then
  // raise Exception.Create('Не задано сокращение');

end;

procedure TfrmCourseStudyPlanEdit.
  cxdblcbDisciplineNamePropertiesEditValueChanged(Sender: TObject);
var
  AcxDBLookupComboBox: TcxDBLookupComboBox;
begin
  AcxDBLookupComboBox := Sender as TcxDBLookupComboBox;
  AcxDBLookupComboBox.PostEditValue;
  if FqDisciplineNameDumb.W.ID.F.AsInteger = 0 then
  begin
    cxteShort.Text := '';
  end
  else
  begin
    // Ищем нужную нам дисциплину
    FCourseStudyPlanEditI.DiscNameW.LocateByPK
      (FqDisciplineNameDumb.W.ID.F.AsInteger, True);

    // Отображаем её сокращённое наименование
    cxteShort.Text := FCourseStudyPlanEditI.DiscNameW.ShortDisciplineName.
      F.AsString;
  end;
end;

procedure TfrmCourseStudyPlanEdit.
  cxdblcbDisciplineNamePropertiesNewLookupDisplayText(Sender: TObject;
  const AText: TCaption);
begin
  if AText = '' then
    Exit;

  // Пытаемся добавить новое наименование переподготовки (пока с ID = NULL)
  FCourseStudyPlanEditI.DiscNameW.Save(Self, InsertMode);
end;

procedure TfrmCourseStudyPlanEdit.cxseLecPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  x: Integer;
begin
  x := StrToIntDef(VarToStrDef(DisplayValue, ''), -1);
  Error := x < 0;
  if Error then
    ErrorText := 'Отрицательное значение не допускается';
end;

procedure TfrmCourseStudyPlanEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  AMode: TMode;
begin
  if ModalResult <> mrOK then
  begin
    // НЕ сохраняем сделанные изменения в БД
    Exit;
  end;

  try
    Check;
  except
    Action := caNone;
    raise;
  end;

  // Если код наименования дисциплины пустой - значит дисциплина новая
  if FqDisciplineNameDumb.W.ID.F.AsInteger = 0 then
    AMode := InsertMode
  else
    AMode := EditMode;

  // Сохраняем дисциплину и обновляем её код
  FqDisciplineNameDumb.W.UpdateID(FCourseStudyPlanEditI.ApplyDisciplines
    (Self, AMode));

  // Сохраняем запись в учебном плане курсов
  FCourseStudyPlanEditI.CourseStudyPlanW.Save(Self, Mode);
end;

function TfrmCourseStudyPlanEdit.GetDisciplineName: string;
begin
  Result := cxdblcbDisciplineName.Text;
end;

function TfrmCourseStudyPlanEdit.GetExam: Boolean;
begin
  Result := cxcbExam.Checked;
end;

function TfrmCourseStudyPlanEdit.GetIDChair: Integer;
begin
  Result := FCourseStudyPlanEditI.IDChair;
end;

function TfrmCourseStudyPlanEdit.GetIDDisciplineName: Integer;
begin
  Result := FqDisciplineNameDumb.W.ID.F.AsInteger;
end;

function TfrmCourseStudyPlanEdit.GetIDSPECIALITYEDUCATION: Integer;
begin
  Result := FCourseStudyPlanEditI.IDSPECIALITYEDUCATION;
end;

function TfrmCourseStudyPlanEdit.GetID_DisciplineName: Integer;
begin
  Result := FqDisciplineNameDumb.W.ID.F.AsInteger;
end;

function TfrmCourseStudyPlanEdit.GetID_StudyPlan: Integer;
begin
  Result := FCourseStudyPlanEditI.ID_StudyPlan;
end;

function TfrmCourseStudyPlanEdit.GetLec: Integer;
begin
  Result := cxseLec.Value;
end;

function TfrmCourseStudyPlanEdit.GetLab: Integer;
begin
  Result := cxseLab.Value;
end;

function TfrmCourseStudyPlanEdit.GetSem: Integer;
begin
  Result := cxseSem.Value;
end;

function TfrmCourseStudyPlanEdit.GetShortDisciplineName: String;
begin
  Result := cxteShort.Text;
end;

function TfrmCourseStudyPlanEdit.GetType_Discipline: Integer;
begin
  // Дисциплины курсов имеют тип 3
  Result := 3;
end;

function TfrmCourseStudyPlanEdit.GetZach: Boolean;
begin
  Result := cxcbZach.Checked;
end;

procedure TfrmCourseStudyPlanEdit.SetExam(const Value: Boolean);
begin
  cxcbExam.Checked := Value;
end;

procedure TfrmCourseStudyPlanEdit.SetIDDisciplineName(const Value: Integer);
begin
  FqDisciplineNameDumb.W.UpdateID(Value);
end;

procedure TfrmCourseStudyPlanEdit.SetLec(const Value: Integer);
begin
  cxseLec.Value := Value;
end;

procedure TfrmCourseStudyPlanEdit.SetLab(const Value: Integer);
begin
  cxseLab.Value := Value;
end;

procedure TfrmCourseStudyPlanEdit.SetSem(const Value: Integer);
begin
  cxseSem.Value := Value;
end;

procedure TfrmCourseStudyPlanEdit.SetMode(const Value: TMode);
begin
  // if FMode = Value then
  // Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FCourseStudyPlanEditI.ID_StudyPlan > 0);
        FCourseStudyPlanEditI.CourseStudyPlanW.ID_StudyPlan.Locate
          (FCourseStudyPlanEditI.ID_StudyPlan, [], True);
        with FCourseStudyPlanEditI do
        begin
          IDDisciplineName := CourseStudyPlanW.IDDisciplineName.F.AsInteger;
          Lec := CourseStudyPlanW.LecData.F.AsInteger;
          Lab := CourseStudyPlanW.LabData.F.AsInteger;
          Sem := CourseStudyPlanW.SemData.F.AsInteger;
          Zach := CourseStudyPlanW.ZachData.F.AsInteger > 0;
          Exam := CourseStudyPlanW.ExamData.F.AsInteger > 0;
        end;

        Caption := 'Редактирование дисциплины';
        btnClose.Caption := 'Сохранить';
      end;
    InsertMode:
      begin
        IDDisciplineName := 0;
        Caption := 'Добавление дисциплины';
        btnClose.Caption := 'Добавить';
      end;
  end;
end;

procedure TfrmCourseStudyPlanEdit.SetZach(const Value: Boolean);
begin
  cxcbZach.Checked := Value;
end;

end.
