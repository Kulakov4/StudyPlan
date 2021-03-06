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
  EditRetrainingSpecFrm, FDDumb;

type
  TfrmEditRetrainingPlan = class(TfrmEditStudyPlan, ISpecEdSimpleEx)
    cxdblcbArea: TcxDBLookupComboBox;
    Label9: TLabel;
    procedure cxdblcbAreaPropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
  private
    FqAreaDumb: TFDDumb;
    function GetIDArea: Integer;
    procedure SetIDArea(const Value: Integer);
    { Private declarations }
  protected
    procedure CheckQualification; override;
    function CreateEditSpecForm: TfrmEditSpec; override;
    procedure SetMode(const Value: TMode); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  published
    property IDArea: Integer read GetIDArea write SetIDArea;
  end;

implementation

uses
  DBLookupComboBoxHelper;

{$R *.dfm}

constructor TfrmEditRetrainingPlan.Create(AOwner: TComponent);
begin
  inherited;
  // **********************************************
  // �����
  // **********************************************
  FqAreaDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbArea, FqAreaDumb.W.ID, SPGroup.qAreas.W.AREA, lsEditList);
end;

procedure TfrmEditRetrainingPlan.CheckQualification;
begin; // ������������ � �������������� ����� ���� ������.
  // ����� ��� ������ �� �����?
end;

function TfrmEditRetrainingPlan.CreateEditSpecForm: TfrmEditSpec;
begin
  Result := TfrmEditRetrainingSpec.Create(SPGroup);
end;

procedure TfrmEditRetrainingPlan.cxdblcbAreaPropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  inherited;
  if AText <> '' then
    SPGroup.qAreas.W.Append(AText);
end;

function TfrmEditRetrainingPlan.GetIDArea: Integer;
begin
  Result := FqAreaDumb.W.ID.F.AsInteger;
end;

procedure TfrmEditRetrainingPlan.SetIDArea(const Value: Integer);
begin
  if IDArea = Value then
    Exit;

  FqAreaDumb.W.UpdateID(Value);
end;

procedure TfrmEditRetrainingPlan.SetMode(const Value: TMode);
begin
  inherited;

  case Mode of
    EditMode:
      begin
        Assert(SPGroup.qSpecEdSimple.FDQuery.RecordCount = 1);
        IDArea := SPGroup.qSpecEdSimple.W.IDArea.F.AsInteger;
      end;
    InsertMode:
      begin
        IDArea := 0;
        IDStandart := 3; // ��� ���������!!!
      end;
  end;
end;

end.
