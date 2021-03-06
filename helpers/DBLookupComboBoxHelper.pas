unit DBLookupComboBoxHelper;

interface

uses
  DSWrap, cxDBLookupComboBox, Data.DB, cxDropDownEdit, cxDBLabel, cxDBEdit,
  cxGridDBBandedTableView;

type
  TDBLCB = class(TObject)
  private
  public
    class procedure Init(AcxDBLookupComboBox: TcxDBLookupComboBox;
      const ADataFieldWrap, AListFieldWrap: TFieldWrap;
      ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList);
      overload; static;
    class procedure Init(AcxLookupComboBoxProperties
      : TcxLookupComboBoxProperties; const AListFieldWrap: TFieldWrap;
      ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList); overload;
    class function InitColumn(AColumn: TcxGridDBBandedColumn;
      const AListFieldWrap: TFieldWrap;
      ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList)
      : TcxLookupComboBoxProperties; overload;
  end;

  TDBL = class(TObject)
  public
    class procedure Init(AcxDBLabel: TcxDBLabel; ADataSource: TDataSource;
      const ADataField: TFieldWrap); static;
  end;

  TDBChB = class(TObject)
  public
    class procedure Init(AcxDBCheckBox: TcxDBCheckBox; ADataSource: TDataSource;
      const ADataField: TFieldWrap); static;
  end;

type
  TLCB = class(TObject)
  public
    class procedure Init(AcxLookupComboBox: TcxLookupComboBox;
      const AListFieldWrap: TFieldWrap;
      ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList); static;
  end;

implementation

uses
  System.SysUtils;

class procedure TDBLCB.Init(AcxDBLookupComboBox: TcxDBLookupComboBox;
  const ADataFieldWrap, AListFieldWrap: TFieldWrap;
  ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList);
begin
  Assert(AcxDBLookupComboBox <> nil);
  Assert(ADataFieldWrap <> nil);

  AcxDBLookupComboBox.DataBinding.DataSource :=
    ADataFieldWrap.DataSetWrap.DataSource;

  AcxDBLookupComboBox.DataBinding.DataField := ADataFieldWrap.FieldName;

  AcxDBLookupComboBox.Properties.ListSource :=
    AListFieldWrap.DataSetWrap.DataSource;

  AcxDBLookupComboBox.Properties.KeyFieldNames :=
    AListFieldWrap.DataSetWrap.PKFieldName;

  AcxDBLookupComboBox.Properties.ListFieldNames := AListFieldWrap.FieldName;

  AcxDBLookupComboBox.Properties.DropDownListStyle := ADropDownListStyle;
end;

class procedure TDBLCB.Init(AcxLookupComboBoxProperties
  : TcxLookupComboBoxProperties; const AListFieldWrap: TFieldWrap;
  ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList);
begin
  Assert(AcxLookupComboBoxProperties <> nil);
  Assert(AListFieldWrap <> nil);

  AcxLookupComboBoxProperties.ListSource :=
    AListFieldWrap.DataSetWrap.DataSource;

  AcxLookupComboBoxProperties.KeyFieldNames :=
    AListFieldWrap.DataSetWrap.PKFieldName;

  AcxLookupComboBoxProperties.ListFieldNames := AListFieldWrap.FieldName;
  AcxLookupComboBoxProperties.DropDownListStyle := ADropDownListStyle;
end;

class function TDBLCB.InitColumn(AColumn: TcxGridDBBandedColumn;
  const AListFieldWrap: TFieldWrap;
  ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList)
  : TcxLookupComboBoxProperties;
begin
  Assert(AColumn <> nil);
  Assert(AListFieldWrap <> nil);

  AColumn.PropertiesClass := TcxLookupComboBoxProperties;
  Result := AColumn.Properties as TcxLookupComboBoxProperties;
  Init(Result, AListFieldWrap, ADropDownListStyle);
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
    DataField := ADataField.FieldName;
  end;
end;

class procedure TDBChB.Init(AcxDBCheckBox: TcxDBCheckBox;
  ADataSource: TDataSource; const ADataField: TFieldWrap);
begin
  Assert(AcxDBCheckBox <> nil);
  Assert(ADataSource <> nil);
  Assert(ADataField <> nil);

  with AcxDBCheckBox.DataBinding do
  begin
    DataSource := ADataSource;
    DataField := ADataField.FieldName;
  end;

  AcxDBCheckBox.Properties.ValueChecked := 1;
  AcxDBCheckBox.Properties.ValueUnchecked := 0;
end;

{ TLCB }

class procedure TLCB.Init(AcxLookupComboBox: TcxLookupComboBox;
  const AListFieldWrap: TFieldWrap;
  ADropDownListStyle: TcxEditDropDownListStyle = lsEditFixedList);
begin
  Assert(AcxLookupComboBox <> nil);

  AcxLookupComboBox.Properties.ListSource :=
    AListFieldWrap.DataSetWrap.DataSource;

  AcxLookupComboBox.Properties.KeyFieldNames :=
    AListFieldWrap.DataSetWrap.PKFieldName;

  AcxLookupComboBox.Properties.ListFieldNames := AListFieldWrap.FieldName;
  AcxLookupComboBox.Properties.DropDownListStyle := ADropDownListStyle;
end;

end.
