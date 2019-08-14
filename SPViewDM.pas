unit SPViewDM;

interface

uses
  SysUtils, Classes, cxStyles, cxEditRepositoryItems, cxEdit,
  cxExtEditRepositoryItems, cxClasses, cxCheckBox;

type
  TDM = class(TDataModule)
    cxstylrpstry1: TcxStyleRepository;
    cxstyl1: TcxStyle;
    cxstyl2: TcxStyle;
    cxstyl3: TcxStyle;
    cxstyl4: TcxStyle;
    cxstyl5: TcxStyle;
    cxstyl6: TcxStyle;
    cxstyl7: TcxStyle;
    cxstyl8: TcxStyle;
    cxstyl9: TcxStyle;
    cxstyl10: TcxStyle;
    cxstyl11: TcxStyle;
    cxstyl12: TcxStyle;
    cxstyl13: TcxStyle;
    cxstyl14: TcxStyle;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1SpinItem1: TcxEditRepositorySpinItem;
    cxEditRepository1CheckBoxItem1: TcxEditRepositoryCheckBoxItem;
    cxEditRepository1Label1: TcxEditRepositoryLabel;
    cxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem;
    cxEditRepository1CheckComboBox1: TcxEditRepositoryCheckComboBox;
    cxEditRepository1CheckBoxItem2: TcxEditRepositoryCheckBoxItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
