unit MaxSpecSessQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TMaxSpecSessW = class(TDSWrap)
  private
    FIDSpecialityEducation: TFieldWrap;
    FLevel: TParamWrap;
    FMax_Level: TFieldWrap;
    FMax_Level_Year: TFieldWrap;
    FMax_Session_in_Level: TFieldWrap;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property IDSpecialityEducation: TFieldWrap read FIDSpecialityEducation;
    property Level: TParamWrap read FLevel;
    property Max_Level: TFieldWrap read FMax_Level;
    property Max_Level_Year: TFieldWrap read FMax_Level_Year;
    property Max_Session_in_Level: TFieldWrap read FMax_Session_in_Level;
  end;

  TQryMaxSpecSess = class(TQueryBase)
  private
    FW: TMaxSpecSessW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchBy(AIDSpecEd, ALevel: Integer;
      TestResult: Boolean = False): Integer;
    function SearchBySpecEd(AIDSpecEd: Integer): Integer;
    property W: TMaxSpecSessW read FW;
    { Public declarations }
  end;

implementation

uses
  System.Math;

constructor TMaxSpecSessW.Create(AOwner: TComponent);
begin
  inherited;
  FIDSpecialityEducation := TFieldWrap.Create(Self, 'IDSpecialityEducation',
    '', True);
  FMax_Level := TFieldWrap.Create(Self, 'Max_level');
  FMax_Level_Year := TFieldWrap.Create(Self, 'Max_Level_Year');
  FMax_Session_in_Level := TFieldWrap.Create(Self, 'Max_Session_in_Level');

  // Параметры
  FLevel := TParamWrap.Create(Self, 'Level_');
end;

constructor TQryMaxSpecSess.Create(AOwner: TComponent);
begin
  inherited;
  FW := TMaxSpecSessW.Create(FDQuery);
end;

function TQryMaxSpecSess.SearchBy(AIDSpecEd, ALevel: Integer;
  TestResult: Boolean = False): Integer;
begin
  Assert(AIDSpecEd > 0);
  Result := SearchEx([TParamRec.Create(W.IDSpecialityEducation.FullName,
    AIDSpecEd), TParamRec.Create(W.Level.FullName, ALevel)],
    IfThen(TestResult, 1, -1));

  // Значение параметра будет являться значением по умолчанию
  W.IDSpecialityEducation.DefaultValue := AIDSpecEd;
end;

function TQryMaxSpecSess.SearchBySpecEd(AIDSpecEd: Integer): Integer;
begin
  Assert(AIDSpecEd > 0);
  Result := SearchEx([TParamRec.Create(W.IDSpecialityEducation.FullName,
    AIDSpecEd)]);

  // Значение параметра будет являться значением по умолчанию
  W.IDSpecialityEducation.DefaultValue := AIDSpecEd;
end;

{$R *.dfm}

end.
