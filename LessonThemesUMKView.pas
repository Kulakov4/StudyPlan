unit LessonThemesUMKView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxPC, DocumentView, StudyPlanForUMK,
  UMKMaster;

type
  TviewLessonThemesForUMK = class(TView_Ex)
    cxpcLessonThemes: TcxPageControl;
  private
    function GetDocument: TUMKMaster;
    { Private declarations }
  protected
    property Document: TUMKMaster read GetDocument;
  public
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses ETPView;

{$R *.dfm}

function TviewLessonThemesForUMK.GetDocument: TUMKMaster;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TUMKMaster;
end;

procedure TviewLessonThemesForUMK.SetDocument(const Value: TDocument);
var
  AcxTabSheet: TcxTabSheet;
  AETPView: TviewETP;
  AIDDiscipline: Integer;
  I: Integer;
begin
  inherited;
  if FDocument <> nil then
  begin
    Document.SelectedStudyPlanForUMK.First;
    while not Document.SelectedStudyPlanForUMK.eof do
    begin
      AIDDiscipline := Document.SelectedStudyPlanForUMK.FieldByName
        ('ID_Discipline').AsInteger;
      AcxTabSheet := TcxTabSheet.Create(cxpcLessonThemes);
      AcxTabSheet.PageControl := cxpcLessonThemes;
      AcxTabSheet.Caption := Document.ETPDictonary[AIDDiscipline].Caption;

      // Создаём представление для тематического плана
      AETPView := TviewETP.Create(AcxTabSheet, AcxTabSheet);
      // Привязываем представление к тематическому плану
      AETPView.SetDocument(Document.ETPDictonary[AIDDiscipline]);

      Document.SelectedStudyPlanForUMK.Next;
    end

  end
  else
  begin
    for I := cxpcLessonThemes.PageCount - 1 downto 0 do
    begin
      cxpcLessonThemes.Pages[I].Free;
    end;
  end;

end;

end.
