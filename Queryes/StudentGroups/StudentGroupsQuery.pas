unit StudentGroupsQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, NotifyEvents,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait;

type
  TStudentGroupsW = class;

  TQueryStudentGroups = class(TQueryBase)
    procedure FDQueryAfterApplyUpdates(DataSet: TFDDataSet; AErrors: Integer);
  private
    FW: TStudentGroupsW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function Search(AIDSpecialityEducation: Integer; AIsEnable: Boolean): Integer;
    property W: TStudentGroupsW read FW;
    { Public declarations }
  end;

  TStudentGroupsW = class(TDSWrap)
  private
    FID: TFieldWrap;
    FName: TFieldWrap;
    FEnabled: TFieldWrap;
    FStart_Year: TFieldWrap;
    FAdmission_ID: TFieldWrap;
    FStart_Year_DefaultValue: Integer;
    FStudent_Count: TFieldWrap;
    procedure DoBeforePost(Sender: TObject);
    procedure DoOnIDChange(Sender: TField);
  protected
    procedure DoAfterOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property ID: TFieldWrap read FID;
    property Name: TFieldWrap read FName;
    property Enabled: TFieldWrap read FEnabled;
    property Start_Year: TFieldWrap read FStart_Year;
    property Admission_ID: TFieldWrap read FAdmission_ID;
    property Start_Year_DefaultValue: Integer read FStart_Year_DefaultValue write
        FStart_Year_DefaultValue;
    property Student_Count: TFieldWrap read FStudent_Count;
  end;

implementation

uses
  System.Math, CreateVirtualStudentQuery, DropVirtualStudentQuery;

constructor TStudentGroupsW.Create(AOwner: TComponent);
begin
  inherited;
  FID := TFieldWrap.Create(Self, 'ID');
  PKFieldName := FID.FieldName;

  FName := TFieldWrap.Create(Self, 'Name', 'Наименование');
  FEnabled := TFieldWrap.Create(Self, 'Enabled');
  FStart_Year := TFieldWrap.Create(Self, 'Start_Year');
  FStudent_Count := TFieldWrap.Create(Self, 'Student_Count', 'Кол-во студентов');

  // Это поле не выбирается, но используется при поиске !
  FAdmission_ID := TFieldWrap.Create(Self, 'Admission_ID');

  TNotifyEventWrap.Create(AfterOpen, DoAfterOpen, EventList);
  TNotifyEventWrap.Create(BeforePost, DoBeforePost, EventList);
end;

procedure TStudentGroupsW.DoAfterOpen(Sender: TObject);
begin
  Student_Count.F.ProviderFlags := [];
  ID.F.OnChange := DoOnIDChange;
end;

procedure TStudentGroupsW.DoBeforePost(Sender: TObject);
begin
  if FStart_Year_DefaultValue > 0 then
    Start_Year.F.AsInteger := FStart_Year_DefaultValue;
end;

constructor TQueryStudentGroups.Create(AOwner: TComponent);
begin
  inherited;
  FW := TStudentGroupsW.Create(FDQuery);
  FDQuery.CachedUpdates := True;
end;

function TQueryStudentGroups.Search(AIDSpecialityEducation: Integer; AIsEnable:
    Boolean): Integer;
begin
  Assert(AIDSpecialityEducation > 0);

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.Admission_ID.FieldName, W.Admission_ID.FieldName]));


  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s=:%s', [W.Enabled.FieldName, W.Enabled.FieldName]));

  SetParamType(W.Admission_ID.FieldName);
  SetParamType(W.Enabled.FieldName);

  Result := W.Load([W.Admission_ID.FieldName, W.Enabled.FieldName],
    [AIDSpecialityEducation, IfThen(AIsEnable, 1, 0)]);
end;

{$R *.dfm}

procedure TStudentGroupsW.DoOnIDChange(Sender: TField);
var
  V: Variant;
  V2: Variant;
begin
  V := Sender.NewValue;
  V2 := Sender.OldValue;
end;

procedure TQueryStudentGroups.FDQueryAfterApplyUpdates(DataSet: TFDDataSet;
    AErrors: Integer);
var
  AAdmission_ID: Integer;
begin
  inherited;

  // Дополнительно обрабатываем добавленные группы
  FDQuery.FilterChanges := [rtInserted];
  FDQuery.First;
  while not FDQuery.Eof do
  begin
    AAdmission_ID := FDQuery.ParamByName(W.Admission_ID.FieldName).AsInteger;
    TQueryCreateVirtualStudent.Execute(W.PK.AsInteger, AAdmission_ID);
    FDQuery.Next;
  end;

  // Дополнительно обрабатываем удалённые группы
  FDQuery.FilterChanges := [rtDeleted];
  FDQuery.First;
  while not FDQuery.Eof do
  begin
    TQueryDropVirtualStudent.Execute(W.PK.AsInteger);
    FDQuery.Next
  end;

  FDQuery.FilterChanges := [rtUnmodified, rtInserted, rtModified];
end;

end.
