unit CourseStudyPlanEditModel;

interface

uses
  System.Classes, DiscNameQry, DiscNameInt, InsertEditMode, CourseStudyPlanQry,
  CourseStudyPlanInterface, CourseStudyPlanEditInterface;

type
  TCourseStudyPlanEditModel = class(TComponent, ICourseStudyPlanEdit)
  strict private
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetIDChair: Integer;
    function GetIDSpecialityEducation: Integer;
    function GetID_StudyPlan: Integer; stdcall;
  private
    FCourseStudyPlanW: TCourseStudyPlanW;
    FIDChair: Integer;
    FIDSPECIALITYEDUCATION: Integer;
    FIDStudyPlan: Integer;
    FqDiscName: TQryDiscName;
    function GetDiscNameW: TDiscNameW;
  protected
    property DiscNameW: TDiscNameW read GetDiscNameW;
  public
    constructor Create(AOwner: TComponent; AIDStudyPlan: Integer;
        ACourseStudyPlanW: TCourseStudyPlanW; AQryDiscName: TQryDiscName; AIDChair,
        AIDSPECIALITYEDUCATION: Integer); reintroduce;
    function ApplyDisciplines(AIDDisciplineName: Integer;
      ADiscNameInt: IDiscName): Integer;
    procedure CancelDisciplines;
  end;

implementation

constructor TCourseStudyPlanEditModel.Create(AOwner: TComponent; AIDStudyPlan:
    Integer; ACourseStudyPlanW: TCourseStudyPlanW; AQryDiscName: TQryDiscName;
    AIDChair, AIDSPECIALITYEDUCATION: Integer);
begin
  inherited Create(AOwner);
  FIDStudyPlan := AIDStudyPlan;
  FCourseStudyPlanW := ACourseStudyPlanW;
  FqDiscName := AQryDiscName;
  FIDChair := AIDChair;
  FIDSPECIALITYEDUCATION := AIDSPECIALITYEDUCATION;
end;

function TCourseStudyPlanEditModel.ApplyDisciplines(AIDDisciplineName: Integer;
  ADiscNameInt: IDiscName): Integer;
begin
  // Тут у нас пока может ID = NULL
  DiscNameW.LocateByPK(AIDDisciplineName, True);
  DiscNameW.UpdateShortCaption(ADiscNameInt.ShortDisciplineName);

  // Наконец-то сохраняем сделанные изменения в БД
  FqDiscName.FDQuery.ApplyUpdates(0);
  FqDiscName.FDQuery.CommitUpdates;

  // Тут должен появиться положительный ID
  Assert(FqDiscName.W.PK.AsInteger > 0);
  Result := FqDiscName.W.PK.AsInteger;
end;

procedure TCourseStudyPlanEditModel.CancelDisciplines;
begin
  FqDiscName.FDQuery.CancelUpdates;
end;

function TCourseStudyPlanEditModel.GetCourseStudyPlanW: TCourseStudyPlanW;
begin
  Result := FCourseStudyPlanW;
end;

function TCourseStudyPlanEditModel.GetDiscNameW: TDiscNameW;
begin
  Result := FqDiscName.W;
end;

function TCourseStudyPlanEditModel.GetIDChair: Integer;
begin
  Result := FIDChair;
end;

function TCourseStudyPlanEditModel.GetIDSpecialityEducation: Integer;
begin
  Result := FIDSPECIALITYEDUCATION;
end;

function TCourseStudyPlanEditModel.GetID_StudyPlan: Integer;
begin
  Result := FIDStudyPlan;
end;

end.
