unit AdoptionDatesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewFormEx, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinsDefaultPainters,
  cxClasses, cxPropertiesStore, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls,
  cxControls, dxSkinscxPCPainter, dxBarBuiltInMenu, cxPC, EssenceGridView;

type
  TfrmAdoptionDates = class(TfrmViewEx)
    cxpcAdoption: TcxPageControl;
    cxtsEducationalStandarts: TcxTabSheet;
    cxtsStudyPlanAdoption: TcxTabSheet;
    cxtsUMKAdoption: TcxTabSheet;
  private
    FEducationalStandartsView: TdsgvEssence;
    FStudyPlanAdoptionView: TdsgvEssence;
    FUMKAdoptionView: TdsgvEssence;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ACaption, AStorageName: String;
        MsgDlgButtons: TMsgDlgButtons = mbOKCancel); reintroduce; override;
    property EducationalStandartsView: TdsgvEssence read FEducationalStandartsView;
    property StudyPlanAdoptionView: TdsgvEssence read FStudyPlanAdoptionView;
    property UMKAdoptionView: TdsgvEssence read FUMKAdoptionView;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TfrmAdoptionDates.Create(AOwner: TComponent; ACaption,
    AStorageName: String; MsgDlgButtons: TMsgDlgButtons = mbOKCancel);
begin
  inherited;

  FEducationalStandartsView := TdsgvEssence.Create(Self, cxtsEducationalStandarts);
  FEducationalStandartsView.cxgridDBBandedTableView.OptionsBehavior.ImmediateEditor := True;
  FEducationalStandartsView.cxgridDBBandedTableView.OptionsData.Appending := True;

  FStudyPlanAdoptionView := TdsgvEssence.Create(Self, cxtsStudyPlanAdoption);
  FStudyPlanAdoptionView.cxgridDBBandedTableView.OptionsBehavior.ImmediateEditor := True;
  FStudyPlanAdoptionView.cxgridDBBandedTableView.OptionsData.Appending := True;

  FUMKAdoptionView := TdsgvEssence.Create(Self, cxtsUMKAdoption);
  FUMKAdoptionView.cxgridDBBandedTableView.OptionsBehavior.ImmediateEditor := True;
  FUMKAdoptionView.cxgridDBBandedTableView.OptionsData.Appending := True;
end;

end.
