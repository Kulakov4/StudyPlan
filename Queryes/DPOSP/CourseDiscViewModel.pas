unit CourseDiscViewModel;

interface

uses
  System.Classes, FireDAC.Comp.DataSet, DiscNameQry, CourceDiscNameViewModel,
  CourseStudyPlanQry;

type
  TCourseDiscViewModel = class(TComponent)
  private
    FIDChair: Integer;
    FIDSPECIALITYEDUCATION: Integer;
    FMasterW: TCourseStudyPlanW;
    FqDiscName: TQryDiscName;
    FqCourseStudyPlan: TQryCourseStudyPlan;
    procedure DoAfterDPOSPApplyUpdates(ADataSet: TFDDataSet;
      AErrorCount: Integer);
    function GetDiscNameW: TDiscNameW;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    procedure SaveToMasterDataSet;
  public
    constructor Create(AOwner: TComponent; AIDSPECIALITYEDUCATION, AIDChair:
        Integer; AMasterStudyPlanW: TCourseStudyPlanW; AQryDiscName: TQryDiscName);
        reintroduce;
    procedure ApplyUpdates;
    procedure CancelUpdates;
    function CreateCourceDiscNameVM(AOwner: TComponent): TCourceDiscNameVM;
    property DiscNameW: TDiscNameW read GetDiscNameW;
    property CourseStudyPlanW: TCourseStudyPlanW read GetCourseStudyPlanW;
    property IDChair: Integer read FIDChair;
    property IDSPECIALITYEDUCATION: Integer read FIDSPECIALITYEDUCATION;
  end;

implementation

uses
  Data.DB;

constructor TCourseDiscViewModel.Create(AOwner: TComponent;
    AIDSPECIALITYEDUCATION, AIDChair: Integer; AMasterStudyPlanW:
    TCourseStudyPlanW; AQryDiscName: TQryDiscName);
begin
  inherited Create(AOwner);
  Assert(AIDSPECIALITYEDUCATION > 0);
  Assert(AMasterStudyPlanW <> nil);

  FIDSPECIALITYEDUCATION := AIDSPECIALITYEDUCATION;
  FIDChair := AIDChair;

  FqDiscName := AQryDiscName;

  // Создаём курсор главного набора данных
  FMasterW := TCourseStudyPlanW.Create(AMasterStudyPlanW.AddClone(''));

  FqCourseStudyPlan := TQryCourseStudyPlan.Create(Self);
  FqCourseStudyPlan.FDQuery.CachedUpdates := True;
  FqCourseStudyPlan.FDQuery.AfterApplyUpdates := DoAfterDPOSPApplyUpdates;
  FqCourseStudyPlan.Search(AIDSPECIALITYEDUCATION);
end;

procedure TCourseDiscViewModel.ApplyUpdates;
begin
  FqCourseStudyPlan.W.TryPost;

  if FqCourseStudyPlan.FDQuery.ChangeCount = 0 then
    Exit;

  FqCourseStudyPlan.FDQuery.ApplyUpdates(0);
  FqCourseStudyPlan.FDQuery.CommitUpdates;
  Assert(FqCourseStudyPlan.FDQuery.ChangeCount = 0);
end;

procedure TCourseDiscViewModel.CancelUpdates;
begin
  if FqCourseStudyPlan.FDQuery.ChangeCount = 0 then
    Exit;

  FqCourseStudyPlan.FDQuery.CancelUpdates;
  Assert(FqCourseStudyPlan.FDQuery.ChangeCount = 0);
end;

function TCourseDiscViewModel.CreateCourceDiscNameVM(AOwner: TComponent)
  : TCourceDiscNameVM;
begin
  Result := TCourceDiscNameVM.Create(AOwner, CourseStudyPlanW, FqDiscName, FIDChair,
    FIDSPECIALITYEDUCATION);
end;

procedure TCourseDiscViewModel.DoAfterDPOSPApplyUpdates(ADataSet: TFDDataSet;
  AErrorCount: Integer);
begin
  SaveToMasterDataSet;
end;

function TCourseDiscViewModel.GetDiscNameW: TDiscNameW;
begin
  Result := FqDiscName.W;
end;

function TCourseDiscViewModel.GetCourseStudyPlanW: TCourseStudyPlanW;
begin
  Result := FqCourseStudyPlan.W;
end;

procedure TCourseDiscViewModel.SaveToMasterDataSet;
var
  I: Integer;
begin
  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtModified,
    FireDAC.Comp.DataSet.rtInserted];
  FqCourseStudyPlan.FDQuery.First;
  while not FqCourseStudyPlan.FDQuery.Eof do
  begin
    case FqCourseStudyPlan.FDQuery.UpdateStatus of
      usModified:
        begin
          // Ищем эту запись у курсора мастера
          FMasterW.LocateByPK(FqCourseStudyPlan.W.ID_StudyPlan.F.AsInteger, True);
          FMasterW.TryEdit;
        end;
      usInserted:
        // Добавляем эту запись в курсор мастера
        FMasterW.TryAppend;
    end;

    for I := 0 to FqCourseStudyPlan.FDQuery.FieldCount - 1 do
      FMasterW.DataSet.Fields[I].Value := FqCourseStudyPlan.FDQuery.Fields[I].Value;

    FMasterW.TryPost;

    FqCourseStudyPlan.FDQuery.Next;
  end;

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtDeleted];
  FqCourseStudyPlan.FDQuery.First;
  while not FqCourseStudyPlan.FDQuery.Eof do
  begin
    // Ищем эту запись у курсора мастера
    FMasterW.LocateByPK(FqCourseStudyPlan.W.ID_StudyPlan.F.AsInteger, True);
    FMasterW.DataSet.Delete;

    FqCourseStudyPlan.FDQuery.Next;
  end;

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtModified,
    FireDAC.Comp.DataSet.rtInserted, FireDAC.Comp.DataSet.rtUnModified];
end;

end.
