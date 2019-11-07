unit FR3;

interface

uses
  System.Classes, FRDataModule, FastReportSettings;

type
  // Синглтон.
  TFR3 = class(TObject)
  private
    class var Instance: TFR3;

  var
    FFRDM: TFRDM;
  public
    constructor Create;
    destructor Destroy; override;
    class function NewInstance: TObject; override;
    procedure Show(const AFileName: string; const AParamNames: TArray<String>;
      const AParamValues: TArray<Variant>); overload;
    procedure Show(AFRSettings: TFRSettings); overload;
  end;

implementation

uses
  System.Contnrs, System.SysUtils, System.Variants, Vcl.Forms, Vcl.Controls;

var
  SingletonList: TObjectList;

constructor TFR3.Create;
begin
  inherited;
  FFRDM := TFRDM.Create(nil);
end;

destructor TFR3.Destroy;
begin
  FreeAndNil(FFRDM);
  inherited;
end;

class function TFR3.NewInstance: TObject;
begin
  if not Assigned(Instance) then
  begin
    Instance := TFR3(inherited NewInstance);
    SingletonList.Add(Instance);
  end;

  Result := Instance;
end;

procedure TFR3.Show(const AFileName: string; const AParamNames: TArray<String>;
  const AParamValues: TArray<Variant>);
var
  AErrors: string;
  i: Integer;
  Ok: Boolean;
  S: String;
//  V: Variant;
//  VarCount: Integer;
begin
  Assert(Low(AParamNames) = Low(AParamValues));
  Assert(High(AParamNames) = High(AParamValues));
  Assert(not AFileName.IsEmpty);

  Screen.Cursor := crHourGlass;
  try

    // Загружаем отчёт из файла
    FFRDM.frxReport.LoadFromFile(AFileName);

    // Очищаем список переменных отчёта
    // В отчёте могут быть доп переменные не требующие инициализации
    //FFRDM.frxReport.Variables.Clear;

//    VarCount := FFRDM.frxReport.Variables.Count;
//    Assert(VarCount >= Length(AParamNames));

    // Устанавливаем параметры отчёта в цикле
    for i := Low(AParamNames) to High(AParamNames) do
    begin
      if VarIsStr(AParamValues[i]) then
      begin
        S := QuotedStr(VarToStr(AParamValues[i]));
        FFRDM.frxReport.Variables[AParamNames[i]] := S;
      end
      else
        FFRDM.frxReport.Variables[AParamNames[i]] := AParamValues[i];
    end;

    Ok := FFRDM.frxReport.PrepareReport();
    if Ok then
      FFRDM.frxReport.ShowPreparedReport
  finally
    Screen.Cursor := crDefault;
  end;

  // Получаем сообщения об ошибке
  AErrors := FFRDM.frxReport.Errors.Text;
  if not AErrors.IsEmpty then
    raise Exception.CreateFmt
      ('В ходе подготовки отчета %s произошла ошибка.'#13#10 + AErrors,
      [AFileName]);
end;

procedure TFR3.Show(AFRSettings: TFRSettings);
begin
  Show(AFRSettings.FileName, AFRSettings.ParamNames, AFRSettings.ParamValues)
end;

initialization

SingletonList := TObjectList.Create(True);

finalization

FreeAndNil(SingletonList);

end.
