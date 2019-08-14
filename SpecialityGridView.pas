unit SpecialityGridView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, Data.DB, cxDBData, TB2Dock, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls,
  cxButtonEdit, Specialitys, DocumentView, Vcl.StdCtrls, cxNavigator;

type
  TdsgvSpecialitys = class(TdsgvEssence)
    cxgdbbcQualification: TcxGridDBBandedColumn;
    procedure cx_dbbtvcxg1DBBandedTableView1Column1PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private
    function GetDocument: TSpecialitysEx;
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
  public
    property Document: TSpecialitysEx read GetDocument;
    { Public declarations }
  end;

var
  dsgvSpecialitys: TdsgvSpecialitys;

implementation

{$R *.dfm}

uses Qualifications, ViewFormEx, NotifyEvents;

procedure TdsgvSpecialitys.cx_dbbtvcxg1DBBandedTableView1Column1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  Qualifications: TQualifications;
  frmQualifications: TfrmViewEx;
begin
  frmQualifications := TfrmViewEx.Create(Self, 'Квалификации',
    'QualifacationForm', [mbOk]);
  try
     Qualifications := TQualifications.Create(Self);
     try
       Qualifications.Refresh;
       frmQualifications.ViewClass := TdsgvEssence;
       (frmQualifications.View as TdsgvEssence).cxgridDBBandedTableView.OptionsView.BandHeaders := False;
       frmQualifications.View.SetDocument(Qualifications);
       if frmQualifications.ShowModal = mrOk then
       begin
         Document.SetQualification(Qualifications.PKValue)
       end;
     finally
       Qualifications.Free;
     end;
  finally
    FreeAndNil(frmQualifications);
  end;
end;

function TdsgvSpecialitys.GetDocument: TSpecialitysEx;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TSpecialitysEx;
end;

procedure TdsgvSpecialitys.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin
  cxgdbbcQualification.Position.ColIndex := AcxGridDBBandedColumn.GridView.ColumnCount - 1;
  if AnsiSameText('Chiper_speciality', AcxGridDBBandedColumn.DataBinding.FieldName) then
  begin
    AcxGridDBBandedColumn.MinWidth := 100;
  end;
end;

end.
