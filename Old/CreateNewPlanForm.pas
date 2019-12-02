unit CreateNewPlanForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Item, StdCtrls, TB2Dock, TB2Toolbar, Education, EducationLevel,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, Chairs, SPUnit, SpecEducation, Menus,
  cxLookAndFeelPainters, cxButtons, Specialitys, cxGraphics, cxLookAndFeels,
  cxDBEdit, StudyPlanStandarts, cxButtonEdit, cxLabel, cxCheckBox,
  Qualifications;

type
  TfrmCreateNewStudyPlan = class(TForm)
    tbdckTop: TTBDock;
    tbEducationLevel: TTBToolbar;
    TBControlItem1: TTBControlItem;
    lbl3: TLabel;
    tbEducation: TTBToolbar;
    TBControlItem2: TTBControlItem;
    Label1: TLabel;
    tbYears: TTBToolbar;
    TBControlItem3: TTBControlItem;
    Label2: TLabel;
    cxmeYears: TcxMaskEdit;
    TBControlItem4: TTBControlItem;
    TBControlItem5: TTBControlItem;
    Label3: TLabel;
    TBControlItem6: TTBControlItem;
    cxmeMonths: TcxMaskEdit;
    tbYear: TTBToolbar;
    TBControlItem7: TTBControlItem;
    Label4: TLabel;
    TBControlItem8: TTBControlItem;
    cxmeYear: TcxMaskEdit;
    btnClose: TcxButton;
    tbSpecialitys: TTBToolbar;
    TBControlItem9: TTBControlItem;
    Label5: TLabel;
    tbStudyPlanStandart: TTBToolbar;
    TBControlItem10: TTBControlItem;
    Label6: TLabel;
    TBToolbar2: TTBToolbar;
    TBControlItem12: TTBControlItem;
    TBControlItem13: TTBControlItem;
    Label7: TLabel;
    cxdbteChiperCode: TcxDBTextEdit;
    tbAnnotation: TTBToolbar;
    TBControlItem11: TTBControlItem;
    Label8: TLabel;
    cxteAnnotation: TcxTextEdit;
    TBControlItem14: TTBControlItem;
    cxdbbeSpecialitys: TcxDBButtonEdit;
    TBControlItem15: TTBControlItem;
    TBToolbar1: TTBToolbar;
    TBControlItem16: TTBControlItem;
    Label9: TLabel;
    cxdbbeQualification: TcxDBButtonEdit;
    TBControlItem17: TTBControlItem;
    cxcbQualification: TcxCheckBox;
    TBControlItem18: TTBControlItem;
    TBToolbar3: TTBToolbar;
    Label10: TLabel;
    TBControlItem19: TTBControlItem;
    cxdbbeChairs: TcxDBButtonEdit;
    TBControlItem20: TTBControlItem;
    procedure cxcbQualificationClick(Sender: TObject);
    procedure cxdbbeSpecialitysPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxdbbeQualificationPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxdbbeChairsPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    FChairs: TChairs;
    FEducation: TEducation;
    FEducationLevel: TEducationLevel;
    FQualifications: TQualifications;
    FSpecEducation: TSpecEducation;
    FSpecialitys: TSpecialitys;
    FStudyPlanStandarts: TStudyPlanStandarts;
    function GetAnnotation: string;
    function GetIDChair: Integer;
    function GetIDEducation: Integer;
    function GetIDQualification: Integer;
    function GetIDSpeciality: Integer;
    function GetIDStudyPlanStandart: Integer;
    function GetMonths: Integer;
    function GetYear: Integer;
    function GetYears: Integer;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property Annotation: string read GetAnnotation;
    property IDChair: Integer read GetIDChair;
    property IDEducation: Integer read GetIDEducation;
    property IDQualification: Integer read GetIDQualification;
    property IDSpeciality: Integer read GetIDSpeciality;
    property IDStudyPlanStandart: Integer read GetIDStudyPlanStandart;
    property Months: Integer read GetMonths;
    property Year: Integer read GetYear;
    property Years: Integer read GetYears;
    { Public declarations }
  end;

implementation

uses StudyProcessTools, GridComboBox, CommissionOptions, GridComboBoxViewEx,
NotifyEvents, SpecialitysGridComboBoxView, ViewFormEx, SpecialityGridView,
EssenceGridView;

{$R *.dfm}

