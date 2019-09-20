unit EditStudyPlanForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.DBCtrls, SPGroup, FDDumbQuery, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  InsertEditMode, Vcl.Menus, cxButtons, Data.DB, CourceNameQuery, SpecPopupView,
  cxDBExtLookupComboBox, SpecEdSimpleQuery, cxCheckBox, cxDBEdit,
  SpecEdSimpleInt, System.Generics.Collections, EditSpecFrm;

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
    FMode: TMode;
    FNewIDSpecList: TList<Integer>;
    FqEdDumb: TQueryFDDumb;
    FqChairDumb: TQueryFDDumb;
    FqEdLvlDumb: TQueryFDDumb;
    FqSpecDumb: TQueryFDDumb;
    FqQualificationDumb: TQueryFDDumb;
    FqStandartDumb: TQueryFDDumb;
    FSpecLabel: TDictionary<Integer, String>;
    FSPGroup: TSPGroup;
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
    property IDStandart: Integer read GetIDStandart write SetIDStandart;
    property Locked: Boolean read GetLocked write SetLocked;
    property Months: Integer read GetMonths write SetMonths;
    property Portal: Boolean read GetPortal write SetPortal;
    property IsEnabled: Boolean read GetIsEnabled write SetIsEnabled;
    property Years: Integer read GetYears write SetYears;
    { Private declarations }
  protected
    procedure Check;
    procedure CheckQualification; virtual;
    function CreateEditSpecForm: TfrmEditSpec; virtual;
    procedure SetMode(const Value: TMode); virtual;
    property SPGroup: TSPGroup read FSPGroup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    property IDEducationLevel: Integer read GetIDEducationLevel write
        SetIDEducationLevel;
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

constructor TfrmEditStudyPlan.Create(AOwner: TComponent);
begin
  inherited;
  FSPGroup := (AOwner as TSPGroup);

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

  // Список добавленных специальностей
  FNewIDSpecList := TList<Integer>.Create;

  // **********************************************
  // Уровень образования
  // **********************************************
  FqEdLvlDumb := TQueryFDDumb.Create(Self);
  FqEdLvlDumb.Name := 'qEdLvlDumb';

  // **********************************************
  // Формы обучения
  // **********************************************
  FqEdDumb := TQueryFDDumb.Create(Self);
  FqEdDumb.Name := 'qEdDumb';

  TDBLCB.Init(cxdblcbEducations, FqEdDumb.DataSource, FqEdDumb.W.ID.FieldName,
    FSPGroup.qEd.DataSource, FSPGroup.qEd.W.Education, lsFixedList);

  // **********************************************
  // Кафедра
  // **********************************************
  FqChairDumb := TQueryFDDumb.Create(Self);
  FqChairDumb.Name := 'qEdChair';

  TDBLCB.Init(cxdblcbChairs, FqChairDumb.DataSource, FqChairDumb.W.ID.FieldName,
    FSPGroup.qEnabledChairs.DataSource, FSPGroup.qEnabledChairs.W.Наименование,
    lsFixedList);

  // **********************************************
  // Специальности
  // **********************************************
  FqSpecDumb := TQueryFDDumb.Create(Self);
  FqSpecDumb.Name := 'qSpecDumb';

  FSPGroup.qSpecByChair.Search(100, 100);

  // Подключаем выпадающий список специальностей
  FViewSpecPopup := TViewSpecPopup.Create(Self);
  FViewSpecPopup.QrySpecByChair := FSPGroup.qSpecByChair;
  with cxdbextlcbSpecialitys do
  begin
    DataBinding.DataSource := FqSpecDumb.DataSource;
    DataBinding.DataField := FqSpecDumb.W.ID.FieldName;
    Properties.DropDownListStyle := lsFixedList;
    Properties.DropDownRows := 24;
    Properties.DropDownSizeable := True;
    Properties.View := FViewSpecPopup.MainView;
    Properties.KeyFieldNames := FSPGroup.qSpecByChair.W.PKFieldName;
    Properties.ListFieldItem := FViewSpecPopup.clCalcSpeciality;
  end;

  // **********************************************
  // Квалификации
  // **********************************************
  FqQualificationDumb := TQueryFDDumb.Create(Self);
  FqQualificationDumb.Name := 'QualificationDumb';

  TDBLCB.Init(cxdblcbQualifications, FqQualificationDumb.DataSource,
    FqQualificationDumb.W.ID.FieldName, FSPGroup.qQualifications.DataSource,
    FSPGroup.qQualifications.W.Qualification, lsEditList);

  // **********************************************
  // Стандарты учебных планов
  // **********************************************
  FqStandartDumb := TQueryFDDumb.Create(Self);
  FqStandartDumb.Name := 'SPStandartDumb';

  TDBLCB.Init(cxdblcbStandarts, FqStandartDumb.DataSource,
    FqStandartDumb.W.ID.FieldName, FSPGroup.qSPStandart.DataSource,
    FSPGroup.qSPStandart.W.StudyPlanStandart, lsEditList);

  FMode := InsertMode;
