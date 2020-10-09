unit CourseEdTypesQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TCourseEdTypeW = class;

  TQueryCourseEdType = class(TQueryBase)
  private
    FW: TCourseEdTypeW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function Search(AIDEducation: Integer): Integer;
    property W: TCourseEdTypeW read FW;
    { Public declarations }
  end;

  TCourseEdTypeW = class(TDSWrap)
  private
    FID_Education: TFieldWrap;
    FID_EducationType: TFieldWrap;
    FShort_Education_Type: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_Education: TFieldWrap read FID_Education;
    property ID_EducationType: TFieldWrap read FID_EducationType;
    property Short_Education_Type: TFieldWrap read FShort_Education_Type;
  end;

implementation

constructor TCourseEdTypeW.Create(AOwner: TComponent);
begin
  inherited;
  FID_EducationType := TFieldWrap.Create(Self, 'ID_EducationType');
  PKFieldName := FID_EducationType.FieldName;
  FShort_Education_Type := TFieldWrap.Create(Self, 'Short_Education_Type');
  FID_Education := TFieldWrap.Create(Self, 'ID_Education');
end;

constructor TQueryCourseEdType.Create(AOwner: TComponent);
begin
  inherited;
  FW := TCourseEdTypeW.Create(FDQuery);
end;

function TQueryCourseEdType.Search(AIDEducation: Integer): Integer;
begin
  Assert(AIDEducation > 0);

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s <> :%s', [W.ID_Education.FieldName, W.ID_Education.FieldName]));
  SetParamType(W.ID_Education.FieldName);

  Result := W.Load([W.ID_Education.FieldName], [AIDEducation]);
end;

{$R *.dfm}

end.
