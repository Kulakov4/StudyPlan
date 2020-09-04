unit CourceDiscEditForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, Vcl.StdCtrls, cxSpinEdit, cxCheckBox, Vcl.Menus,
  cxButtons, CourceGroup, Data.DB, InsertEditMode, FireDAC.Comp.Client,
  cxLabel, DiscNameQry, CourceDiscNameViewModel, DiscNameInt,
  CourseStudyPlanInterface, FDDumb;

type
  TfrmCourceDiscEdit = class(TForm, IDiscName, ICourseStudyPlan)
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
    function GetDisciplineName: string; stdcall;
    function GetIDChair: Integer; stdcall;
    function GetIDSPECIALITYEDUCATION: Integer; stdcall;
    function GetShortDisciplineName: String; stdcall;
  private
    FModel: TCourceDiscNameVM;
    FMode: TMode;
    FqDisciplineNameDumb: TFDDumb;
    function GetExam: Boolean; stdcall;
    function GetIDDisciplineName: Integer; stdcall;
    function GetLec: Integer; stdcall;
    function GetLab: Integer; stdcall;
    function GetSem: Integer; stdcall;
    function GetZach: Boolean; stdcall;
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
    constructor Create(AOwner: TComponent); override;
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

constructor TfrmCourceDiscEdit.Create(AOwner: TComponent);
begin
  inherited;
  Assert(AOwner is TCourceDiscNameVM);

  FModel := AOwner as TCourceDiscNameVM;

  FMode := InsertMode;

  // **********************************************
  // Наименования дисциплин
  // **********************************************
  FqDisciplineNameDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbDisciplineName, FqDisciplineNameDumb.W.ID,
    FModel.DiscNameW.DisciplineName, lsEditList);
end;

procedure TfrmCourceDiscEdit.Check;
begin
  if cxdblcbDisciplineName.Text = '' then
    raise Exception.Create('Не задано наименование дисциплины');

  // if cxteShort.Text = '' then
  // raise Exception.Create('Не задано сокращение');

end;

procedure TfrmCourceDiscEdit.cxdblcbDisciplineNamePropertiesEditValueChanged
  (Sender: TObject);
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
    FModel.DiscNameW.LocateByPK(FqDisciplineNameDumb.W.ID.F.AsInteger, True);

    // Отображаем её сокращённое наименование
    cxteShort.Text := FModel.DiscNameW.ShortDisciplineName.F.AsString;
  end;
end;

procedure TfrmCourceDiscEdit.cxdblcbDisciplineNamePropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  if AText = '' then
    Exit;

  // Пытаемся добавить новое наименование переподготовки (пока с ID = NULL)
  FModel.DiscNameW.Append(AText, cxteShort.Text, FModel.IDChair, 3);
end;

procedure TfrmCourceDiscEdit.cxseLecPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  x: Integer;
begin
  x := StrToIntDef(VarToStrDef(DisplayValue, ''), -1);
  Error := x < 0;
  if Error then
    ErrorText := 'Отрицательное значение не допускается';
end;

procedure TfrmCourceDiscEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
  begin
    // НЕ сохраняем сделанные изменения в БД
    FModel.CancelUpdates; // qDisciplineName.FDQuery.CancelUpdates;
    Exit;
  end;

  try
    Check;
  except
    Action := caNone;
    raise;
  end;

  // Сохраняем дисциплину и обновляем её код
  FqDisciplineNameDumb.W.UpdateID
    (FModel.ApplyDisciplines(FqDisciplineNameDumb.W.ID.F.AsInteger, Self));

  // Сохраняем запись в учебном плане курсов
  FModel.ApplyCourseStudyPlan(Self, Mode);
end;

function TfrmCourceDiscEdit.GetDisciplineName: string;
begin
  cxdblcbDisciplineName.Text;
end;

function TfrmCourceDiscEdit.GetExam: Boolean;
begin
  Result := cxcbExam.Checked;
end;

function TfrmCourceDiscEdit.GetIDChair: Integer;
begin
  Result := FModel.IDChair;
end;

function TfrmCourceDiscEdit.GetIDDisciplineName: Integer;
begin
  Result := FqDisciplineNameDumb.W.ID.F.AsInteger;
end;

function TfrmCourceDiscEdit.GetIDSPECIALITYEDUCATION: Integer;
begin
  Result := FModel.IDSPECIALITYEDUCATION;
end;

function TfrmCourceDiscEdit.GetLec: Integer;
begin
  Result := cxseLec.Value;
end;

function TfrmCourceDiscEdit.GetLab: Integer;
begin
  Result := cxseLab.Value;
end;

function TfrmCourceDiscEdit.GetSem: Integer;
begin
  Result := cxseSem.Value;
end;

function TfrmCourceDiscEdit.GetShortDisciplineName: String;
begin
  Result := cxteShort.Text;
end;

function TfrmCourceDiscEdit.GetZach: Boolean;
begin
  Result := cxcbZach.Checked;
end;

procedure TfrmCourceDiscEdit.SetExam(const Value: Boolean);
begin
  cxcbExam.Checked := Value;
end;

procedure TfrmCourceDiscEdit.SetIDDisciplineName(const Value: Integer);
begin
  FqDisciplineNameDumb.W.UpdateID(Value);
end;

procedure TfrmCourceDiscEdit.SetLec(const Value: Integer);
begin
  cxseLec.Value := Value;
end;

procedure TfrmCourceDiscEdit.SetLab(const Value: Integer);
begin
  cxseLab.Value := Value;
end;

procedure TfrmCourceDiscEdit.SetSem(const Value: Integer);
begin
  cxseSem.Value := Value;
end;

procedure TfrmCourceDiscEdit.SetMode(const Value: TMode);
begin
  // if FMode = Value then
  // Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FModel.IDSPECIALITYEDUCATION > 0);
        with FModel do
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

procedure TfrmCourceDiscEdit.SetZach(const Value: Boolean);
begin
  cxcbZach.Checked := Value;
end;

end.
