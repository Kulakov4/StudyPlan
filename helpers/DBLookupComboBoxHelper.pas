unit DBLookupComboBoxHelper;

interface

uses
  DSWrap, cxDBLookupComboBox, Data.DB, cxDropDownEdit, cxDBLabel, cxDBEdit;

type
  TDBLCB = class(TObject)
  public
    class procedure Init(AcxDBLookupComboBox: TcxDBLookupComboBox; ADataSource:
        TDataSource; const ADataField: string; AListSource: TDataSource; const
        AListFieldWrap: TFieldWrap; ADropDownListStyle: TcxEditDropDownListStyle =
        lsEditFixedList); static;
  end;

  TDBL = class(TObject)
  public
    class procedure Init(AcxDBLabel: TcxDBLabel; ADataSource: TDataSource; const
        ADataField: TFieldWrap); static;
  end;

  TDBChB = class(TObject)
  public
    class procedure Init(AcxDBCheckBox: TcxDBCheckBox; ADataSource: TDataSource;
        const ADataField: TFieldWrap); static;
  end;

implementation

uses
  System.SysUtils;

class procedure TDBLCB.Init(AcxDBLookupComboBox: TcxDBLookupComboBox;
    ADataSource: TDataSource; const ADataField: string; AListSource:
    TDataSource; const AListFieldWrap: TFieldWrap; ADropDownListStyle:
    TcxEditDropDownListStyle = lsEditFixedList);
begin
  Assert(AcxDBLookupComboBox <> nil);
  Assert(ADataSource <> nil);
  Assert(not ADataField.IsEmpty);
  Assert(AListSource <> nil);

  AcxDBLookupComboBox.DataBinding.DataSource := ADataSource;
  AcxDBLookupComboBox.DataBinding.DataField := ADataField;
  AcxDBLookupComboBox.Properties.ListSource := AListSource;
  AcxDBLookupComboBox.Properties.KeyFieldNames :=
    AListFieldWrap.DataSetWrap.PKFieldName;
  AcxDBLookupComboBox.Properties.ListFieldNames := AListFieldWrap.FieldName;
  AcxDBLookupComboBox.Properties.DropDownListStyle := ADropDownListStyle;
end;

class procedure TDBL.Init(AcxDBLabel: TcxDBLabel; ADataSource: TDataSource;
    const ADataField: TFieldWrap);
begin
  Assert(AcxDBLabel <> nil);
  Assert(ADataSource <> nil);
  Assert(ADataField <> nil);

  with AcxDBLabel.DataBinding do
  begin
    DataSource := ADataSource;
    DataField :=  ADataField.FieldName;
  end;
end;

class procedure TDBChB.Init(AcxDBCheckBox: TcxDBCheckBox; ADataSource:
    TDataSource; const ADataField: TFieldWrap);
begin
  Assert(AcxDBCheckBox <> nil);
  Assert(ADataSource <> nil);
  Assert(ADataField <> nil);

  with AcxDBCheckBox.DataBinding do
  begin
    DataSource := ADataSource;
    DataField :=  ADataField.FieldName;
  end;

  AcxDBCheckBox.Properties.ValueChecked := 1;
  AcxDBCheckBox.Properties.ValueUnchecked := 0;
end;

end.