constructor TfrmCreateNewStudyPlan.Create(AOwner: TComponent);
begin
  inherited;
  FSpecEducation := AOwner as TSpecEducation;
  cxmeYears.Text := FSpecEducation.DS.FieldByName('Years').AsString;
  cxmeMonths.Text := FSpecEducation.DS.FieldByName('Months').AsString;

  {**** Инициализация кафедры ****}
  FChairs := TChairs.Create(Self);
  FChairs.Refresh;
  // Ищем кафедру как у учебного плана!
  FChairs.Wrap.LocateByPK( FSpecEducation.IDCHAIR.AsInteger );
  cxdbbeChairs.DataBinding.DataSource := FChairs.Wrap.DataSource;
  cxdbbeChairs.DataBinding.DataField := FChairs.Department.FieldName;
  {********}

  {**** Инициализация стандарта ****}
  FStudyPlanStandarts := TStudyPlanStandarts.Create(Self);
  FStudyPlanStandarts.Refresh;
  FStudyPlanStandarts.Wrap.LocateByPK(FSpecEducation.IDStudyPlanStandart.AsInteger);
  with TcxGridCBViewEx.Create(Self, tbStudyPlanStandart) do
  begin
    ListFieldName := FStudyPlanStandarts.STUDYPLANSTANDART.FieldName;
    cxExtLookupComboBox.Width := 100;
    SetDocument(FStudyPlanStandarts.Wrap);
  end;
  {********}

  {**** Инициализация вида образования ****}
  FEducationLevel := TEducationLevel.Create(Self);
  FEducationLevel.Refresh;
  FEducationLevel.Wrap.LocateByPK(FSpecEducation.IDEducationLevel.AsInteger);
  // Создаём представление для вида образования в виде выпадающего списка
  with TcxGridComboBoxView.Create(Self, tbEducationLevel) do
  begin
    cxExtLookupComboBox.Width := 500;
    ListFieldName := FEducationLevel.EDUCATION_LEVEL.FieldName;
    SetDocument(FEducationLevel.DataSetWrap);
  end;
  {********}

  {**** Инициализация формы обучения ****}
  FEducation := TEducation.Create(Self);
  FEducation.FieldsSynonym.Delete(0);
//  FEducation.EducationLevel.Master := FEducationLevel;
  FEducation.DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  FEducation.Refresh;
  FEducation.Wrap.LocateByPK(FSpecEducation.ID_Education.AsInteger);
  // Создаём представление для формы обучения в виде выпадающего списка
  with TcxGridComboBoxView.Create(Self, tbEducation) do
  begin
    cxExtLookupComboBox.Width := 500;
    ListFieldName := FEducation.EDUCATION.FieldName;
    SetDocument(FEducation.DataSetWrap);
  end;
  {********}

  {**** Инициализация специальностей ****}
  FSpecialitys := TSpecialitysEx.Create(Self);
  if not FSpecEducation.chiper_speciality.IsNull then
  begin
    FSpecialitys.ChiperSpecialityParam.Negative := True;
    FSpecialitys.ChiperSpecialityParam.ParamValue := NULL;
  end;
  FSpecialitys.Refresh;
  // В списке специальностей ищем текущую специальность учебного плана
  FSpecialitys.Wrap.LocateByPK(FSpecEducation.ID_Speciality.AsInteger);
  cxdbteChiperCode.DataBinding.DataSource := FSpecialitys.DataSetWrap.DataSource;
  cxdbteChiperCode.DataBinding.DataField :=  FSpecialitys.chiper_speciality.FieldName;
  cxdbbeSpecialitys.DataBinding.DataSource := FSpecialitys.DataSetWrap.DataSource;
  cxdbbeSpecialitys.DataBinding.DataField :=  FSpecialitys.Speciality.FieldName;
  {********}

  {**** Инициализация квалификаций ****}
  FQualifications := TQualifications.Create(Self);
  FQualifications.Refresh;

  // Включаем галочку "Как в специальности"
  if FSpecEducation.IDQualificationEx.AsInteger <> 0 then
  begin
    cxcbQualification.Checked := FSpecEducation.IDQualification.IsNull;
    FQualifications.Wrap.LocateByPK( FSpecEducation.IDQualificationEx.AsInteger );
  end;
  cxcbQualificationClick(cxcbQualification);
  {********}

  {**** Инициализация года набора ****}
  cxmeYear.Text := FSpecEducation.Year.AsString;
  {********}

  {**** Инициализация аннотаций ****}
  cxteAnnotation.Text := FSpecEducation.Annotation.AsString;
  {********}

