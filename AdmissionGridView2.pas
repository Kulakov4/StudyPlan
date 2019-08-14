unit AdmissionGridView2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataSetView_2, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, ExtCtrls,
  cxButtonEdit, DataSetControlsView, TB2Dock, DocumentView, Admissions,
  cxLookAndFeels, cxLookAndFeelPainters, TB2Toolbar, ActnList, TB2Item,
  StdCtrls, Spin, ImgList, cxNavigator, System.Actions, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TAdmissionGV = class(TDataSetView2)
    cx_dbbtvcxg1DBBandedTableView1Column1: TcxGridDBBandedColumn;
    cx_dbbtvcxg1DBBandedTableView1Column2: TcxGridDBBandedColumn;
    cx_dbbtvcxg1DBBandedTableView1Column3: TcxGridDBBandedColumn;
    tbdckTop: TTBDock;
    TBToolbar1: TTBToolbar;
    actlst1: TActionList;
    actCopyStudyPlan: TAction;
    tbi1: TTBItem;
    TBControlItem1: TTBControlItem;
    Label1: TLabel;
    TBControlItem2: TTBControlItem;
    seYears: TSpinEdit;
    TBControlItem3: TTBControlItem;
    Label2: TLabel;
    il1: TImageList;
    actEnroll: TAction;
    TBItem1: TTBItem;
    procedure actCopyStudyPlanExecute(Sender: TObject);
    procedure actEnrollExecute(Sender: TObject);
    procedure actEnrollUpdate(Sender: TObject);
    procedure cx_dbbtvcxg1DBBandedTableView1Column1PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private
    FDataSetControls_View: TDataSetControls_View;
    procedure EditCourceNames;
    function GetDocument: TAdmissions;
    { Private declarations }
  protected
    procedure AfterInsert(Sender: TObject);
    property Document: TAdmissions read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses NotifyEvents, ViewFormEx, CourcesNames, EssenceGridView, MessageForm,
  System.UITypes, AbitConnector;

{$R *.dfm}

constructor TAdmissionGV.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  FDataSetControls_View := TDataSetControls_View.Create(Self, tbdckTop);
end;

procedure TAdmissionGV.actCopyStudyPlanExecute(Sender: TObject);
var
  frmMessage: TfrmMessage;
begin
  if MessageDlg(Format('Скопировать выбранный учебный план на %d год?'#13#10+
                       'Это займёт несколько минут.', [seYears.Value]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    frmMessage := TfrmMessage.Create(Self);
    with frmMessage do
    begin
      FormStyle := fsStayOnTop;
      lblText.Caption := 'Идёт копирование';
      btnClose.Caption := 'Закрыть';
      btnClose.Enabled := False;
      Show;
    end;
    Application.ProcessMessages;
    try
      // Вызываем копирование
      Document.Copy( seYears.Value );

      // Обновляем окно сообщения
      with frmMessage do
      begin
        lblText.Caption := 'Копирование завершено';
        btnClose.Caption := 'ОК';
        btnClose.Enabled := True;
      end;
    except
      with frmMessage do
      begin
        lblText.Caption := 'При копировании возникла ошибка';
        btnClose.Enabled := True;
      end;
      raise;
    end;
  end;
end;

procedure TAdmissionGV.actEnrollExecute(Sender: TObject);
begin
  inherited;

  Assert(Document.PKValue > 0);
  AbiturientsConnector.AddListener( Document.PKValue );
end;

procedure TAdmissionGV.actEnrollUpdate(Sender: TObject);
begin
  actEnroll.Enabled := (FDocument <> nil) and (Document.Wrap.DataSet.RecordCount > 0);
end;

procedure TAdmissionGV.AfterInsert(Sender: TObject);
begin
  EditCourceNames;
end;

procedure TAdmissionGV.cx_dbbtvcxg1DBBandedTableView1Column1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  EditCourceNames;
end;

procedure TAdmissionGV.EditCourceNames;
var
  frmCourceNames: TfrmViewEx;
  ACourceNames: TCourceNames;
begin
  ACourceNames := TCourceNames.Create(Self);
  frmCourceNames := TfrmViewEx.Create(Self, 'Названия курсов', 'CourceNameForm');
  try
    ACourceNames.Refresh;
    frmCourceNames.ViewClass := TdsgvEssence;
    frmCourceNames.View.SetDocument(ACourceNames);
    if frmCourceNames.ShowModal = mrOk then
    begin
      if not (Document.DataSetWrap.DataSet.State in [dsEdit, dsInsert]) then
        Document.DataSetWrap.DataSet.Edit;
      // Создаём новый набор на курсы
      Document.New(ACourceNames.DataSetWrap.DataSet.FieldByName('ID_Speciality').AsInteger);
    end
    else
      Document.DataSetWrap.DataSet.Cancel;
  finally
    FreeAndNil(frmCourceNames);
    FreeAndNil(ACourceNames);
  end;
end;

function TAdmissionGV.GetDocument: TAdmissions;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TAdmissions;
end;

procedure TAdmissionGV.SetDocument(const Value: TDocument);
begin
  seYears.Value := CurrentYear + 1;
  inherited;

  if FDocument <> nil then
  begin
    FDataSetControls_View.SetDocument( Document.Wrap );
    KcxGridDBBandedTableView.SetDocument( Document.Wrap );
    TNotifyEventWrap.Create(Document.Wrap.AfterInsert, AfterInsert, EventsList);    
  end
  else
  begin
    FDataSetControls_View.SetDocument( nil );
    KcxGridDBBandedTableView.SetDocument( nil );
  end;
end;

{
GRID MODE в dDBBandedTableView
Если true то нет лишних SQL запросов, быстро проходит добавление
Если false то можно сортировать и фильтровать
}

end.