end;

procedure TfrmEditStudyPlan.cxbtnAddSpecialityClick(Sender: TObject);
var
  AfrmEditSpec: TfrmEditSpec;
begin
  AfrmEditSpec := CreateEditSpecForm;
  try
    AfrmEditSpec.Mode := InsertMode;
    if AfrmEditSpec.ShowModal = mrOK then
    begin
      IDSpeciality := FSPGroup.qSpecByChair.W.ID_Speciality.F.AsInteger;
      // Запоминаем, что мы добавили новую специальность в базу!
      FNewIDSpecList.Add(IDSpeciality);
    end;
  finally
    AfrmEditSpec.Free;
  end;
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

  if (FSPGroup.qSpecByChair.FDQuery.Active) and
    FSPGroup.qSpecByChair.W.LocateByPK(IDSpeciality) then
  begin
    // Выбираем квалификацию как у выбранной специальности
    FqQualificationDumb.W.UpdateID
      (FSPGroup.qSpecByChair.W.QUALIFICATION_ID.F.AsInteger);
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
  FSPGroup.qSpecByChair.Search(IDEducationLevel, IDChair);

  AIDEdLvl := StrToIntDef
    (VarToStrDef(FSPGroup.qSpecByChair.W.IDEducationLevel.DefaultValue,
    '2'), 2);

  lblSpeciality.Caption := FSpecLabel[AIDEdLvl];
  cxbtnAddSpeciality.Hint := FAddSpecialityHint[AIDEdLvl];
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
    SPGroup.qSPStandart.W.Append(AText);
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
  FreeAndNil(FNewIDSpecList);
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

function TfrmEditStudyPlan.CreateEditSpecForm: TfrmEditSpec;
begin
  Result := TfrmEditSpec.Create(FSPGroup.qSpecByChair);
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
    FSPGroup.Cancel(FNewIDSpecList.ToArray);
    Exit;
  end;

  try
    // Чтобы потеряли фокус выпадающие списки и присвоили Dump новое выбранное значение
    btnClose.SetFocus;

    Check;

    // Просим учебный план сохранить информацию
    FSPGroup.Save(Self, FMode);
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
  Result := FSPGroup.YearDumb.W.ID.F.AsInteger;
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
//  if FMode = Value then
//    Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FSPGroup.qSpecEdSimple.FDQuery.RecordCount = 1);

        BeginUpdate;
        try
          with FSPGroup.qSpecEdSimple do
          begin
            IDEducationLevel := W.IDEducationLevel.F.AsInteger;
            IDEducation2 := W.IDEducation2.F.AsInteger;
            IDChair := W.IDChair.F.AsInteger;
            IDStandart := W.IDStudyPlanStandart.F.AsInteger;

            // Если квалификацию нужно брать из специальности
            if W.IDQualification.F.AsInteger = 0 then
            begin
              // Выбираем все подходящие специальности
              FSPGroup.qSpecByChair.Search(W.IDEducationLevel.F.AsInteger,
                W.IDChair.F.AsInteger);
              FSPGroup.qSpecByChair.W.LocateByPK
                (W.IDSpeciality.F.AsInteger, True);
              IDQualification := FSPGroup.qSpecByChair.W.QUALIFICATION_ID.
                F.AsInteger;
            end
            else
              IDQualification := W.IDQualification.F.AsInteger;

            IDSpeciality := W.IDSpeciality.F.AsInteger;
            Years := W.Years.F.AsInteger;
            Months := W.Months.F.AsInteger;
            Annotation := W.Annotation.F.AsString;
            IsEnabled := W.Enable_SpecialityEducation.F.AsInteger = 1;
            Locked := W.Locked.F.AsInteger = 1;
            Portal := W.Portal.F.AsInteger = 1;
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
