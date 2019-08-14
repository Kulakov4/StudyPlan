unit UMKDataModule;

interface

uses
  System.SysUtils, System.Classes, Word2010, Vcl.OleServer, NotifyEvents;

type
  TUMKDM = class(TDataModule)
    WA: TWordApplication;
    WD: TWordDocument;
    procedure DataModuleCreate(Sender: TObject);
  private
    class var FSingleInstance: TUMKDM;

  var
    FAfterPrepareReport: TNotifyEventsEx;
    FOnBookmark: TNotifyEventsEx;
  public
    class function Instance: TUMKDM; static;
    procedure PrepareReport(const AWordTemplateFileName: string);
    function ReplaceBookmark(B: Bookmark; const Text: String): Bookmark;
    procedure Save(const AFileName: string);
    procedure Open(const AFileName: string);
    property AfterPrepareReport: TNotifyEventsEx read FAfterPrepareReport;
    property OnBookmark: TNotifyEventsEx read FOnBookmark;
  end;

  TBookmarkData = class(TObject)
  private
    FB: Bookmark;
    FBookmarkName: string;
    FDocument: TWordDocument;
    function GetBookmarkName: string;
  public
    property Document: TWordDocument read FDocument;
    constructor Create(ABookmark: Bookmark; ADocument: TWordDocument);
    property B: Bookmark read FB;
    property BookmarkName: string read GetBookmarkName;
  end;

implementation

uses SyncObjs, Variants, ActiveX, SelfDestroy, System.IOUtils;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TUMKDM }
var
  Lock: TCriticalSection;

procedure TUMKDM.DataModuleCreate(Sender: TObject);
begin
  FOnBookmark := TNotifyEventsEx.Create(Self);
  FAfterPrepareReport := TNotifyEventsEx.Create(Self);
end;

class function TUMKDM.Instance: TUMKDM;
begin
  Lock.Acquire;
  try
    if not Assigned(FSingleInstance) then
      FSingleInstance := TUMKDM.Create(nil);

    Result := FSingleInstance;
  finally
    Lock.Release;
  end;

end;

procedure TUMKDM.PrepareReport(const AWordTemplateFileName: string);
var
  AFileName: OleVariant;
  ATemplate: OleVariant;
  B: Bookmark;
  i: Integer;
  IEnum: IEnumVariant;
  Fetched: LongWord;
  IItem: OleVariant;
  Bookmarks: TInterfaceList;
  // OutputFileName: OleVariant;
  // FileFormat: OleVariant;
  SelfDestroy: TSelfDestroy;
begin
  AFileName := AWordTemplateFileName;

  ATemplate := EmptyParam;
  WA.Connect;
  // try
  // Открываем шаблон отчёта
  WA.Documents.Add(AFileName, ATemplate, ATemplate, ATemplate);

  WD.ConnectTo(WA.ActiveDocument);
  WA.Visible := False;
  WA.ActiveDocument.Convert;
  Bookmarks := TInterfaceList.Create;
  try
    IEnum := WD.Bookmarks._NewEnum as IEnumVariant;
    Fetched := 1;
    // Цикл по всем закладкам шаблона
    while Fetched <> 0 do
    begin
      IEnum.Next(1, IItem, Fetched);
      if Fetched <> 0 then
      begin
        // B := IDispatch(IItem) as Bookmark; // Получаем закладку
        Bookmarks.Add(IItem);
        // ProcessBookmark(B); // Обрабатывам закладку
      end;
    end;

    for i := 0 to Bookmarks.Count - 1 do
    begin
      B := Bookmarks.Items[i] as Bookmark;

      SelfDestroy := TSelfDestroy.Create(TBookmarkData.Create(B, WD));
      FOnBookmark.CallEventHandlers(SelfDestroy.Obj);
      // ProcessBookmark(B); // Обрабатывам закладку
    end;

  finally
    FreeAndNil(Bookmarks);
  end;
  // WA.Selection.SetRange(1, 1);

  FAfterPrepareReport.CallEventHandlers(Self);

  // WA.Visible := True;
  // OutputFileName := AOutputFileName;
  // FileFormat := wdFormatDocumentDefault; // wdFormatDocument;

  // WordDocument1.SaveAs(OutputFileName, FileFormat, EmptyParam, EmptyParam,
  // EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
  // EmptyParam);

  // finally
  // WA.Disconnect;
  // end;

  // http://www.sql.ru/forum/actualthread.aspx?tid=136922
end;

function TUMKDM.ReplaceBookmark(B: Bookmark; const Text: String): Bookmark;
var
  ABookmarkName: string;

  r: WordRange;
  r2: OleVariant;
begin
  ABookmarkName := B.Name;
  r := B.Range;
  r.Text := Text;
  r2 := r;
  Result := r.Bookmarks.Add(ABookmarkName, r2);
end;

procedure TUMKDM.Save(const AFileName: string);
var
  Path: string;
begin
  Assert(not AFileName.IsEmpty);

  Path := TPath.GetDirectoryName(AFileName);
  TDirectory.CreateDirectory(Path);

  WD.SaveAs(AFileName, wdFormatDocumentDefault, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam);
end;

procedure TUMKDM.Open(const AFileName: string);
begin
  WA.Connect;
  try
    // Открываем документ
    WA.Documents.Open(AFileName, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam);
    WA.Selection.SetRange(1, 1);
    WA.Visible := True;
  finally
    WA.Disconnect;
  end;
end;

constructor TBookmarkData.Create(ABookmark: Bookmark; ADocument: TWordDocument);
begin
  Assert(ABookmark <> nil);
  inherited Create;
  FB := ABookmark;
  FBookmarkName := FB.Name;
  FDocument := ADocument;
end;

function TBookmarkData.GetBookmarkName: string;
begin
  // Result := B.Name;
  Result := FBookmarkName;
end;

initialization

Lock := TCriticalSection.Create;

end.
