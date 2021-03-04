program StudyPlan;

uses
  Vcl.Forms,
  System.Sysutils,
  DocumentView in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\DocumentView\DocumentView.pas' {View: TFrame},
  ViewEx in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\DocumentView\ViewEx.pas' {View_Ex: TFrame},
  DataSetView_2 in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\DataSet\View\DataSetView_2.pas' {DataSetView2: TFrame},
  ViewForm in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\DocumentView\ViewForm.pas' {frmView},
  ViewFormEx in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\DocumentView\ViewFormEx.pas' {frmViewEx},
  CutCopyPaste in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\CutCopyPaste.pas',
  cxComboBoxGridView in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\ComboBox\ComboBoxView\cxComboBoxGridView.pas',
  EssenceGridView in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\DataSet\Essence\View\EssenceGridView.pas' {dsgvEssence: TDataSetView2},
  DBTreeListView in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\DataSet\View\DBTreeListView.pas' {viewDBTreeList: TFrame},
  GridComboBox in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Kulakov\ComboBox\GridComboBox.pas' {cxGridComboBoxView: TView_Ex},
  CSE in 'CSE.pas',
  CSEDBTreeListView in 'CSEDBTreeListView.pas',
  DisciplineNames in 'DisciplineNames.pas',
  GridComboBoxViewEx in 'GridComboBoxViewEx.pas' {cxGridCBViewEx},
  Main in 'Main.pas' {frmMain},
  MessageForm in 'MessageForm.pas' {frmMessage},
  MyConnection in 'MyConnection.pas',
  SPDBTreeListView in 'SPDBTreeListView.pas',
  SpecEducationGridComboBoxView in 'SpecEducationGridComboBoxView.pas',
  SpecialitySessions in 'SpecialitySessions.pas',
  SPEditForm in 'SPEditForm.pas',
  SPEditView in 'SPEditView.pas',
  SPUnit in 'SPUnit.pas',
  SPView2 in 'SPView2.pas',
  SPViewDM in 'SPViewDM.pas' {DM: TDataModule},
  SS in 'SS.pas',
  Admissions in 'Admissions.pas',
  DPOStudyPlan in 'DPOStudyPlan.pas',
  StudGroups in 'StudGroups.pas',
  Lessons in 'Lessons.pas',
  LessonsView in 'LessonsView.pas',
  GFLTeachers in 'GFLTeachers.pas',
  StudyPlanFactors in 'StudyPlanFactors.pas',
  QuerysView in 'QuerysView.pas' {dsgvQuerys: TFrame},
  StudyPlanFactorsTreeListView in 'StudyPlanFactorsTreeListView.pas' {dbtlvStudyPlanFactors: TFrame},
  AdmissionView in 'AdmissionView.pas' {dsgvAdmission: TdsgvEssence},
  CopyProgressForm in 'CopyProgressForm.pas' {frmCopyProgress},
  CopyFactorsForm in 'CopyFactorsForm.pas' {frmCopyStudyPlanFactors},
  FactorEditView1 in 'FactorEditView1.pas' {viewFactorEditName: TFrame},
  FactorEditView2 in 'FactorEditView2.pas' {viewFactorEditQuery: TFrame},
  CustomFactorEditView in 'CustomFactorEditView.pas' {viewCustomFactorEdit: TFrame},
  FactorEditView3 in 'FactorEditView3.pas' {viewFactorEditRules: TFrame},
  FactorRulesView in 'FactorRulesView.pas' {dsgvFactorRules: TFrame},
  FactorsDBTreeView in 'FactorsDBTreeView.pas' {dbtlvFactors: TFrame},
  FactorsView2 in 'FactorsView2.pas' {viewFactors: TFrame},
  AddFactorForm in 'AddFactorForm.pas' {frmAddFactor},
  ParameterValuesView in 'ParameterValuesView.pas' {dsgvParameterValues: TFrame},
  StudyPlanFactorsView2 in 'StudyPlanFactorsView2.pas' {viewStudyPlanFactors: TFrame},
  CyclesView2 in 'CyclesView2.pas' {dsgvCycles: TFrame},
  CommissionOptions in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\CommissionOptions.pas',
  StudyProcessTools in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\StudyProcessTools.pas',
  Years in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\Years.pas',
  Chairs in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\Chairs.pas',
  Level in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\Level.pas',
  Specialitys in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\Specialitys.pas',
  EducationLevel in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\EducationLevel.pas',
  LessonTypes in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\LessonTypes.pas',
  SpecEducation in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\SpecEducation.pas',
  StudyPlanStandarts in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\StudyPlanStandarts.pas',
  SpecialitysGridComboBoxView in 'SpecialitysGridComboBoxView.pas' {cxSpecialitysGridCBViewEx: TFrame},
  Qualifications in 'Qualifications.pas',
  SpecialityGridView in 'SpecialityGridView.pas' {dsgvSpecialitys: TFrame},
  HourViewTypes in 'HourViewTypes.pas',
  UMKMaster in 'UMK\UMKMaster.pas',
  UMK in 'UMK\UMK.pas',
  StudyPlanForUMK in 'UMK\StudyPlanForUMK.pas',
  UMKMasterForm in 'UMK\UMKMasterForm.pas' {frmUMKMaster},
  UMKMasterView in 'UMK\UMKMasterView.pas' {viewUMKMaster: TFrame},
  SPForUMKView in 'UMK\SPForUMKView.pas' {dsgvSPForUMK: TFrame},
  ETP in 'UMK\ETP.pas',
  ETPView in 'UMK\ETPView.pas' {viewETP: TFrame},
  RearrangeUnit in 'RearrangeUnit.pas',
  LessonThemesUMKView in 'LessonThemesUMKView.pas' {viewLessonThemesForUMK: TFrame},
  UMKDataModule in 'UMKDataModule.pas' {UMKDM: TDataModule},
  PrepareUMKView in 'PrepareUMKView.pas' {viewPrepareUMK: TFrame},
  TeacherUnit in '..\Commission\Teachers\TeacherUnit.pas',
  ProgressBarForm in 'C:\Users\Public\Documents\Embarcadero\Studio\Components\Study_process\ProgressBarForm.pas' {frmProgressBar},
  DisciplineCompetence in 'DisciplineCompetence.pas',
  DisciplineCompetenceView in 'DisciplineCompetenceView.pas' {viewDisciplineCompetence: TFrame},
  AllCompetenceGridView in 'AllCompetenceGridView.pas' {dsgvAllCompetence: TFrame},
  LanguageConstants in 'LanguageConstants.pas',
  DisciplinePurposeView in 'DisciplinePurposeView.pas' {viewDisciplinePurpose: TFrame},
  StudyPlanInfo in 'StudyPlanInfo.pas',
  DisciplineLessonTypes in 'DisciplineLessonTypes.pas',
  Word2010Ex in 'Word2010Ex.pas',
  AdoptionDatesForm in 'AdoptionDatesForm.pas' {frmAdoptionDates},
  EducationalStandarts in 'EducationalStandarts.pas',
  StudyPlanAdoption in 'StudyPlanAdoption.pas',
  UMKAdoption in 'UMKAdoption.pas',
  ControlNames in 'ControlNames.pas',
  ThemeUnionControls in 'ThemeUnionControls.pas',
  ThemeUnionControlsView in 'ThemeUnionControlsView.pas' {dsgvThemeUnionControls: TFrame},
  PopupForm in 'PopupForm.pas' {frmPopupForm},
  IndependentWork in 'IndependentWork.pas',
  ThemeUnionIndependentWork in 'ThemeUnionIndependentWork.pas',
  SoftwareTypes in 'SoftwareTypes.pas',
  Software in 'Software.pas',
  SoftwareDocument in 'SoftwareDocument.pas',
  SoftwareView in 'SoftwareView.pas' {ViewSoftware: TFrame},
  SpecialitySessionsView in 'SpecialitySessionsView.pas' {gvSpecialitySessions: TFrame},
  SpecEducationView in 'SpecEducationView.pas' {gvSpecEducation: TFrame},
  DisciplineSoft in 'DisciplineSoft.pas',
  SoftUMKView in 'SoftUMKView.pas' {ViewSoftUMK: TFrame},
  PreviousDisciplines in 'PreviousDisciplines.pas',
  PreviousDisciplinesView in 'PreviousDisciplinesView.pas' {ViewCustomDisciplines: TFrame},
  EducationalWorks in 'EducationalWorks.pas',
  ThemeUnionEducationalWorks in 'ThemeUnionEducationalWorks.pas',
  LessonFeatures in 'LessonFeatures.pas',
  ThemeUnionLessonFeatures in 'ThemeUnionLessonFeatures.pas',
  technologies in 'technologies.pas',
  THEMEUNIONTECHNOLOGIES in 'THEMEUNIONTECHNOLOGIES.pas',
  ThemeUnionDetails in 'ThemeUnionDetails.pas',
  ETPCatalog in 'ETPCatalog.pas',
  ThemeQuestionTypes in 'ThemeQuestionTypes.pas',
  ThemeQuestions in 'ThemeQuestions.pas',
  StrHelper in 'helpers\StrHelper.pas',
  AbitConnector in 'AbitConnector.pas',
  ClipboardUnit in 'ClipboardUnit.pas',
  DisciplineLit in 'DisciplineLit.pas',
  DisciplineLitView in 'DisciplineLitView.pas' {viewDisciplineLit: TFrame},
  LibConnector in 'LibConnector.pas',
  RetrainingSpecialitys in 'RetrainingSpecialitys.pas',
  Dumb in 'Dumb.pas',
  SpecEducSimple in 'SpecEducSimple.pas',
  GridFrame in 'Views\GridFrame.pas' {frmGrid: TFrame},
  CourseGroup in 'Queryes\CourseGroup.pas',
  DragHelper in 'helpers\DragHelper.pas',
  TextRectHelper in 'helpers\TextRectHelper.pas',
  DialogUnit in 'helpers\DialogUnit.pas',
  FireDACDataModule in 'Queryes\FireDACDataModule.pas' {FireDACDM: TDataModule},
  BaseQuery in 'Queryes\BaseQuery.pas' {QueryBase: TFrame},
  AdmissionsQuery in 'Queryes\Admissions\AdmissionsQuery.pas' {QueryAdmissions: TFrame},
  CourseStudyPlanQry in 'Queryes\DPOSP\CourseStudyPlanQry.pas' {QryCourseStudyPlan: TFrame},
  DSWrap in 'Queryes\DSWrap.pas',
  ChairsQuery in 'Queryes\Chairs\ChairsQuery.pas' {QueryChairs: TFrame},
  CourseNameQuery in 'Queryes\CourseName\CourseNameQuery.pas' {QueryCourseName: TFrame},
  EditCourseForm in 'Views\CourcesView\EditCourseForm.pas' {frmEditCourse},
  CourseStudyPlanEditForm in 'Views\CourcesView\CourseStudyPlanEditForm.pas' {frmCourseStudyPlanEdit},
  InsertEditMode in 'helpers\InsertEditMode.pas',
  CycleSpecialityEducationQuery in 'Queryes\cyclespecialityeducations\CycleSpecialityEducationQuery.pas' {QueryCycleSpecialityEducations: TFrame},
  SpecialitySessionsQuery in 'Queryes\SpecialitySessions\SpecialitySessionsQuery.pas' {QuerySpecialitySessions: TFrame},
  StudyPlansQuery in 'Queryes\StudyPlans\StudyPlansQuery.pas' {QueryStudyPlans: TFrame},
  LessonTypeQuery in 'Queryes\LessonTypes\LessonTypeQuery.pas' {QueryLessonType: TFrame},
  CopyStudyPlanQuery in 'Queryes\CopyStudyPlan\CopyStudyPlanQuery.pas' {QueryCopyStudyPlan: TFrame},
  CountNameHelper in 'helpers\CountNameHelper.pas',
  StudentGroupsQuery in 'Queryes\StudentGroups\StudentGroupsQuery.pas' {QueryStudentGroups: TFrame},
  StudentGroupsView in 'Views\CourcesView\StudentGroupsView.pas' {ViewStudentGroups: TFrame},
  CreateVirtualStudentQuery in 'Queryes\VirtualStudents\CreateVirtualStudentQuery.pas' {QueryCreateVirtualStudent: TFrame},
  DropVirtualStudentQuery in 'Queryes\VirtualStudents\DropVirtualStudentQuery.pas' {QueryDropVirtualStudent: TFrame},
  CourseStudyPlanView in 'Views\CourcesView\CourseStudyPlanView.pas' {CourceStudyPlanView2: TFrame},
  CourseEdTypesQuery in 'Queryes\CourseEdTypes\CourseEdTypesQuery.pas' {QueryCourseEdType: TFrame},
  SpecEdQuery in 'Queryes\SpecialityEducations\SpecEdQuery.pas' {QuerySpecEd: TFrame},
  SpecEdView in 'Views\SpecEdView\SpecEdView.pas' {ViewSpecEd: TFrame},
  EdQuery in 'Queryes\Educations2\EdQuery.pas' {QueryEd: TFrame},
  EdLevelQuery in 'Queryes\Education_Level\EdLevelQuery.pas' {QueryEdLevel: TFrame},
  SPMainView in 'Views\SPView\SPMainView.pas' {ViewSPMain: TFrame},
  SPGroup in 'Queryes\SP\SPGroup.pas',
  SpecEdPopupView in 'Views\SPView\SpecEdPopupView.pas' {ViewSpecEdPopup: TFrame},
  SpecEdSimpleQuery in 'Queryes\SpecEdSimple\SpecEdSimpleQuery.pas' {QuerySpecEdSimple: TFrame},
  DBLookupComboBoxHelper in 'helpers\DBLookupComboBoxHelper.pas',
  SPQry in 'Queryes\SP\SPQry.pas' {QrySP: TFrame},
  SPMemTable in 'Queryes\SP\SPMemTable.pas',
  YearsQry in 'Queryes\Years\YearsQry.pas' {QryYears: TFrame},
  SpecEdBaseFormQry in 'Queryes\SP\SpecEdBaseFormQry.pas' {QrySpecEdBaseForm: TFrame},
  SPOView in 'Views\SPView\SPOView.pas' {ViewSPO: TFrame},
  VOView in 'Views\SPView\VOView.pas' {ViewVO: TFrame},
  RetrainingView in 'Views\SPView\RetrainingView.pas' {ViewRetraining: TFrame},
  EdLvlQry in 'Queryes\EducationLevel\EdLvlQry.pas' {QryEdLvl: TFrame},
  SpecEdSimpleQuery2 in 'Queryes\SpecEdSimple\SpecEdSimpleQuery2.pas' {QrySpecEdSimple2: TFrame},
  EditStudyPlanForm in 'Views\SPView\EditStudyPlanForm.pas' {frmEditStudyPlan},
  ChairUnionQry in 'Queryes\ChairUnion\ChairUnionQry.pas' {QryChairUnion: TFrame},
  SpecByChairQry in 'Queryes\SpecByChair\SpecByChairQry.pas' {QrySpecByChair: TFrame},
  SpecPopupView in 'Views\SPView\SpecPopupView.pas' {ViewSpecPopup: TFrame},
  QualificationQuery in 'Queryes\SP\QualificationQuery.pas' {QryQualifications: TFrame},
  CopyPlanForm in 'Views\SPView\CopyPlanForm.pas' {frmCopyPlan},
  DeleteCSEQuery in 'Queryes\SP\DeleteCSEQuery.pas' {QryDeleteCSE: TFrame},
  DeleteSPQuery in 'Queryes\SP\DeleteSPQuery.pas' {QryDeleteSP: TFrame},
  EditRetrainingPlanForm in 'Views\SPView\EditRetrainingPlanForm.pas' {frmEditRetrainingPlan},
  AreasQry in 'Queryes\AreasQuery\AreasQry.pas' {QryAreas: TFrame},
  OptionsHelper in 'helpers\OptionsHelper.pas',
  SPStandartQuery in 'Queryes\SPStandart\SPStandartQuery.pas' {QuerySPStandart: TFrame},
  DiscNameQry in 'Queryes\DisciplineNames\DiscNameQry.pas' {QryDiscName: TFrame},
  DiscNameGroup in 'Queryes\DisciplineNames\DiscNameGroup.pas',
  DiscNameView in 'Views\DiscNameView\DiscNameView.pas' {ViewDiscName: TFrame},
  GridViewForm in 'Views\GridViewForm.pas' {frmGridView},
  EditDisciplineFrm in 'Views\DiscNameView\EditDisciplineFrm.pas' {frmEditDisciplineName},
  DiscNameInt in 'Queryes\DisciplineNames\DiscNameInt.pas',
  SpecEdSimpleInt in 'Queryes\SpecEdSimple\SpecEdSimpleInt.pas',
  SpecSessQry in 'Queryes\SpecSess\SpecSessQry.pas' {QrySpecSess: TFrame},
  SessTypeQry in 'Queryes\SessType\SessTypeQry.pas' {QrySessType: TFrame},
  SpecSessView in 'Views\SpecSessView\SpecSessView.pas' {ViewSpecSess: TFrame},
  MaxSpecSessQry in 'Queryes\SpecSess\MaxSpecSessQry.pas' {QryMaxSpecSess: TFrame},
  EditSpecFrm in 'Views\SpecView\EditSpecFrm.pas' {frmEditSpec},
  SpecInt in 'Interfaces\SpecInt.pas',
  EditRetrainingSpecFrm in 'Views\SpecView\EditRetrainingSpecFrm.pas' {frmEditRetrainingSpec},
  SpecQry in 'Queryes\Spec\SpecQry.pas' {QrySpec: TFrame},
  FilesUpdater in 'FilesUpdater\FilesUpdater.pas',
  FRDataModule in 'helpers\FRDataModule.pas' {FRDM: TDataModule},
  FR3 in 'helpers\FR3.pas',
  ReportFilesUpdater in 'FilesUpdater\ReportFilesUpdater.pas',
  SpecUniqueQuery in 'Queryes\Spec\SpecUniqueQuery.pas' {QueryUniqueSpec: TFrame},
  SpecChiperUniqueQry in 'Queryes\Spec\SpecChiperUniqueQry.pas' {QrySpecChiper: TFrame},
  SpecNameUniqueQry in 'Queryes\Spec\SpecNameUniqueQry.pas' {QrySpecName: TFrame},
  ConnectionSettings in 'ConnectionSettings.pas',
  LockSPQry in 'Queryes\LockSPQry\LockSPQry.pas' {QryLockSP: TFrame},
  CourseStudyPlanEditModel in 'Queryes\CourseStudyPlanEditModel.pas',
  CourseStudyPlanInterface in 'Queryes\DPOSP\CourseStudyPlanInterface.pas',
  CourseStudyPlanModel in 'Queryes\DPOSP\CourseStudyPlanModel.pas',
  AdmissionsInterface in 'Queryes\Admissions\AdmissionsInterface.pas',
  MyDir in 'helpers\MyDir.pas',
  GetSpecEdBySP in 'Queryes\SP\GetSpecEdBySP.pas' {QryGetSpecEdBySP: TFrame},
  SpecEdSimpleWrap in 'Queryes\SpecEdSimple\SpecEdSimpleWrap.pas',
  FDDumb in 'Queryes\Dumb\FDDumb.pas',
  SPViewInterface in 'Interfaces\SPViewInterface.pas',
  SPRetrainingViewInterface in 'Interfaces\SPRetrainingViewInterface.pas',
  SPEditInterface in 'Interfaces\SPEditInterface.pas',
  SpecEditInterface in 'Interfaces\SpecEditInterface.pas',
  SPRetrainingEditInterface in 'Interfaces\SPRetrainingEditInterface.pas',
  GridExtension in 'helpers\GridExtension.pas',
  CourseEditInterface in 'Interfaces\CourseEditInterface.pas',
  CourseStudyPlanViewInterface in 'Interfaces\CourseStudyPlanViewInterface.pas',
  CourseStudyPlanEditInterface in 'Interfaces\CourseStudyPlanEditInterface.pas',
  CoursesView in 'Views\CourcesView\CoursesView.pas' {ViewCourses: TFrame},
  CourseViewInterface in 'Interfaces\CourseViewInterface.pas',
  CourseNameInterface in 'Interfaces\CourseNameInterface.pas',
  DiscNameViewInterface in 'Interfaces\DiscNameViewInterface.pas',
  CSEQry in 'Queryes\CSEQry\CSEQry.pas' {QueryCSE: TFrame},
  ViewCSE in 'Views\CSEView\ViewCSE.pas' {ViewCSEFrame: TFrame},
  CyclesQry in 'Queryes\cycles\CyclesQry.pas' {QueryCycles: TFrame},
  CycleTypesQuery in 'Queryes\CycleTypes\CycleTypesQuery.pas' {QueryCycleTypes: TFrame},
  CyclesView in 'Views\CyclesView\CyclesView.pas' {ViewCycles: TFrame},
  CycleServiceInterface in 'Interfaces\CycleServiceInterface.pas',
  CSEServiceInterface in 'Interfaces\CSEServiceInterface.pas',
  CSEService in 'Queryes\CSEQry\CSEService.pas',
  SPEditView2 in 'Views\SPView\SPEditView2.pas' {Frame1: TFrame},
  CSEForm in 'Views\CSEView\CSEForm.pas',
  SpecSessServiceInterface in 'Interfaces\SpecSessServiceInterface.pas',
  SpecSessService in 'Queryes\SpecSess\SpecSessService.pas',
  SpecSessForm in 'Views\SpecSessView\SpecSessForm.pas',
  SpecEdService in 'Queryes\SpecialityEducations\SpecEdService.pas',
  SpecEdServiceInterface in 'Interfaces\SpecEdServiceInterface.pas';

{$R *.res}

begin
  FormatSettings.LongMonthNames[1] := '������';
  FormatSettings.LongMonthNames[2] := '�������';
  FormatSettings.LongMonthNames[3] := '�����';
  FormatSettings.LongMonthNames[4] := '������';
  FormatSettings.LongMonthNames[5] := '���';
  FormatSettings.LongMonthNames[6] := '����';
  FormatSettings.LongMonthNames[7] := '����';
  FormatSettings.LongMonthNames[8] := '�������';
  FormatSettings.LongMonthNames[9] := '��������';
  FormatSettings.LongMonthNames[10] := '�������';
  FormatSettings.LongMonthNames[11] := '������';
  FormatSettings.LongMonthNames[12] := '�������';

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '������� ����';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
