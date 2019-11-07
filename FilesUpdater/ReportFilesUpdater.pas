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
    // Отчёты будем копировать в папку с данными
    AFilesUpdate.ApplicationFolder :=
      TPath.Combine(TOptions.SP.AppDataDir, 'reports');
    // Отчёты будем копировать с сервера отчётов
    TValueItem.Create(AFilesUpdate.FileServers, 'Сервер отчётов',
      '\\eduserver\reports');
    // Скопируем один файл отчёта
    TValueItem.Create(AFilesUpdate.ApplicationFiles, 'Файл отчёта',
      AFileName);
    // Проверяем обновления на сервере отчётов
    AFilesUpdate.CheckUpdates;

    Result := TPath.Combine(AFilesUpdate.ApplicationFolder, AFileName);
  finally
    FreeAndNil(AFilesUpdate);
  end;
end;

end.
