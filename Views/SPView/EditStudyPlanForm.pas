unit EditStudyPlanForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.DBCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  InsertEditMode, Vcl.Menus, cxButtons, Data.DB, CourceNameQuery, SpecPopupView,
  cxDBExtLookupComboBox, SpecEdSimpleQuery, cxCheckBox, cxDBEdit,
  SpecEdSimpleInt, System.Generics.Collections, EditSpecFrm, FDDumb,
  SPEditInterface;

type
  TfrmEditStudyPlan = class(TForm, ISpecEdSimple)
    Label1: TLabel;
    cxdblcbEducations: TcxDBLookupComboBox;
    btnClose: TcxButton;
    Label2: TLabel;
    cxdblcbChairs: TcxDBLookupComboBox;
    lblSpeciality: TLabel;
    cxdbextlcbSpecialitys: TcxDBExtLookupComboBox;
    Label4: TLabel;
    cxteYears: TcxTextEdit;
    cxteMonths: TcxTextEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cxteAnnotation: TcxTextEdit;
    Label8: TLabel;
    cxdblcbQualifications: TcxDBLookupComboBox;
    lblLocked: TLabel;
    cxcbLocked: TcxCheckBox;
    lblShowOnPortal: TLabel;
    cxcbPortal: TcxCheckBox;
    lblStandart: TLabel;
    cxdblcbStandarts: TcxDBLookupComboBox;
    cxbtnAddSpeciality: TcxButton;
    Label3: TLabel;
    cxcbEnabled: TcxCheckBox;
    procedure cxdblcbEducationsPropertiesChange(Sender: TObject);
    procedure cxdblcbChairsPropertiesChange(Sender: TObject);
    procedure cxdbextlcbSpecialitysPropertiesPopup(Sender: TObject);
    procedure cxdbextlcbSpecialitysPropertiesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxteYearsPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxdblcbStandartsPropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure cxdblcbStandartsPropertiesChange(Sender: TObject);
    procedure cxbtnAddSpecialityClick(Sender: TObject);
  private
    FAddSpecialityHint: TDictionary<Integer, String>;
    FfrmEditSpec: TfrmEditSpec;
    FMode: TMode;
    FqEdDumb: TFDDumb;
    FqChairDumb: TFDDumb;
    FqEdLvlDumb: TFDDumb;
    FqSpecDumb: TFDDumb;
    FqQualificationDumb: TFDDumb;
    FqStandartDumb: TFDDumb;
    FSpecLabel: TDictionary<Integer, String>;
    FSPEditI: ISPEdit;
    FUpdateCount: Integer;
    FViewSpecPopup: TViewSpecPopup;
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetIDChair: Integer;
    function GetIDSpeciality: Integer;
    function GetIDEducation2: Integer;
    function GetIDEducationLevel: Integer;
    function GetYears: Integer;
    function GetMonths: Integer;
    function GetAnnotation: string;
    function GetYear: Integer;
    function GetIDQualification: Integer;
    function GetIDStandart: Integer;
    function GetLocked: Boolean;
    function GetPortal: Boolean;
    function GetIsEnabled: Boolean;
    procedure SetIDChair(const Value: Integer);
    procedure SetIDSpeciality(const Value: Integer);
    procedure SetIDEducation2(const Value: Integer);
    procedure SetIDEducationLevel(const Value: Integer);
    procedure SetYears(const Value: Integer);
    procedure SetMonths(const Value: Integer);
    procedure SetAnnotation(const Value: string);
    procedure SetIDQualification(const Value: Integer);
    procedure SetIDStandart(const Value: Integer);
    procedure SetLocked(const Value: Boolean);
    procedure SetPortal(const Value: Boolean);
    procedure SetIsEnabled(const Value: Boolean);
    property Annotation: string read GetAnnotation write SetAnnotation;
    property IDChair: Integer read GetIDChair write SetIDChair;
    property IDEducation2: Integer read GetIDEducation2 write SetIDEducation2;
    property IDQualification: Integer read GetIDQualification
      write SetIDQualification;
    property IDSpeciality: Integer read GetIDSpeciality write SetIDSpeciality;
    property Locked: Boolean read GetLocked write SetLocked;
    property Months: Integer read GetMonths write SetMonths;
    property Portal: Boolean read GetPortal write SetPortal;
    property IsEnabled: Boolean read GetIsEnabled write SetIsEnabled;
    property Years: Integer read GetYears write SetYears;
    { Private declarations }
  protected
    procedure Check;
    procedure CheckQualification; virtual;
    function CreateEditSpecForm(AMode: TMode): TfrmEditSpec; virtual;
    procedure SetMode(const Value: TMode); virtual;
    property IDStandart: Integer read GetIDStandart write SetIDStandart;
    property SPEditI: ISPEdit read FSPEditI;
  public
    constructor Create(AOwner: TComponent; ASPEditI: ISPEdit; AMode: TMode);
        reintroduce;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    property IDEducationLevel: Integer read GetIDEducationLevel
      write SetIDEducationLevel;
    property Year: Integer read GetYear;
    property Mode: TMode read FMode write SetMode;
    { Public declarations }
  published
  end;

