unit SpecEdSimpleQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, SpecEdSimpleInt,
  InsertEditMode, SpecEdSimpleWrap;

type
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

implementation

uses
  DeleteCSEQuery, DeleteSPQuery, System.Math;

constructor TQuerySpecEdSimple.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecEdSimpleW.Create(FDQuery);
  FDQuery.UpdateOptions.CheckRequired := False;
  FDQuery.UpdateOptions.KeyFields := W.PKFieldName;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
  FDQuery.UpdateOptions.RefreshMode := rmAll;
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
