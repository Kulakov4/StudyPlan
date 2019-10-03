unit SpecByChairQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, SpecInt,
  InsertEditMode, FireDACDataModule;

type
  TSpecByChairW = class;

  TQrySpecByChair = class(TQueryBase)
    FDUpdateSQL: TFDUpdateSQL;
    procedure FDQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    FW: TSpecByChairW;
    procedure DoBeforePost(Sender: TObject);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ASpecInt: ISpec; AMode: TMode);
    function Search(AIDEducationLevel, AIDChair: Integer): Integer;
    property W: TSpecByChairW read FW;
    { Public declarations }
  end;

  TSpecByChairW = class(TDSWrap)
  private
    FCalcSpeciality: TFieldWrap;
    FChiper_Speciality: TFieldWrap;
    FEnable_Speciality: TFieldWrap;
    FIDChair: TFieldWrap;
    FIDEducationLevel: TFieldWrap;
    FID_Speciality: TFieldWrap;
    FQUALIFICATION_ID: TFieldWrap;
    FSHORT_SPECIALITY: TFieldWrap;
    FSpeciality: TFieldWrap;
    FSPECIALITY_ACCESS: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ASpecInt: ISpec; AMode: TMode);
    property CalcSpeciality: TFieldWrap read FCalcSpeciality;
    property Chiper_Speciality: TFieldWrap read FChiper_Speciality;
    property Enable_Speciality: TFieldWrap read FEnable_Speciality;
    property IDChair: TFieldWrap read FIDChair;
    property IDEducationLevel: TFieldWrap read FIDEducationLevel;
    property ID_Speciality: TFieldWrap read FID_Speciality;
    property QUALIFICATION_ID: TFieldWrap read FQUALIFICATION_ID;
    property SHORT_SPECIALITY: TFieldWrap read FSHORT_SPECIALITY;
    property Speciality: TFieldWrap read FSpeciality;
    property SPECIALITY_ACCESS: TFieldWrap read FSPECIALITY_ACCESS;
  end;

implementation

uses
  NotifyEvents, FireDAC.Phys.OracleWrapper;

constructor TSpecByChairW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Speciality := TFieldWrap.Create(Self, 'ID_Speciality', '', True);

  FSpeciality := TFieldWrap.Create(Self, 'Speciality', 'Наименование');
  FSHORT_SPECIALITY := TFieldWrap.Create(Self, 'SHORT_SPECIALITY',
    'Сокращение');
  FSPECIALITY_ACCESS := TFieldWrap.Create(Self, 'SPECIALITY_ACCESS');
  FChiper_Speciality := TFieldWrap.Create(Self, 'Chiper_Speciality', 'Код');
  FEnable_Speciality := TFieldWrap.Create(Self, 'Enable_Speciality');
  FCalcSpeciality := TFieldWrap.Create(Self, 'CalcSpeciality',
    'Наименование и код');
  FQUALIFICATION_ID := TFieldWrap.Create(Self, 'QUALIFICATION_ID');

  // По этому полю стоит фильтр в запросе
  FIDEducationLevel := TFieldWrap.Create(Self, 'IDEducationLevel');
  FIDChair := TFieldWrap.Create(Self, 'IDChair');
end;

procedure TSpecByChairW.Save(ASpecInt: ISpec; AMode: TMode);
begin
  Assert(ASpecInt <> nil);

  if AMode = EditMode then
    TryEdit
  else
    TryAppend;
  try
    Chiper_Speciality.F.AsString := ASpecInt.ChiperSpeciality;
    Speciality.F.AsString := ASpecInt.Speciality;
    SHORT_SPECIALITY.F.AsString := ASpecInt.ShortSpeciality;

    TryPost;
  except
    TryCancel;
    raise;
  end;
end;

constructor TQrySpecByChair.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecByChairW.Create(FDQuery);

  FDQuery.UpdateOptions.CheckRequired := False;
  FDQuery.UpdateOptions.RefreshMode := rmAll;

  // Костыль !!!
  with FDUpdateSQL.Commands[arInsert].ParamByName('NEW_' + W.PKFieldName) do
  begin
    ParamType := ptOutput;
    DataType := ftInteger;
  end;

  TNotifyEventWrap.Create(W.BeforePost, DoBeforePost, W.EventList);
end;

procedure TQrySpecByChair.DoBeforePost(Sender: TObject);
begin
  W.SPECIALITY_ACCESS.F.Value := W.IDChair.DefaultValue;
end;

procedure TQrySpecByChair.Save(ASpecInt: ISpec; AMode: TMode);
begin
  W.Save(ASpecInt, AMode);
end;

function TQrySpecByChair.Search(AIDEducationLevel, AIDChair: Integer): Integer;
begin
  Assert(AIDEducationLevel > 0);
  Assert(AIDChair > 0);

  SetParamType(W.IDEducationLevel.FieldName);
  SetParamType(W.IDChair.FieldName);

  Result := W.Load([W.FIDEducationLevel.FieldName, W.IDChair.FieldName],
    [AIDEducationLevel, AIDChair]);

  W.IDEducationLevel.DefaultValue := AIDEducationLevel;
  W.IDChair.DefaultValue := AIDChair;
end;

{$R *.dfm}

procedure TQrySpecByChair.FDQueryPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  inherited;
  // Если нарушено ограничение уникальности ORA-0001
  if (E is EOCINativeException) and ((E as EOCINativeException).ErrorCode = 1)
  then
  begin
    // В штатном режиме у нас не должны появляться в базе не используемые специальности.
    // Либо эта специальность используется на другой кафедре, что странно!
    E.Message := 'Направление подготовки с таким наименованием уже есть в базе данных';
  end;
end;

end.