(*
  with TcxSpecialitysGridCBViewEx.Create(Self, tbSpecialitys) do
  begin
    KeyFieldName := 'ID_Speciality';
    ListFieldName := 'Speciality';
    cxexlcb1.Width := 800;
    SetDocument(FSpecialitys.Wrap);
  end;
*)
end;

procedure TfrmCreateNewStudyPlan.cxcbQualificationClick(Sender: TObject);
begin
  // Если включена галочка "как в специальности"
  if cxcbQualification.Checked then
  begin
    cxdbbeQualification.DataBinding.DataSource := FSpecialitys.DataSetWrap.DataSource;
    cxdbbeQualification.DataBinding.DataField := 'Qualification';
    cxcbQualification.Enabled := False;
  end
  else
  begin
    cxdbbeQualification.DataBinding.DataSource := FQualifications.DataSetWrap.DataSource;
    cxdbbeQualification.DataBinding.DataField := 'Qualification';
    cxcbQualification.Enabled := True;
  end;
end;

procedure TfrmCreateNewStudyPlan.cxdbbeChairsPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmChairs: TfrmViewEx;
begin
  frmChairs := TfrmViewEx.Create(Self, 'Кафедры',
    'ChairsForm', [mbOk]);
  try
       frmChairs.ViewClass := TdsgvEssence;
       frmChairs.View.SetDocument(FChairs);
       frmChairs.ShowModal;
  finally
    FreeAndNil(frmChairs);
  end;
end;

procedure TfrmCreateNewStudyPlan.cxdbbeQualificationPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  AIDQualification: Integer;
  frmQualifications: TfrmViewEx;
begin
  if cxcbQualification.Checked then
  begin
    AIDQualification := FSpecialitys.Field('Qualification_ID').AsInteger;
    FQualifications.DataSetWrap.LocateByPK(AIDQualification);
  end;


  frmQualifications := TfrmViewEx.Create(Self, 'Квалификации',
    'QualifacationForm', [mbOk]);
  try
       frmQualifications.ViewClass := TdsgvEssence;
       (frmQualifications.View as TdsgvEssence).cxgridDBBandedTableView.OptionsView.BandHeaders := False;
       frmQualifications.View.SetDocument(FQualifications);
       if frmQualifications.ShowModal = mrOk then
       begin
         cxcbQualification.Checked := FQualifications.PKValue = FSpecialitys.Field('Qualification_ID').Value;
       end;
  finally
    FreeAndNil(frmQualifications);
  end;
end;

procedure TfrmCreateNewStudyPlan.cxdbbeSpecialitysPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmSpecialitys: TfrmViewEx;
begin
  frmSpecialitys := TfrmViewEx.Create(Self, 'Специальности',
    'SpecialitysForm', [mbOk]);
  try
       frmSpecialitys.ViewClass := TdsgvSpecialitys;
       frmSpecialitys.View.SetDocument(FSpecialitys);
       frmSpecialitys.ShowModal;
  finally
    FreeAndNil(frmSpecialitys);
  end;
end;

function TfrmCreateNewStudyPlan.GetAnnotation: string;
begin
  Result := cxteAnnotation.Text;
end;

function TfrmCreateNewStudyPlan.GetIDChair: Integer;
begin
  Result := FChairs.PKValue; //  FSpecialitys.Field('SPECIALITY_ACCESS').AsInteger;;
end;

function TfrmCreateNewStudyPlan.GetIDEducation: Integer;
begin
  Result := FEducation.PKValue;
end;

function TfrmCreateNewStudyPlan.GetIDQualification: Integer;
begin
  if cxcbQualification.Checked then
    Result := 0
  else
    Result := FQualifications.PKValue;
end;

function TfrmCreateNewStudyPlan.GetIDSpeciality: Integer;
begin
  Result := FSpecialitys.Field('ID_Speciality').AsInteger;
end;

function TfrmCreateNewStudyPlan.GetIDStudyPlanStandart: Integer;
begin
  Result := FStudyPlanStandarts.PKValue
end;

function TfrmCreateNewStudyPlan.GetMonths: Integer;
begin
  Result := StrToInt(cxmeMonths.Text);
end;

function TfrmCreateNewStudyPlan.GetYear: Integer;
begin
  Result := StrToInt(cxmeYear.Text);
end;

function TfrmCreateNewStudyPlan.GetYears: Integer;
begin
  Result := StrToInt(cxmeYears.Text);
end;

end.