unit CustomFactorEditView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, StudyPlanFactors, DocumentView;

type
  TviewCustomFactorEdit = class(TView_Ex)
  private
    function GetDocument: TFactors;
    { Private declarations }
  public
    procedure SetDocument(const Value: TDocument); override;
    property Document: TFactors read GetDocument;
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TviewCustomFactorEdit.GetDocument: TFactors;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TFactors;
end;

procedure TviewCustomFactorEdit.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
//    cxdbteFactorName.DataBinding.DataSource := Document.DataSetWrap.DataSource;
//    cxdbteFactorName.DataBinding.DataField := 'FactorName';

//    cxdbteFactorDescription.DataBinding.DataSource :=
//      Document.DataSetWrap.DataSource;
//    cxdbteFactorDescription.DataBinding.DataField := 'Description';

//    cxdblcbRule.DataBinding.DataSource := Document.DataSetWrap.DataSource;
//    cxdblcbRule.DataBinding.DataField := 'RuleDescription';

//    FdsgvFactorGroupNames.SetDocument(FFactorGroupNames);
//    FdsgvQuerys.SetDocument(Querys);

//    if Document.DS.State in [dsEdit, dsBrowse]  then
//    begin
//      FactorGroupNames.DataSetWrap.LocateAndCheck
//        (FactorGroupNames.DataSetWrap.MultiSelectDSWrap.KeyFieldName,
//        Document.Field('IDFactorGroupName').Value, []);
//      if not Document.Field('IDQuery').IsNull then
//      begin
//        Querys.DataSetWrap.LocateAndCheck
//          (Querys.DataSetWrap.MultiSelectDSWrap.KeyFieldName,
//          Document.Field('IDQuery').Value, []);
//      end;
//      cxcbQueryLink.Checked := not Document.Field('IDQuery').IsNull;
//    end;

  end
  else
  begin
//    cxdbteFactorName.DataBinding.DataSource := nil;
//    cxdbteFactorDescription.DataBinding.DataSource := nil;
//    FdsgvFactorGroupNames.SetDocument(nil);
//    FdsgvQuerys.SetDocument(nil);
  end;

end;

end.
