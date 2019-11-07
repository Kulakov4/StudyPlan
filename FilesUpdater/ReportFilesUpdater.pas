unit ReportFilesUpdater;

interface

type
  TReportFilesUpdater = class(TObject)
  private
  public
    class function TryUpdate(const AFileName: String): string; static;
  end;

implementation

uses
  System.SysUtils, FilesUpdater, System.IOUtils, OptionsHelper, KValuesList;

class function TReportFilesUpdater.TryUpdate(const AFileName: String): string;
var
  AFilesUpdate: TFilesUpdater;
begin
  Assert(not AFileName.IsEmpty);

  AFilesUpdate := TFilesUpdater.Create(nil);
  try
    // ������ ����� ���������� � ����� � �������
    AFilesUpdate.ApplicationFolder :=
      TPath.Combine(TOptions.SP.AppDataDir, 'reports');
    // ������ ����� ���������� � ������� �������
    TValueItem.Create(AFilesUpdate.FileServers, '������ �������',
      '\\eduserver\reports');
    // ��������� ���� ���� ������
    TValueItem.Create(AFilesUpdate.ApplicationFiles, '���� ������',
      AFileName);
    // ��������� ���������� �� ������� �������
    AFilesUpdate.CheckUpdates;

    Result := TPath.Combine(AFilesUpdate.ApplicationFolder, AFileName);
  finally
    FreeAndNil(AFilesUpdate);
  end;
end;

end.