implementation

uses
  DBLookupComboBoxHelper, FireDAC.Comp.Client, cxGridDBBandedTableView,
  System.Math, System.StrUtils;

{$R *.dfm}

constructor TfrmEditStudyPlan.Create(AOwner: TComponent; ASPEditI: ISPEdit;
    AMode: TMode);
begin
  inherited Create(AOwner);
  Assert(ASPEditI <> nil);
  FSPEditI := ASPEditI;

  FSpecLabel := TDictionary<Integer, String>.Create;
  FSpecLabel.Add(1, 'Специальность');
  FSpecLabel.Add(2, 'Направление подготовки');
  FSpecLabel.Add(3, 'Специальность');
  FSpecLabel.Add(5, 'Направление переподготовки');

  FAddSpecialityHint := TDictionary<Integer, String>.Create;
  FAddSpecialityHint.Add(1, 'Новая специальность');
  FAddSpecialityHint.Add(2, 'Новое направление подготовки');
  FAddSpecialityHint.Add(3, 'Новая специальность');
  FAddSpecialityHint.Add(5, 'Новое направление переподготовки');

  // **********************************************
  // Уровень образования
  // **********************************************
  FqEdLvlDumb := TFDDumb.Create(Self);

  // **********************************************
  // Формы обучения
  // **********************************************
  FqEdDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbEducations, FqEdDumb.W.ID, FSPEditI.EdW.Education,
    lsFixedList);

  // **********************************************
  // Кафедра
  // **********************************************
  FqChairDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbChairs, FqChairDumb.W.ID,
    FSPEditI.EnabledChairsW.Наименование, lsFixedList);

  // **********************************************
  // Специальности
  // **********************************************
  FqSpecDumb := TFDDumb.Create(Self);

  FSPEditI.SearchSpecByChair(100, 100);

  // Подключаем выпадающий список специальностей
  FViewSpecPopup := TViewSpecPopup.Create(Self);
  FViewSpecPopup.W := FSPEditI.SpecByChairW;
  with cxdbextlcbSpecialitys do
  begin
    DataBinding.DataSource := FqSpecDumb.DataSource;
    DataBinding.DataField := FqSpecDumb.W.ID.FieldName;
    Properties.DropDownListStyle := lsFixedList;
    Properties.DropDownRows := 24;
    Properties.DropDownSizeable := True;
    Properties.View := FViewSpecPopup.MainView;
    Properties.KeyFieldNames := FSPEditI.SpecByChairW.PKFieldName;
    Properties.ListFieldItem := FViewSpecPopup.clCalcSpeciality;
  end;

  // **********************************************
  // Квалификации
  // **********************************************
  FqQualificationDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbQualifications, FqQualificationDumb.W.ID,
    FSPEditI.QualificationsW.Qualification, lsEditList);

  // **********************************************
  // Стандарты учебных планов
  // **********************************************
  FqStandartDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbStandarts, FqStandartDumb.W.ID,
    FSPEditI.SPStandartW.StudyPlanStandart, lsEditList);

  Mode := AMode;
