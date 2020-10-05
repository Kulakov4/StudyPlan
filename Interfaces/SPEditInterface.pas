unit SPEditInterface;

interface

uses
  EdQuery, ChairsQuery, SpecByChairQry, QualificationQuery, SPStandartQuery,
  SpecEditInterface, SpecEdSimpleInt, SpecInt, InsertEditMode, FDDumb,
  SpecEdSimpleWrap;

type
  ISPEdit = interface(IInterface)
    procedure Cancel;
    function GetEdW: TEdW; stdcall;
    function GetEnabledChairsW: TChairsW; stdcall;
    function GetIDYearW: TDumbW;
    function GetQualificationsW: TQualificationsW; stdcall;
    function GetSpecByChairW: TSpecByChairW; stdcall;
    function GetSpecEditI: ISpecEdit;
    function GetSpecEdSimpleW: TSpecEdSimpleW;
    function GetSPStandartW: TSPStandartW; stdcall;
    procedure Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode; ASpec: ISpec);
    function SearchSpecByChair(AIDEducationLevel, AIDChair: Integer): Integer;
    property EdW: TEdW read GetEdW;
    property EnabledChairsW: TChairsW read GetEnabledChairsW;
    property IDYearW: TDumbW read GetIDYearW;
    property QualificationsW: TQualificationsW read GetQualificationsW;
    property SpecByChairW: TSpecByChairW read GetSpecByChairW;
    property SpecEdSimpleW: TSpecEdSimpleW read GetSpecEdSimpleW;
    property SPStandartW: TSPStandartW read GetSPStandartW;
  end;

implementation

end.
