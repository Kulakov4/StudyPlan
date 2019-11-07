unit FilesUpdater;

interface

uses KValuesList, Wrapper, KFileUtils, System.Classes;

type
  // ����������� ���������� ������ ���������
  // ����������� �������� �������� ���������

  TFilesUpdater = class(TComponent)
  private
    FApplicationFiles: TValuesList;
    FApplicationFolder: string;
    FFileServers: TValuesList;
    FFileUtils: TFileUtils;
  protected
    function CheckFileAccess(AFileName: string): Boolean; virtual;
    function CheckFileForUpdate(const AServerFileName, AClientFileName: string):
      Boolean; virtual;
    procedure CopyFiles(FilesList: TValuesList); virtual;
    procedure LoadSettings(const AOptionsFileName: String); virtual;
    procedure UpdateFilesCreationTime(AFilesList: TValuesList); virtual;
  public
    constructor Create(AOwner: TComponent); reintroduce; virtual;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure CheckUpdates; virtual;
  published
    // ����� ����������
    property ApplicationFiles: TValuesList read FApplicationFiles write
      FApplicationFiles;
    // ����� ���������� �� �������
    property ApplicationFolder: string read FApplicationFolder write
      FApplicationFolder;
    // ������ �������� �������� ������ ����� ������� ����������
    property FileServers: TValuesList read FFileServers write FFileServers;
  end;

implementation

uses SysUtils, Saver, Windows, ShellApi, System.IOUtils;

constructor TFilesUpdater.Create(AOwner: TComponent);
begin
  // �� ��������� ������ ���������� �������� ������� �����
  FApplicationFolder := GetCurrentDir;

  inherited Create(AOwner);
  FFileUtils := TFileUtils.Create;
  FApplicationFiles := TValuesList.Create(Self);
  FFileServers := TValuesList.Create(Self);
end;

destructor TFilesUpdater.Destroy;
begin
  FreeAndNil(FFileUtils);
  inherited;
end;

procedure TFilesUpdater.AfterConstruction;
begin
  inherited;

  // ���� ���� �� ����������, ������ ��� ����������
  FApplicationFolder := TPath.GetFullPath(FApplicationFolder);
end;

function TFilesUpdater.CheckFileAccess(AFileName: string): Boolean;
begin
  Result := FileExists(AFileName);
  if Result then
  begin
    FFileUtils.FileName := AFileName;
    // ���������, �������� �� ���� ��� ������
    Result := FFileUtils.CheckAccess(GENERIC_READ, FILE_SHARE_READ);
  end;
end;

function TFilesUpdater.CheckFileForUpdate(const AServerFileName,
  AClientFileName: string): Boolean;
var
  AServerLastWriteTime, AClientLastWriteTime: TDateTime;
begin
  // ����� �������� ���� � ����� �����
  // � ������ ��������� ��� ���� �������� ��� ������
  FFileUtils.FileName := AServerFileName;
  AServerLastWriteTime := FFileUtils.LastWriteTime;
  FFileUtils.FileName := AClientFileName;
  try
    AClientLastWriteTime := FFileUtils.LastWriteTime;
  except
    // ������ ����� ��������� ���� ����� �� ������� ������� �� ����������
    AClientLastWriteTime := AServerLastWriteTime - 1;
  end;
  // ����� ����� �� ������� �� ��������� � �������� ����� �� �������
  Result := AServerLastWriteTime <> AClientLastWriteTime;
end;

procedure TFilesUpdater.CheckUpdates;
var
  i: Integer;
  ServerFileName: string;
  j: Integer;
  ClientFileName: string;
  AFilesList: TValuesList;
//  AFileAvailable: Boolean;
  sr: TSearchRec;
  AFileName: string;
  AGoodServer: Boolean;
begin
  // ���������, �������� �� ���������� � ��������� ��
  AFilesList := TValuesList.Create(nil);
  try
    // ���� �� ���� ������ ����������
    for i := 0 to FApplicationFiles.Count - 1 do
    begin
      ClientFileName := TPath.Combine(ApplicationFolder, FApplicationFiles.Items[i].Value);
      
//      AFileAvailable := False;

      // ���� �� ��� �������� ��� �������� ����������
      for j := 0 to FFileServers.Count - 1 do
      begin
        ServerFileName := TPath.Combine(FileServers.Items[j].Value, FApplicationFiles.Items[i].Value);

        AGoodServer := True;

        // ���� ���� ���������� � ��������
        if SysUtils.FindFirst(ServerFileName, 0, sr) = 0 then
        begin
          repeat
            AFileName := TPath.Combine( TPath.GetDirectoryName(ServerFileName), sr.Name);
//            AFileName := ExtractFilePath(ServerFileName) + sr.Name;
            ClientFileName := ExtractFilePath(ClientFileName) + sr.Name;

//            StatText.AddLine( '��������� ����������� %s ... ', AFileName );
            if CheckFileAccess(AFileName) then
            begin
//              AFileAvailable := True;
//              StatText.Add('��');

              // ���� ��� ����� ��������
              if (CheckFileForUpdate(AFileName, ClientFileName)) then
                TValueItem.Create(AFilesList, AFileName, ClientFileName);
            end
            else
            begin
              AGoodServer := False; // ���� �� ������ ������� �� ��������;
                                    // ����� ������ ��� �� ������ �������
//              StatText.Add('������');

              break; // ��������� ����� ������� ������ �� ���� ������� �� �����
            end;
          until FindNext(sr) <> 0;
          SysUtils.FindClose(sr);
        end;

        if AGoodServer then // ���� � ������� �� �����������, �� ������ ������ �� �����
          break;
      end;
    end;

    FFileUtils.FileName := '';
    if AFilesList.Count > 0 then
    begin
//      StatText.AddLine( string.Format('�������� %d ������ � ������� ... ', [AFilesList.Count] ) );

      // �������� ����� � �������
      CopyFiles(AFilesList);

//      StatText.Add('��');

      // ��������� ���� �������� ������
      UpdateFilesCreationTime(AFilesList);
    end;
  finally
    FreeAndNil(AFilesList);
    FFileUtils.FileName := '';
  end;
end;

procedure TFilesUpdater.CopyFiles(FilesList: TValuesList);
begin
  // ����� ���������� ����� �������� Windows
  KFileUtils.CopyFiles(FilesList);
end;

procedure TFilesUpdater.LoadSettings(const AOptionsFileName: String);
var
  ASaver: TSaverToFile;
begin
  Assert(AOptionsFileName <> '');
  ASaver := TSaverToFile.Create(Self, AOptionsFileName);
  try
    ASaver.Load;
  finally
    FreeAndNil(ASaver);
  end;
end;

procedure TFilesUpdater.UpdateFilesCreationTime(AFilesList: TValuesList);
var
  i: Integer;
  ACreationTime: TDateTime;
begin
  for i := 0 to AFilesList.Count - 1 do
  begin
    FFileUtils.FileName := AFilesList.Items[i].Ident;
    ACreationTime := FFileUtils.CreationTime;
    FFileUtils.FileName := AFilesList.Items[i].Value;
    FFileUtils.CreationTime := ACreationTime;
  end;
  FFileUtils.FileName := '';
end;

end.