end;

procedure TfrmEditStudyPlan.cxbtnAddSpecialityClick(Sender: TObject);
begin
  if FfrmEditSpec <> nil then
    FreeAndNil(FfrmEditSpec);

  FfrmEditSpec := CreateEditSpecForm(InsertMode);

  if FfrmEditSpec.ShowModal = mrOK then
    // Выбираем добавленную в выпадающий список специальность
    IDSpeciality := FSPEditI.SpecByChairW.ID_Speciality.F.AsInteger
  else
    FreeAndNil(FfrmEditSpec)
end;

procedure TfrmEditStudyPlan.cxdbextlcbSpecialitysPropertiesChange
  (Sender: TObject);
var
  V: Variant;
begin
  V := (Sender as TcxDBExtLookupComboBox).EditValue;
  (Sender as TcxDBExtLookupComboBox).PostEditValue;
  FqSpecDumb.W.TryPost;

  if FUpdateCount > 0 then
    Exit;

  if (FSPEditI.SpecByChairW.DataSet.Active) and FSPEditI.SpecByChairW.LocateByPK
    (IDSpeciality) then
  begin
    // Выбираем квалификацию как у выбранной специальности
    FqQualificationDumb.W.UpdateID
      (FSPEditI.SpecByChairW.QUALIFICATION_ID.F.AsInteger);
  end;
end;

