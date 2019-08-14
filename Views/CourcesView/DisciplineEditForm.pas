unit DisciplineEditForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  Vcl.StdCtrls,
  cxSpinEdit, cxCheckBox, Vcl.Menus, cxButtons, CourceGroup, FDDumbQuery,
  Data.DB, InsertEditMode, FireDAC.Comp.Client, DisciplineNameQuery, cxLabel;

type
  TfrmEditDiscipline = class(TForm)
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
    dsDisciplineName: TDataSource;
    procedure cxdblcbDisciplineNamePropertiesNewLookupDisplayText
      (Sender: TObject; const AText: TCaption);
    procedure cxdblcbDisciplineNamePropertiesEditValueChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxseLecPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    FCourceGroup: TCourceGroup;
    FDisciplineName: TFDMemTable;
    FDisciplineNameW: TDisciplineNameW;
    FIDChair: Integer;
    FMode: TMode;
    FqDisciplineNameDumb: TQueryFDDumb;
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
  System.Math;

{$R *.dfm}

constructor TfrmEditDiscipline.Create(AOwner: TComponent);
begin
  inherited;
  Assert(AOwner is TCourceGroup);

  FCourceGroup := AOwner as TCourceGroup;
  Assert(FCourceGroup.qAdmissions.FDQuery.RecordCount > 0);
  FIDChair := FCourceGroup.qAdmissions.W.IDChair.F.AsInteger;
  Assert(FIDChair > 0);
  FMode := InsertMode;

  // Создаём клон названий дисциплин
  FDisciplineName := FCourceGroup.qDisciplineName.W.AddClone('');
  // Создаём обёртку
  FDisciplineNameW := TDisciplineNameW.Create(FDisciplineName);
  // Фильтруем названия дисциплин по кафедре
  FDisciplineNameW.FilterByChair(FIDChair);
  dsDisciplineName.DataSet := FDisciplineName;

  // **********************************************
  // Наименования дисциплин
  // **********************************************
  FqDisciplineNameDumb := TQueryFDDumb.Create(Self);

  cxdblcbDisciplineName.DataBinding.DataSource :=
    FqDisciplineNameDumb.DataSource;
  cxdblcbDisciplineName.DataBinding.DataField :=
    FqDisciplineNameDumb.W.ID.FieldName;
  cxdblcbDisciplineName.Properties.ListSource := dsDisciplineName;
  cxdblcbDisciplineName.Properties.KeyFieldNames :=
    FDisciplineNameW.PKFieldName;
  cxdblcbDisciplineName.Properties.ListFieldNames :=
    FDisciplineNameW.DisciplineName.FieldName
end;

destructor TfrmEditDiscipline.Destroy;
begin
  FreeAndNil(FDisciplineNameW);
  FCourceGroup.qDisciplineName.W.DropClone(FDisciplineName);
  inherited;
end;

procedure TfrmEditDiscipline.Check;
var
  Lab: Integer;
  Lec: Integer;
  Sem: Integer;
begin
  if cxdblcbDisciplineName.Text = '' then
    raise Exception.Create('Не задано наименование дисциплины');

//  if cxteShort.Text = '' then
//    raise Exception.Create('Не задано сокращение');

  Lec := cxseLec.Value;
  Lab := cxseLab.Value;
  Sem := cxseSem.Value;

  // Если ввели кол-во часов
  if (Lec + Lab + Sem) <= 0 then
  begin
    raise Exception.Create('Количество часов должно быть больше 0');
  end;
end;

procedure TfrmEditDiscipline.cxdblcbDisciplineNamePropertiesEditValueChanged
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
    FDisciplineNameW.LocateByPK(FqDisciplineNameDumb.W.ID.F.AsInteger, True);
    cxteShort.Text := FDisciplineNameW.ShortDisciplineName.F.AsString;
  end;
end;

procedure TfrmEditDiscipline.cxdblcbDisciplineNamePropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  if AText = '' then
    Exit;

  // Пытаемся добавить новое наименование переподготовки (пока с ID = NULL)
  FDisciplineNameW.Append(AText, cxteShort.Text, FIDChair);

end;

procedure TfrmEditDiscipline.cxseLecPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  x: Integer;
begin
  x := StrToIntDef( VarToStrDef(DisplayValue, ''), -1);
  Error := x < 0;
  if Error then
    ErrorText := 'Отрицательное значение не допускается';
