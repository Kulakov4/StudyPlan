unit EditRetrainingPlanForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  EditStudyPlanForm, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit,
  cxDBExtLookupComboBox, Vcl.StdCtrls, cxButtons, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, InsertEditMode,
  SpecEdSimpleQuery, cxCheckBox, SpecEdSimpleInt, EditSpecFrm,
  EditRetrainingSpecFrm, FDDumb, SPRetrainingEditInterface;

type
  TfrmEditRetrainingPlan = class(TfrmEditStudyPlan, ISpecEdSimpleEx)
    cxdblcbArea: TcxDBLookupComboBox;
    Label9: TLabel;
    procedure cxdblcbAreaPropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
  private
    FqIDArea: TFDDumb;
    FSPRetrainingEditI: ISPRetrainingEdit;
    function GetIDArea: Integer;
    function GetqIDArea: TFDDumb;
    procedure SetIDArea(const Value: Integer);
    { Private declarations }
  protected
    procedure CheckQualification; override;
    function CreateEditSpecForm(AMode: TMode): TfrmEditSpec; override;
    procedure SetMode(const Value: TMode); override;
    property qIDArea: TFDDumb read GetqIDArea;
  public
    constructor Create(AOwner: TComponent;
      ASPRetrainingEditI: ISPRetrainingEdit; AMode: TMode); reintroduce;
    { Public declarations }
  published
    property IDArea: Integer read GetIDArea write SetIDArea;
  end;

implementation

uses
  DBLookupComboBoxHelper;

{$R *.dfm}

constructor TfrmEditRetrainingPlan.Create(AOwner: TComponent;
  ASPRetrainingEditI: ISPRetrainingEdit; AMode: TMode);
begin
  inherited Create(AOwner, ASPRetrainingEditI, AMode);
  FSPRetrainingEditI := ASPRetrainingEditI;

  // **********************************************
  // Сферы
  // **********************************************
  TDBLCB.Init(cxdblcbArea, qIDArea.W.ID, ASPRetrainingEditI.AreasW.AREA,
    lsEditList);
end;

procedure TfrmEditRetrainingPlan.CheckQualification;
begin; // Квалификация у переподготовки может быть пустой.
  // Может она вообще не нужна?
end;

function TfrmEditRetrainingPlan.CreateEditSpecForm(AMode: TMode): TfrmEditSpec;
begin
  Result := TfrmEditRetrainingSpec.Create(Self, SPEditI.GetSpecEditI, AMode);
end;

procedure TfrmEditRetrainingPlan.cxdblcbAreaPropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  inherited;
  if AText <> '' then
    FSPRetrainingEditI.AreasW.Append(AText);
end;

function TfrmEditRetrainingPlan.GetIDArea: Integer;
begin
  Result := qIDArea.W.ID.F.AsInteger;
end;

function TfrmEditRetrainingPlan.GetqIDArea: TFDDumb;
begin
  if FqIDArea = nil then
    FqIDArea := TFDDumb.Create(Self);

  Result := FqIDArea;
end;

procedure TfrmEditRetrainingPlan.SetIDArea(const Value: Integer);
begin
  if IDArea = Value then
    Exit;

  qIDArea.W.UpdateID(Value);
end;

procedure TfrmEditRetrainingPlan.SetMode(const Value: TMode);
begin
  inherited;

  case Mode of
    EditMode:
      begin
        Assert(SPEditI.SpecEdSimpleW.RecordCount = 1);
        IDArea := SPEditI.SpecEdSimpleW.IDArea.F.AsInteger;
      end;
    InsertMode:
      begin
        IDArea := 0;
        IDStandart := 3; // Без стандарта!!!
      end;
  end;
end;

end.
