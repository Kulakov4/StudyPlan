unit SpecEdSimpleQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, SpecEdSimpleInt,
  InsertEditMode;

type
  TSpecEdSimpleW = class;

  TQuerySpecEdSimple = class(TQueryBase)
    procedure FDQueryUpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest;
      var AAction: TFDErrorAction; AOptions: TFDUpdateRowOptions);
  private
    FW: TSpecEdSimpleW;
    procedure ApplyDelete;
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function SearchByPK(APKValue: Integer; ATestResult: Boolean = False): Integer;
    property W: TSpecEdSimpleW read FW;
    { Public declarations }
  end;

  TSpecEdSimpleW = class(TDSWrap)
  private
    FAnnotation: TFieldWrap;
    FPortal: TFieldWrap;
    FData: TFieldWrap;
    FEnable_SpecialityEducation: TFieldWrap;
    FIDChair: TFieldWrap;
    FIDArea: TFieldWrap;
    FLocked: TFieldWrap;
    FIDEducation: TFieldWrap;
    FIDEducation2: TFieldWrap;
    FIDEducationLevel: TFieldWrap;
    FIDQualification: TFieldWrap;
    FIDSpeciality: TFieldWrap;
    FIDStudyPlanStandart: TFieldWrap;
    FID_SPECIALITYEDUCATION: TFieldWrap;
    FMount_of_year: TFieldWrap;
    FYears: TFieldWrap;
    FYear: TFieldWrap;
    FMonths: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode;
      ASpecialityIDQualification: Integer);
    property Annotation: TFieldWrap read FAnnotation;
    property Portal: TFieldWrap read FPortal;
    property Data: TFieldWrap read FData;
    property Enable_SpecialityEducation: TFieldWrap read
        FEnable_SpecialityEducation;
    property IDChair: TFieldWrap read FIDChair;
    property IDArea: TFieldWrap read FIDArea;
    property Locked: TFieldWrap read FLocked;
    property IDEducation: TFieldWrap read FIDEducation;
    property IDEducation2: TFieldWrap read FIDEducation2;
    property IDEducationLevel: TFieldWrap read FIDEducationLevel;
    property IDQualification: TFieldWrap read FIDQualification;
    property IDSpeciality: TFieldWrap read FIDSpeciality;
    property IDStudyPlanStandart: TFieldWrap read FIDStudyPlanStandart;
    property ID_SPECIALITYEDUCATION: TFieldWrap read FID_SPECIALITYEDUCATION;
    property Mount_of_year: TFieldWrap read FMount_of_year;
    property Years: TFieldWrap read FYears;
    property Year: TFieldWrap read FYear;
    property Months: TFieldWrap read FMonths;
  end;

implementation

uses
  DeleteCSEQuery, DeleteSPQuery, System.Math;

constructor TSpecEdSimpleW.Create(AOwner: TComponent);
begin
  inherited;
  FID_SPECIALITYEDUCATION := TFieldWrap.Create(Self, 'ID_SPECIALITYEDUCATION',
    '', True);
  FIDSpeciality := TFieldWrap.Create(Self, 'IDSpeciality');
  FData := TFieldWrap.Create(Self, 'DATA_');
  FIDChair := TFieldWrap.Create(Self, 'IDChair');
  FIDEducation2 := TFieldWrap.Create(Self, 'IDEducation2');
  FIDEducation := TFieldWrap.Create(Self, 'IDEducation');
  FYear := TFieldWrap.Create(Self, 'Year');
  FMount_of_year := TFieldWrap.Create(Self, 'Mount_of_year');
  FIDStudyPlanStandart := TFieldWrap.Create(Self, 'IDStudyPlanStandart');
  FIDEducationLevel := TFieldWrap.Create(Self, 'IDEducationLevel');
  FAnnotation := TFieldWrap.Create(Self, 'Annotation', 'Примечание');
  FYears := TFieldWrap.Create(Self, 'Years');
  FMonths := TFieldWrap.Create(Self, 'Months');
  FIDQualification := TFieldWrap.Create(Self, 'IDQualification');
  FIDArea := TFieldWrap.Create(Self, 'IDArea');
  FLocked := TFieldWrap.Create(Self, 'Locked');
  FPortal := TFieldWrap.Create(Self, 'PORTAL');
  FEnable_SpecialityEducation := TFieldWrap.Create(Self, 'Enable_SpecialityEducation');
end;

constructor TQuerySpecEdSimple.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecEdSimpleW.Create(FDQuery);
end;

procedure TQuerySpecEdSimple.FDQueryUpdateRecord(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  inherited;
  // Каскадно удалим всё, что зависит от SpecialityEducation
  if ARequest = arDelete then
    ApplyDelete;
end;

function TQuerySpecEdSimple.SearchByPK(APKValue: Integer; ATestResult: Boolean
    = False): Integer;
begin
  // Assert(APKValue > 0);

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.PKFieldName, W.PKFieldName]));

  SetParamType(W.PKFieldName);

  Result := W.Load([W.PKFieldName], [APKValue]);

  if ATestResult then
    Assert(Result = 1);
end;

{$R *.dfm}

procedure TSpecEdSimpleW.Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode;
  ASpecialityIDQualification: Integer);
var
  ASpecEdSimpleEx: ISpecEdSimpleEx;
begin
  if AMode = EditMode then
    TryEdit
  else
    TryAppend;

  IDEducation2.F.AsInteger := ASpecEdSimple.IDEducation2;
  IDEducationLevel.F.AsInteger := ASpecEdSimple.IDEducationLevel;
  IDChair.F.AsInteger := ASpecEdSimple.IDChair;
  IDSpeciality.F.AsInteger := ASpecEdSimple.IDSpeciality;
  IDStudyPlanStandart.F.AsInteger := ASpecEdSimple.IDStandart;

  // Если квалификация выбрана как в специальности
  if ASpecialityIDQualification = ASpecEdSimple.IDQualification then
    IDQualification.F.AsInteger := 0
  else
    IDQualification.F.AsInteger := ASpecEdSimple.IDQualification;

  Years.F.AsInteger := ASpecEdSimple.Years;
  Months.F.AsInteger := ASpecEdSimple.Months;
  Annotation.F.AsString := ASpecEdSimple.Annotation;
  Enable_SpecialityEducation.F.AsInteger := IfThen(ASpecEdSimple.IsEnabled, 1, 0);
  Locked.F.AsInteger := IfThen(ASpecEdSimple.Locked, 1, 0);
  Portal.F.AsInteger := IfThen(ASpecEdSimple.Portal, 1, 0);

  ASpecEdSimple.QueryInterface(ISpecEdSimpleEx, ASpecEdSimpleEx);
  // Заполняем идентификатор сферы для переподготовки
  if ASpecEdSimpleEx <> nil then
  begin
    if ASpecEdSimpleEx.IDArea > 0 then
      IDArea.F.AsInteger := ASpecEdSimpleEx.IDArea
    else
      IDArea.F.Value := NULL;
  end;

  try
    TryPost;
  except
    TryCancel;
    raise;
  end;
end;

procedure TQuerySpecEdSimple.ApplyDelete;
begin
  Assert(W.ID_SPECIALITYEDUCATION.F.AsInteger > 0);

  // *********************************************
  // Ищем дисциплины учебного плана
  // *********************************************
  TQryDeleteSP.Delete(W.ID_SPECIALITYEDUCATION.F.AsInteger);

  // *********************************************
  // Удаляем циклы учебного плана
  // *********************************************
  TQryDeleteCSE.Delete(W.ID_SPECIALITYEDUCATION.F.AsInteger);

  // Сессии учебного плана удаляет триггер!
end;

end.
