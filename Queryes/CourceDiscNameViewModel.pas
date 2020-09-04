unit CourceDiscNameViewModel;

interface

uses
  System.Classes, DiscNameQry, DiscNameInt, InsertEditMode, CourseStudyPlanQry,
  CourseStudyPlanInterface;

type
  TCourceDiscNameVM = class(TComponent)
  private
    FCourseStudyPlanW: TCourseStudyPlanW;
    FIDChair: Integer;
    FIDSPECIALITYEDUCATION: Integer;
    FqDiscName: TQryDiscName;
    function GetDiscNameW: TDiscNameW;
  public
    constructor Create(AOwner: TComponent; ACourseStudyPlanW: TCourseStudyPlanW;
      AQryDiscName: TQryDiscName; AIDChair, AIDSPECIALITYEDUCATION: Integer);
      reintroduce;
    function ApplyDisciplines(AIDDisciplineName: Integer;
      ADiscNameInt: IDiscName): Integer;
    procedure ApplyCourseStudyPlan(ACourseStudyPlanInt: ICourseStudyPlan;
      AMode: TMode);
    procedure CancelUpdates;
    property DiscNameW: TDiscNameW read GetDiscNameW;
    property CourseStudyPlanW: TCourseStudyPlanW read FCourseStudyPlanW;
    property IDChair: Integer read FIDChair;
    property IDSPECIALITYEDUCATION: Integer read FIDSPECIALITYEDUCATION;
  end;

implementation

constructor TCourceDiscNameVM.Create(AOwner: TComponent;
  ACourseStudyPlanW: TCourseStudyPlanW; AQryDiscName: TQryDiscName;
  AIDChair, AIDSPECIALITYEDUCATION: Integer);
begin
  inherited Create(AOwner);
  FCourseStudyPlanW := ACourseStudyPlanW;
  FqDiscName := AQryDiscName;
  FIDChair := AIDChair;
  FIDSPECIALITYEDUCATION := AIDSPECIALITYEDUCATION;
  ACourseStudyPlanW.SaveBookmark;
end;

function TCourceDiscNameVM.ApplyDisciplines(AIDDisciplineName: Integer;
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

procedure TCourceDiscNameVM.ApplyCourseStudyPlan(ACourseStudyPlanInt
  : ICourseStudyPlan; AMode: TMode);
var
  OK: Boolean;
begin
  OK := FCourseStudyPlanW.RestoreBookmark;

  // если мы редактировали дисциплину,
  // то обязательно должны вернуться к редактируемой записи, перед сохранением
  if AMode = EditMode then
    Assert(OK);

  FCourseStudyPlanW.Save(ACourseStudyPlanInt, AMode);
end;

procedure TCourceDiscNameVM.CancelUpdates;
begin
  FqDiscName.FDQuery.CancelUpdates;
end;

function TCourceDiscNameVM.GetDiscNameW: TDiscNameW;
begin
  Result := FqDiscName.W;
end;

end.