end;

procedure TfrmEditDiscipline.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
  begin
    // НЕ сохраняем сделанные изменения в БД
    FCourceGroup.qDisciplineName.FDQuery.CancelUpdates;
    Exit;
  end;

  try
    Check;
  except
    Action := caNone;
    raise;
  end;

  // Тут у нас пока может ID = NULL
  FDisciplineNameW.LocateByPK(FqDisciplineNameDumb.W.ID.F.AsInteger);
  FDisciplineNameW.UpdateShortCaption(cxteShort.Text);

  // Наконец-то сохраняем сделанные изменения в БД
  FCourceGroup.qDisciplineName.FDQuery.ApplyUpdates(0);
  FCourceGroup.qDisciplineName.FDQuery.CommitUpdates;
  // Тут должен появиться положительный ID
  Assert(FDisciplineNameW.PK.AsInteger > 0);

  FqDisciplineNameDumb.W.UpdateID(FDisciplineNameW.PK.AsInteger);

  FDisciplineNameW.ClearFilter;

  with FCourceGroup.qDPOSP do
  begin
    if Mode = InsertMode then
      W.TryAppend
    else
      W.TryEdit;

    W.IDSPECIALITYEDUCATION.F.AsInteger :=
      FCourceGroup.qAdmissions.W.ID_SpecialityEducation.F.AsInteger;
    W.IDChair.F.AsInteger := FCourceGroup.qAdmissions.W.IDChair.F.AsInteger;
    W.IDDisciplineName.F.AsInteger := IDDisciplineName;
    W.LecData.F.AsInteger := Lec;
    W.LabData.F.AsInteger := Lab;
    W.SemData.F.AsInteger := Sem;
    W.ZachData.F.AsInteger := IfThen(Zach, 2, 0);
    W.ExamData.F.AsInteger := IfThen(Exam, 2, 0);

    W.TryPost;
    // Возможно qDPOSP в режиме кэширования данных!!!

//    Assert(W.ID_StudyPlan.F.AsInteger > 0);
  end;

end;

function TfrmEditDiscipline.GetExam: Boolean;
begin
  Result := cxcbExam.Checked;
end;

function TfrmEditDiscipline.GetIDDisciplineName: Integer;
begin
  Result := FqDisciplineNameDumb.W.ID.F.AsInteger;
end;

function TfrmEditDiscipline.GetLec: Integer;
begin
  Result := cxseLec.Value;
end;

function TfrmEditDiscipline.GetLab: Integer;
begin
  Result := cxseLab.Value;
end;

function TfrmEditDiscipline.GetSem: Integer;
begin
  Result := cxseSem.Value;
end;

function TfrmEditDiscipline.GetZach: Boolean;
begin
  Result := cxcbZach.Checked;
end;

procedure TfrmEditDiscipline.SetExam(const Value: Boolean);
begin
  cxcbExam.Checked := Value;
end;

procedure TfrmEditDiscipline.SetIDDisciplineName(const Value: Integer);
begin
  FqDisciplineNameDumb.W.UpdateID(Value);
end;

procedure TfrmEditDiscipline.SetLec(const Value: Integer);
begin
  cxseLec.Value := Value;
end;

procedure TfrmEditDiscipline.SetLab(const Value: Integer);
begin
  cxseLab.Value := Value;
end;

procedure TfrmEditDiscipline.SetSem(const Value: Integer);
begin
  cxseSem.Value := Value;
end;

procedure TfrmEditDiscipline.SetMode(const Value: TMode);
begin
  if FMode = Value then
    Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FCourceGroup.qAdmissions.W.DataSet.RecordCount > 0);
        with FCourceGroup.qDPOSP do
        begin
          IDDisciplineName := W.IDDisciplineName.F.AsInteger;
          Lec := W.LecData.F.AsInteger;
          Lab := W.LabData.F.AsInteger;
          Sem := W.SemData.F.AsInteger;
          Zach := W.ZachData.F.AsInteger > 0;
          Exam := W.ExamData.F.AsInteger > 0;
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

procedure TfrmEditDiscipline.SetZach(const Value: Boolean);
begin
  cxcbZach.Checked := Value;
end;

end.