procedure TfrmEditStudyPlan.cxdbextlcbSpecialitysPropertiesPopup
  (Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
begin
  AView := cxdbextlcbSpecialitys.Properties.View as TcxGridDBBandedTableView;
  Assert(AView <> nil);
  FViewSpecPopup.MyApplyBestFitForView(AView);
end;

procedure TfrmEditStudyPlan.cxdblcbChairsPropertiesChange(Sender: TObject);
var
  AIDEdLvl: Integer;
begin
  (Sender as TcxDBLookupComboBox).PostEditValue;
  FqChairDumb.W.TryPost;

  Assert(IDChair > 0);

  // Фильтруем специальности по кафедре и образованию
  FSPEditI.SearchSpecByChair(IDEducationLevel, IDChair);

  AIDEdLvl := StrToIntDef
    (VarToStrDef(FSPEditI.SpecByChairW.IDEducationLevel.DefaultValue, '2'), 2);

  lblSpeciality.Caption := FSpecLabel[AIDEdLvl];
  cxbtnAddSpeciality.Hint := FAddSpecialityHint[AIDEdLvl];
  cxbtnAddSpeciality.Enabled := IDChair > 0;
end;

procedure TfrmEditStudyPlan.cxdblcbEducationsPropertiesChange(Sender: TObject);
begin
  (Sender as TcxDBLookupComboBox).PostEditValue;
  FqEdDumb.W.TryPost;
end;

procedure TfrmEditStudyPlan.cxdblcbStandartsPropertiesChange(Sender: TObject);
begin
  (Sender as TcxDBLookupComboBox).PostEditValue;
  FqStandartDumb.W.TryPost;
end;

procedure TfrmEditStudyPlan.cxdblcbStandartsPropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  if AText <> '' then
    FSPEditI.SPStandartW.Append(AText);
end;

procedure TfrmEditStudyPlan.cxteYearsPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  Error := StrToIntDef(VarToStrDef(DisplayValue, ''), -1) = -1;
  // if Error then
  // ErrorText := 'Значение должно быть целым положительным числом';
end;

destructor TfrmEditStudyPlan.Destroy;
begin
  if FfrmEditSpec <> nil then
    FreeAndNil(FfrmEditSpec);
  inherited;
end;

procedure TfrmEditStudyPlan.AfterConstruction;
begin
  inherited;
end;

procedure TfrmEditStudyPlan.BeginUpdate;
begin
  Inc(FUpdateCount);
  Assert(FUpdateCount > 0);
end;

procedure TfrmEditStudyPlan.Check;
begin
  if IDEducation2 = 0 then
    raise Exception.Create('Не задана форма обучения');

  if IDChair = 0 then
    raise Exception.Create('Не выбрана кафедра');

  if IDSpeciality = 0 then
    raise Exception.Create('Не задано направление подготовки');

  CheckQualification;

  // Если ввели кол-во часов
  if (Years * 12 + Months) = 0 then
  begin
    raise Exception.Create('Срок обучения должен быть больше 0');
  end;
end;

procedure TfrmEditStudyPlan.CheckQualification;
begin
  if IDQualification = 0 then
    raise Exception.Create('Не задана квалификация');
end;

function TfrmEditStudyPlan.CreateEditSpecForm(AMode: TMode): TfrmEditSpec;
begin
  Result := TfrmEditSpec.Create(Self, FSPEditI.GetSpecEditI, AMode);
end;

procedure TfrmEditStudyPlan.EndUpdate;
begin
  Dec(FUpdateCount);
  Assert(FUpdateCount >= 0);
end;

procedure TfrmEditStudyPlan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
  begin
    // НЕ сохраняем сделанные изменения в БД
    FSPEditI.Cancel();
    Exit;
  end;

  try
    // Чтобы потеряли фокус выпадающие списки и присвоили Dump новое выбранное значение
    btnClose.SetFocus;

    Check;

    // Просим учебный план сохранить информацию
    FSPEditI.Save(Self, FMode, FfrmEditSpec);
  except
    Action := caNone;
    raise;
  end;
end;

function TfrmEditStudyPlan.GetIDChair: Integer;
begin
  Result := FqChairDumb.W.ID.F.AsInteger;
end;

function TfrmEditStudyPlan.GetIDSpeciality: Integer;
begin
  Result := FqSpecDumb.W.ID.F.AsInteger;
end;

function TfrmEditStudyPlan.GetIDEducation2: Integer;
begin
  Result := FqEdDumb.W.ID.F.AsInteger;
end;

function TfrmEditStudyPlan.GetIDEducationLevel: Integer;
begin
  Result := FqEdLvlDumb.W.ID.F.AsInteger;
end;

function TfrmEditStudyPlan.GetYears: Integer;
begin
  Result := StrToIntDef(cxteYears.Text, 0);
end;

function TfrmEditStudyPlan.GetMonths: Integer;
begin
  Result := StrToIntDef(cxteMonths.Text, 0);
end;

function TfrmEditStudyPlan.GetAnnotation: string;
begin
  Result := cxteAnnotation.Text;
end;

function TfrmEditStudyPlan.GetYear: Integer;
begin
  Result := FSPEditI.IDYearW.ID.F.AsInteger;
end;

function TfrmEditStudyPlan.GetIDQualification: Integer;
begin
  Result := FqQualificationDumb.W.ID.F.AsInteger;
end;

function TfrmEditStudyPlan.GetIDStandart: Integer;
begin
  Result := FqStandartDumb.W.ID.F.AsInteger;
end;

function TfrmEditStudyPlan.GetLocked: Boolean;
begin
  Result := cxcbLocked.Checked;
end;

function TfrmEditStudyPlan.GetPortal: Boolean;
begin
  Result := cxcbPortal.Checked;
end;

function TfrmEditStudyPlan.GetIsEnabled: Boolean;
begin
  Result := cxcbEnabled.Checked;
end;

procedure TfrmEditStudyPlan.SetIDChair(const Value: Integer);
begin
  if IDChair = Value then
    Exit;

  FqChairDumb.W.UpdateID(Value);
end;

procedure TfrmEditStudyPlan.SetIDSpeciality(const Value: Integer);
begin
  if IDSpeciality = Value then
    Exit;

  FqSpecDumb.W.UpdateID(Value);
end;

procedure TfrmEditStudyPlan.SetIDEducation2(const Value: Integer);
begin
  if IDEducation2 = Value then
    Exit;

  FqEdDumb.W.UpdateID(Value);
end;

procedure TfrmEditStudyPlan.SetIDEducationLevel(const Value: Integer);
begin
  if IDEducationLevel = Value then
    Exit;

  FqEdLvlDumb.W.UpdateID(Value);
end;

procedure TfrmEditStudyPlan.SetMode(const Value: TMode);
begin
  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FSPEditI.SpecEdSimpleW.RecordCount = 1);

        BeginUpdate;
        try
          with FSPEditI do
          begin
            IDEducationLevel := SpecEdSimpleW.IDEducationLevel.F.AsInteger;
            IDEducation2 := SpecEdSimpleW.IDEducation2.F.AsInteger;
            IDChair := SpecEdSimpleW.IDChair.F.AsInteger;
            IDStandart := SpecEdSimpleW.IDStudyPlanStandart.F.AsInteger;

            // Если квалификацию нужно брать из специальности
            if SpecEdSimpleW.IDQualification.F.AsInteger = 0 then
            begin
              // Выбираем все подходящие специальности
              SearchSpecByChair(SpecEdSimpleW.IDEducationLevel.F.AsInteger,
                SpecEdSimpleW.IDChair.F.AsInteger);

              // Ищем специальность
              SpecByChairW.LocateByPK
                (SpecEdSimpleW.IDSpeciality.F.AsInteger, True);

              // Берём квалификацию из найденной специальности
              IDQualification := SpecByChairW.QUALIFICATION_ID.F.AsInteger;
            end
            else
              IDQualification := SpecEdSimpleW.IDQualification.F.AsInteger;

            IDSpeciality := SpecEdSimpleW.IDSpeciality.F.AsInteger;
            Years := SpecEdSimpleW.Years.F.AsInteger;
            Months := SpecEdSimpleW.Months.F.AsInteger;
            Annotation := SpecEdSimpleW.Annotation.F.AsString;
            IsEnabled := SpecEdSimpleW.Enable_SpecialityEducation.F.
              AsInteger = 1;
            Locked := SpecEdSimpleW.Locked.F.AsInteger = 1;
            Portal := SpecEdSimpleW.Portal.F.AsInteger = 1;
          end;
        finally
          EndUpdate;
        end;
        Caption := 'Изменение параметров учебного плана';
      end;
    InsertMode:
      begin
        // IDEducationLevel := ??? Уровень образования
        IDEducation2 := 0;
        IDChair := 0;
        IDSpeciality := 0;
        Years := 0;
        Months := 0;
        Annotation := '';
        IsEnabled := True;
        Locked := False;
        Portal := False;
        Caption := 'Новый учебный план';
      end;
  end;
end;

procedure TfrmEditStudyPlan.SetYears(const Value: Integer);
begin
  cxteYears.Text := IntToStr(Value);
end;

procedure TfrmEditStudyPlan.SetMonths(const Value: Integer);
begin
  cxteMonths.Text := IntToStr(Value);
end;

procedure TfrmEditStudyPlan.SetAnnotation(const Value: string);
begin
  cxteAnnotation.Text := Value;
end;

procedure TfrmEditStudyPlan.SetIDQualification(const Value: Integer);
begin
  if IDQualification = Value then
    Exit;

  FqQualificationDumb.W.UpdateID(Value);
end;

procedure TfrmEditStudyPlan.SetIDStandart(const Value: Integer);
begin
  if IDStandart = Value then
    Exit;

  FqStandartDumb.W.UpdateID(Value);
end;

procedure TfrmEditStudyPlan.SetLocked(const Value: Boolean);
begin
  cxcbLocked.Checked := Value;
end;

procedure TfrmEditStudyPlan.SetPortal(const Value: Boolean);
begin
  cxcbPortal.Checked := Value;
end;

procedure TfrmEditStudyPlan.SetIsEnabled(const Value: Boolean);
begin
  cxcbEnabled.Checked := Value;
end;

end.
