inherited viewETP: TviewETP
  Width = 618
  ExplicitWidth = 618
  inherited pnlGrid: TPanel
    Width = 618
    ExplicitWidth = 618
    inherited cxGrid: TcxGrid
      Top = 35
      Width = 616
      Height = 411
      ExplicitTop = 35
      ExplicitWidth = 616
      ExplicitHeight = 411
      inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
        OnCustomDrawCell = cx_dbbtvcxg1DBBandedTableView1CustomDrawCell
        DataController.KeyFieldNames = 'ID_SessionUnion'
        DataController.Summary.Options = [soNullIgnore]
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = False
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = True
        OptionsView.Footer = True
        OptionsView.FooterAutoHeight = True
        OptionsView.BandHeaders = False
        Styles.Footer = DM.cxstyl14
      end
      object gdbbtvThemeUnions: TcxGridDBBandedTableView [1]
        DragMode = dmAutomatic
        OnDragDrop = gdbbtvThemeUnionsDragDrop
        OnDragOver = gdbbtvThemeUnionsDragOver
        OnKeyDown = cxGridDBBandedTableViewKeyDown
        OnMouseDown = cxGridDBBandedTableViewMouseDown
        OnStartDrag = gdbbtvThemeUnionsStartDrag
        Navigator.Buttons.CustomButtons = <>
        DataController.DetailKeyFieldNames = 'IDSessionUnion'
        DataController.KeyFieldNames = 'ID_ThemeUnion'
        DataController.MasterKeyFieldNames = 'ID_SessionUnion'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.Options = [soNullIgnore]
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.EditAutoHeight = eahEditor
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsView.ScrollBars = ssNone
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.BandHeaders = False
        Styles.Footer = DM.cxstyl14
        OnLeftPosChanged = gdbbtvThemeUnionsLeftPosChanged
        Bands = <
          item
          end>
        object cxgdbbcMaxMark: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Max_Mark'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.ImmediatePost = True
          Properties.MaxValue = 100.000000000000000000
          OnGetDisplayText = cxgdbbcMaxMarkGetDisplayText
          MinWidth = 45
          Options.AutoWidthSizable = False
          Width = 45
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object gdbbtvLessonThemes: TcxGridDBBandedTableView [2]
        DragMode = dmAutomatic
        OnDragDrop = gdbbtvLessonThemesDragDrop
        OnDragOver = gdbbtvLessonThemesDragOver
        OnKeyDown = cxGridDBBandedTableViewKeyDown
        OnMouseDown = cxGridDBBandedTableViewMouseDown
        OnStartDrag = gdbbtvLessonThemesStartDrag
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = gdbbtvLessonThemesCustomDrawCell
        DataController.DetailKeyFieldNames = 'IDThemeUnion'
        DataController.KeyFieldNames = 'IDLessonTheme'
        DataController.MasterKeyFieldNames = 'ID_ThemeUnion'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.Options = [soNullIgnore]
        DataController.OnDetailExpanding = gdbbtvLessonThemesDataControllerDetailExpanding
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.DragDropText = True
        OptionsBehavior.EditAutoHeight = eahEditor
        OptionsBehavior.ExpandMasterRowOnDblClick = False
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsView.ScrollBars = ssNone
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.BandHeaders = False
        Styles.Footer = DM.cxstyl14
        Bands = <
          item
          end>
      end
      object gdbbtvThemeUnionControls: TcxGridDBBandedTableView [3]
        OnKeyDown = cxGridDBBandedTableViewKeyDown
        OnMouseDown = cxGridDBBandedTableViewMouseDown
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyDown = gdbbtvThemeUnionControlsEditKeyDown
        DataController.DetailKeyFieldNames = 'IDThemeUnion'
        DataController.KeyFieldNames = 'ID_ThemeUnionControl'
        DataController.MasterKeyFieldNames = 'ID_ThemeUnion'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.EditAutoHeight = eahEditor
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsData.Appending = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.BandHeaders = False
        Bands = <
          item
          end>
        object cxgdbbcControlName: TcxGridDBBandedColumn
          DataBinding.FieldName = 'IDControlName'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.DropDownAutoSize = True
          Properties.DropDownListStyle = lsEditList
          Properties.DropDownSizeable = True
          Properties.ImmediatePost = True
          Properties.KeyFieldNames = 'ID_ControlName'
          Properties.ListColumns = <
            item
              FieldName = 'ControlName'
            end>
          Properties.OnChange = cxgdbbcControlNamePropertiesChange
          Properties.OnNewLookupDisplayText = cxgdbbcControlNamePropertiesNewLookupDisplayText
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object gdbbtvThemeUnionIndependentWork: TcxGridDBBandedTableView [4]
        OnKeyDown = cxGridDBBandedTableViewKeyDown
        OnMouseDown = cxGridDBBandedTableViewMouseDown
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyDown = gdbbtvThemeUnionIndependentWorkEditKeyDown
        DataController.DetailKeyFieldNames = 'IDThemeUnion'
        DataController.KeyFieldNames = 'ID_ThemeUnionIndependentWork'
        DataController.MasterKeyFieldNames = 'ID_ThemeUnion'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsData.Appending = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.BandHeaders = False
        Bands = <
          item
          end>
        object clIndependentWork: TcxGridDBBandedColumn
          DataBinding.FieldName = 'IDIndependentWork'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.DropDownAutoSize = True
          Properties.DropDownListStyle = lsEditList
          Properties.DropDownSizeable = True
          Properties.KeyFieldNames = 'ID_IndependentWork'
          Properties.ListColumns = <
            item
              FieldName = 'IndependentWork'
            end>
          Properties.OnChange = cxgdbbcIndependentWorkPropertiesChange
          Properties.OnEditValueChanged = cxgdbbcIndependentWorkPropertiesEditValueChanged
          Properties.OnNewLookupDisplayText = cxgdbbcIndependentWorkPropertiesNewLookupDisplayText
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object gdbbtvThemeUnionEducationalWorks: TcxGridDBBandedTableView [5]
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyDown = gdbbtvThemeUnionEducationalWorksEditKeyDown
        DataController.DetailKeyFieldNames = 'IDThemeUnion'
        DataController.KeyFieldNames = 'ID_ThemeUnionEducationalWork'
        DataController.MasterKeyFieldNames = 'ID_ThemeUnion'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsData.Appending = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.BandHeaders = False
        Bands = <
          item
          end>
        object clEducationalWork: TcxGridDBBandedColumn
          DataBinding.FieldName = 'IDEducationalWork'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.DropDownListStyle = lsEditList
          Properties.ListColumns = <>
          Properties.OnNewLookupDisplayText = clEducationalWorkPropertiesNewLookupDisplayText
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object gdbbtvThemeUnionLessonFeature: TcxGridDBBandedTableView [6]
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyDown = gdbbtvThemeUnionLessonFeatureEditKeyDown
        DataController.DetailKeyFieldNames = 'IDThemeUnion'
        DataController.KeyFieldNames = 'ID_ThemeUnionLessonFeature'
        DataController.MasterKeyFieldNames = 'ID_ThemeUnion'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsData.Appending = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.BandHeaders = False
        Bands = <
          item
          end>
        object clLessonFeature: TcxGridDBBandedColumn
          DataBinding.FieldName = 'IDLessonFeature'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.DropDownListStyle = lsEditList
          Properties.ListColumns = <>
          Properties.OnNewLookupDisplayText = clLessonFeaturePropertiesNewLookupDisplayText
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object gdbbtvThemeUnionTechnologies: TcxGridDBBandedTableView [7]
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyDown = gdbbtvThemeUnionTechnologiesEditKeyDown
        DataController.DetailKeyFieldNames = 'IDThemeUnion'
        DataController.KeyFieldNames = 'ID_ThemeUnionTechnology'
        DataController.MasterKeyFieldNames = 'ID_ThemeUnion'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsData.Appending = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.BandHeaders = False
        Bands = <
          item
          end>
        object clIDTechnology: TcxGridDBBandedColumn
          DataBinding.FieldName = 'IDTechnology'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.DropDownListStyle = lsEditList
          Properties.ListColumns = <>
          Properties.OnNewLookupDisplayText = clIDTechnologyPropertiesNewLookupDisplayText
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object gdbbtvThemeQuestions: TcxGridDBBandedTableView [8]
        DragMode = dmAutomatic
        OnDragDrop = gdbbtvThemeQuestionsDragDrop
        OnDragOver = gdbbtvThemeQuestionsDragOver
        OnKeyDown = cxGridDBBandedTableViewKeyDown
        OnMouseDown = cxGridDBBandedTableViewMouseDown
        OnStartDrag = gdbbtvThemeQuestionsStartDrag
        Navigator.Buttons.CustomButtons = <>
        DataController.DetailKeyFieldNames = 'IDLessonTheme'
        DataController.KeyFieldNames = 'ID_ThemeQuestion'
        DataController.MasterKeyFieldNames = 'IDLessonTheme'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.EditAutoHeight = eahRow
        OptionsBehavior.ExpandMasterRowOnDblClick = False
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsSelection.MultiSelect = True
        OptionsView.ScrollBars = ssNone
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.BandHeaders = False
        Bands = <
          item
          end>
        object clThemeQuestionType: TcxGridDBBandedColumn
          Caption = #1048#1079#1091#1095#1077#1085#1080#1077
          DataBinding.FieldName = 'IDThemeQuestionType'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.ListColumns = <>
          MinWidth = 150
          Options.AutoWidthSizable = False
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      inherited cxGridLevel: TcxGridLevel
        object glThemeUnions: TcxGridLevel
          GridView = gdbbtvThemeUnions
          object glLessonThemes: TcxGridLevel
            Caption = #1058#1077#1084#1099
            GridView = gdbbtvLessonThemes
            object glThemeQuestions: TcxGridLevel
              GridView = gdbbtvThemeQuestions
              Visible = False
            end
          end
          object glThemeUnionControls: TcxGridLevel
            Caption = #1058#1077#1082#1091#1097#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1100
            GridView = gdbbtvThemeUnionControls
          end
          object glThemeUnionIndependentWork: TcxGridLevel
            GridView = gdbbtvThemeUnionIndependentWork
          end
          object glThemeUnionEducationalWorks: TcxGridLevel
            GridView = gdbbtvThemeUnionEducationalWorks
          end
          object glThemeUnionLessonFeature: TcxGridLevel
            GridView = gdbbtvThemeUnionLessonFeature
          end
          object glThemeUnionTechnologies: TcxGridLevel
            GridView = gdbbtvThemeUnionTechnologies
          end
        end
      end
    end
    object tbdckTop: TTBDock
      Left = 1
      Top = 1
      Width = 616
      Height = 34
      object tbtlbrSave: TTBToolbar
        Left = 0
        Top = 0
        Caption = 'tbtlbrSave'
        DockPos = -6
        Images = ilETP
        TabOrder = 0
        object TBItem7: TTBItem
          Action = actAddDE
        end
        object TBItem6: TTBItem
          Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1079#1076#1077#1083
          ImageIndex = 6
          Visible = False
        end
        object TBSeparatorItem2: TTBSeparatorItem
        end
        object tbiAdd: TTBItem
          Action = actAddLessonTheme
        end
        object tbiAddQuestion: TTBItem
          Action = actAddAudQuestion
          DisplayMode = nbdmImageAndText
        end
        object tbiAddSelfQuestion: TTBItem
          Action = actAddSelfQuestion
          DisplayMode = nbdmImageAndText
        end
        object TBItem5: TTBItem
          Action = actDelete
        end
        object TBSeparatorItem1: TTBSeparatorItem
        end
        object TBItem1: TTBItem
          Action = actSave
        end
        object TBItem2: TTBItem
          Action = actUndo
        end
      end
      object TBToolbar1: TTBToolbar
        Left = 177
        Top = 0
        Caption = 'TBToolbar1'
        DockPos = 160
        Images = ilCutCopyPaste
        TabOrder = 1
        object tbiCopy: TTBItem
          Action = actCopy
        end
        object tbiPaste: TTBItem
          Action = actPaste
        end
      end
      object TBToolbar2: TTBToolbar
        Left = 249
        Top = 0
        Caption = 'TBToolbar2'
        DockPos = 233
        TabOrder = 2
        object TBItem4: TTBItem
          Action = actReport
          DisplayMode = nbdmTextOnlyInMenus
          Images = ilETP
        end
        object tbi1: TTBItem
          Caption = 'Center'
          Visible = False
          OnClick = tbi1Click
        end
      end
      object TBToolbar3: TTBToolbar
        Left = 290
        Top = 0
        Caption = 'TBToolbar3'
        DockPos = 255
        TabOrder = 3
        object tbsmiShow: TTBSubmenuItem
          Caption = #1058#1077#1084#1099
          object tbiShowLessonThemes: TTBItem
            Action = actShowLessonThemes
          end
          object TBItem8: TTBItem
            Action = actShowThemeUnionControls
          end
          object TBItem3: TTBItem
            Action = actShowThemeUnionIndependentWork
          end
          object TBItem9: TTBItem
            Action = actShowThemeUnionEducationalWorks
          end
          object TBItem12: TTBItem
            Action = actShowThemeUnionTechnologies
          end
          object TBItem10: TTBItem
            Action = actShowThemeUnionLessonFeatures
          end
        end
      end
    end
  end
  object actlstLessonThemes: TActionList
    Images = ilETP
    Left = 40
    Top = 56
    object actSave: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 2
      OnExecute = actSaveExecute
    end
    object actUndo: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 3
      OnExecute = actUndoExecute
    end
    object actAddLessonTheme: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1077#1084#1091
      ImageIndex = 0
      OnExecute = actAddLessonThemeExecute
    end
    object actAddAudQuestion: TAction
      Caption = #1040#1091#1076'.'
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1086#1087#1088#1086#1089' '#1076#1083#1103' '#1072#1091#1076#1080#1090#1086#1088#1085#1086#1075#1086' '#1080#1079#1091#1095#1077#1085#1080#1103
      ImageIndex = 9
      Visible = False
      OnExecute = actAddAudQuestionExecute
    end
    object actAddSelfQuestion: TAction
      Caption = #1057#1072#1084'.'
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1086#1087#1088#1086#1089' '#1076#1083#1103' '#1089#1072#1084#1086#1089#1090#1086#1103#1090#1077#1083#1100#1085#1086#1075#1086' '#1080#1079#1091#1095#1077#1085#1080#1103
      ImageIndex = 9
      Visible = False
      OnExecute = actAddSelfQuestionExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1084#1091
      ImageIndex = 1
      OnExecute = actDeleteExecute
    end
    object actAddDE: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1072#1079#1076#1077#1083
      ImageIndex = 7
      OnExecute = actAddDEExecute
    end
    object actReport: TAction
      Caption = #1058#1077#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1087#1083#1072#1085
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1087#1083#1072#1085' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1077' Word'
      ImageIndex = 8
      OnExecute = actReportExecute
    end
    object acttest: TAction
      Caption = 'acttest'
      OnExecute = acttestExecute
    end
    object actShowLessonThemes: TAction
      Caption = #1058#1077#1084#1099
      Checked = True
      GroupIndex = 1
      OnExecute = actShowLessonThemesExecute
    end
    object actShowThemeUnionControls: TAction
      Caption = #1058#1077#1082#1091#1097#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1100
      GroupIndex = 1
      OnExecute = actShowThemeUnionControlsExecute
    end
    object actShowThemeUnionIndependentWork: TAction
      Caption = #1057#1072#1084#1086#1089#1090#1086#1103#1090#1077#1083#1100#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' '#1089#1090#1091#1076#1077#1085#1090#1072
      GroupIndex = 1
      OnExecute = actShowThemeUnionIndependentWorkExecute
    end
    object actShowThemeUnionEducationalWorks: TAction
      Caption = #1042#1080#1076#1099' '#1091#1095#1077#1073#1085#1086#1081' '#1088#1072#1073#1086#1090#1099
      GroupIndex = 1
      OnExecute = actShowThemeUnionEducationalWorksExecute
    end
    object actShowThemeUnionLessonFeatures: TAction
      Caption = #1054#1089#1086#1073#1077#1085#1085#1086#1089#1090#1080' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1079#1072#1085#1103#1090#1080#1081
      GroupIndex = 1
      Hint = #1054#1089#1086#1073#1077#1085#1085#1086#1089#1090#1080' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1079#1072#1085#1103#1090#1080#1081
      OnExecute = actShowThemeUnionLessonFeaturesExecute
    end
    object actShowThemeUnionTechnologies: TAction
      Caption = #1054#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1100#1085#1099#1077' '#1090#1077#1093#1085#1086#1083#1086#1075#1080#1080
      GroupIndex = 1
      Hint = #1054#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1100#1085#1099#1077' '#1090#1077#1093#1085#1086#1083#1086#1075#1080#1080
      OnExecute = actShowThemeUnionTechnologiesExecute
    end
    object actAddThemeUnionControl: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1100
      ImageIndex = 0
      OnExecute = actAddThemeUnionControlExecute
    end
    object actAddThemeUnionIndependentWork: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1080#1076' '#1089#1072#1084#1086#1089#1090#1086#1103#1090#1077#1083#1100#1085#1086#1081' '#1088#1072#1073#1086#1090#1099' '#1089#1090#1091#1076#1077#1085#1090#1072
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1080#1076' '#1089#1072#1084#1086#1089#1090#1086#1103#1090#1077#1083#1100#1085#1086#1081' '#1088#1072#1073#1086#1090#1099' '#1089#1090#1091#1076#1077#1085#1090#1072
      ImageIndex = 0
      OnExecute = actAddThemeUnionIndependentWorkExecute
    end
    object actAddThemeUnionEducationalWork: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1080#1076' '#1091#1095#1077#1073#1085#1086#1081' '#1088#1072#1073#1086#1090#1099
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1080#1076' '#1091#1095#1077#1073#1085#1086#1081' '#1088#1072#1073#1086#1090#1099
      ImageIndex = 0
      OnExecute = actAddThemeUnionEducationalWorkExecute
    end
    object actAddThemeUnionLessonFeature: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1089#1086#1073#1077#1085#1085#1086#1089#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1079#1072#1085#1103#1090#1080#1081
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1089#1086#1073#1077#1085#1085#1086#1089#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1079#1072#1085#1103#1090#1080#1081
      ImageIndex = 0
      OnExecute = actAddThemeUnionLessonFeatureExecute
    end
    object actAddThemeUnionTechnology: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1100#1085#1091#1102' '#1090#1077#1093#1085#1086#1083#1086#1075#1080#1102
      ImageIndex = 0
      OnExecute = actAddThemeUnionTechnologyExecute
    end
  end
  object ilETP: TImageList
    ColorDepth = cd32Bit
    Height = 24
    Width = 24
    Left = 216
    Top = 56
    Bitmap = {
      494C01010A007800300118001800FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000480000000100200000000000006C
      00000000000000000000000000000000000000000000000000040404040E0505
      0513050505170505051A0505051C0505051E0505051F05050520050505200505
      052105050521050505200505051F0505051F0202021C00000017000000150000
      00110000000D0000000900000002000000000000000000000000000000000000
      00000000000000000000000000001717151F5C5952778F8A7FB9ADA79CE3BEB9
      ACF9BEB9ACF9ADA79CE38C877FB85B5851761716151E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000211111127727070A5817E
      7EBD817E7EC0817E7EC2837F7FC3827F7FC4827F7DC4827E7EC5827E7CC5817E
      7CC6817C7BC6807B7BC57F7B7BC57E7B79C55F5B5BAE0C0B0B54000000300000
      002C00000025000000190000000A000000010000000000000000000000000000
      0000000000001716151E7F7B73A7C1BCAEFDC2BBADFEA09B8ED17C776EA06765
      5D8767655D877C776EA0A19B91D2C2BBADFEC2BCAEFC7E7B72A51515141D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004C4B4A53E4DFDFF4EEE8
      E7FFEDE7E6FFECE6E5FFEBE5E4FFEBE4E3FFE9E3E1FFE9E2E1FFE8E1E0FFE7DF
      DEFFE6DFDDFFE5DEDBFFE5DCDBFFE3DBDAFFCFC7C6FFA6A0A0DA0D0C0C300000
      0002000000020000000100000000000000000000000000000000000000000000
      000045433E5ABBB3A8F3BBB6A5F469645E881717151F00000000000000000000
      00000000000000000000000000001918162069665F89BCB5AAF6BBB2A5F24241
      3C57000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052505054E3DEDCF4ECE6
      E7FFECE6E5FFEAE4E3FFEAE5E4FFEAE3E2FFE9E1E1FFE7E2DFFFE7E0DFFFE5DF
      DEFFE6DDDDFFE4DDDBFFE4DCD9FFE3DBDAFFCEC6C5FFDFD9D8FFB0A9A7D80F0E
      0E25000000010000000000000000000000000000000000000000000000005A56
      5074C5BEB0FF969186C21716151E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000019181620969187C4C5BE
      B0FF56544E710000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052505054E3DFDEF4EDE8
      E7FFEDE7E6FFECE6E5FFEBE5E4FFEAE4E3FFEAE3E2FFE9E2E1FFE8E1E0FFE7E0
      DFFFE6DFDEFFE5DEDDFFE4DDDBFFE4DCDAFFD0C9C7FFDCD6D4FFE7E0DEFF8782
      80B30F0E0E25000000000000000000000000000000000000000046443F5BC5BE
      B0FF837E75A90404030500000000000000000000000000000000000101011B49
      34601A47335E000101010000000000000000000000000000000005040406827E
      74ABC5BEB0FF42413C5700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052505054E4DFDFF4EEE8
      E8FFEDE8E7FFECE6E7FFECE6E5FFEBE6E5FFECE8ECFFEBE8EDFFE9E4E8FFE7E2
      E0FFE7E1E0FFE6DFDEFFE6DEDDFFE4DEDEFFDFD7D7FFE6E1E0FFEDE7E7FFE8E2
      E0FFAFA9A7D81110102C0000000000000000000000001717151FBBB6A5F4948F
      83C10404030500000000000000000000000000000000000000001C4A356149C3
      8BFF49C38BFF1A47335E00000000000000000000000000000000000000000504
      0406969187C4BBB2A5F21515131C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052505054E5E0DFF4EEEA
      E8FFEEE9E8FFEEE8E6FFECE7E7FFE1D7CDFFC69429FFC58800FFD5AD45FFE8E0
      DCFFE7E2E0FFE7E0E0FFE1D8CDFFD6BF92FFDFD2C3FFE3DBDAFFE1D9D8FFE1D9
      D8FFDED6D5FFB1A9A7CE101010140000000000000000837E75A9BBB6A5F41716
      151E0000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      000019181620BCB5AAF67E7B72A5000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052515154E5E0E0F4EFEB
      EAFFEFE9E9FFEEE9E8FFEDE8E9FFC7A55CFFD59401FFE2AA09FFC89914FFD2BA
      86FFEAE4E6FFD9CDBDFFC7900DFFD79A03FFCC9E28FFE1D8D1FFE4DCDAFFE3DB
      D9FFE1D9D8FFC3BDBADF2625242B0000000019181620C1BCAEFD67655D870000
      00000000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      00000000000069665F89C2BCAEFC1716151E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052515154E6E1E0F4F0EB
      EAFFEFEBEAFFEEEAE8FFE8E0DDFFCE9F38FFDEA100FFE4B41FFFB48418FFB886
      13FFEDE8EFFFC9A95DFFD99B01FFE2B018FFB27D13FFD7C2A4FFE4DEDDFFE4DC
      DAFFE3DBDAFFC5BEBDDF2625252A000000005D5A5479C2BBADFE1716151E0000
      00000000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      00000000000019181620C2BBADFE5B5851760000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052515154E7E2E2F4F0EB
      ECFFF0EBEBFFF0EBEAFFE5DACAFFD09A1AFFE0A700FFDEB12CFFAA7710FFAE72
      00FFDCCCB2FFD1A134FFDFA600FFDAAD2AFFA87209FFCCAD72FFE7E0E1FFE4DD
      DBFFE4DCD9FFC6BFBEDF2625252A000000008F8B80BBA0988FCF000000000000
      00000000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      00000000000000000000A19B91D28C877FB80000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052515154E6E2E2F4F2EC
      EDFFF1ECEBFFF0EBEBFFE2D2B7FFD29604FFE2AB01FFD8AC36FF9C6906FFAA72
      00FFC09D4CFFD49C10FFE4AE08FFCB9F2FFF9F6800FFC49A44FFE7E2E5FFE5DE
      DDFFE4DDDBFFC7C0BFDF2625252A00000000B1AA9CE579756B9D000000000000
      0000000101011B49346025624680256246802562468025624680379369C049C3
      8BFF49C38BFF379369C0256246802562468025624680256246801A47335E0001
      010100000000000000007C776EA0ADA79CE30000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000054525254E8E3E3F4F1ED
      EDFFF2ECEDFFF2EEF0FFD3B882FFDB9D00FFE4B00EFFDAB454FF9A6910FFA46D
      00FFA17104FFDCA200FFE7B726FFB48928FFA06A00FFB98410FFEAE5E9FFE6DF
      DEFFE6DDDDFFC7C1C0DF2625252A00000000BFB8ACFA68635C86000000000000
      00001C4A356149C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C3
      8BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF1A47
      335E000000000000000067655D87BEB9ACF90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000054525254E7E4E4F4F2ED
      EDFFF2EDEDFFF4F1F6FFCBA03DFFDEA200FFE6B522FFE6CF98FFA57A31FF8E5D
      00FFB58100FFE2AA03FFE6BD48FFC8AB70FFA06A00FFB27800FFE8E1DEFFE7E0
      DFFFE5DFDEFFC8C2C1DF2625252A00000000BFB8ACFA68635C86000000000000
      00001B4B356249C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C3
      8BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF49C38BFF1B49
      3460000000000000000067655D87BEB9ACF90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005B565064EAE6E6F6F3EF
      EFFFF2EEEEFFEFECF1FFC78E08FFE1A801FFE6B731FFEEE3D2FFB28E51FF7A51
      00FFD79B00FFE3B016FFE9D096FFD7C199FFA26B00FFB47B00FFE2D3B9FFE8E2
      E1FFE7E0DFFFC9C3C2DF2726252A00000000B1A99FE679756B9D000000000000
      0000010201021B4B356225624680256246802562468025624680379369C049C3
      8BFF49C38BFF379369C0256246802562468025624680256246801C4A35610001
      010100000000000000007C776EA0ADA79CE30000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000746748A1ECE8E9FEF3EF
      EFFFF4F1F2FFD4C6ADFFD59400FFE3AD0BFFE7BF50FFF1EDF1FFD3C09DFFB582
      08FFE2AB0AFFE7BF52FFECE4DBFFDFCFB7FFA97202FFB47E00FFDBC48FFFE9E2
      E3FFE7E2DFFFCAC4C3DF2726262A000000008F8B80BB9E988DCE000000000000
      00000000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      00000000000000000000A09B8ED18F8A7FB90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007E601DAAAC976DFFEEEB
      ECFFF6F2F6FFC4A255FFDB9C00FFE4B118FFEACF8CFFF1EDF0FFF2EEF0FFEDE1
      C9FFECD9B2FFEDE6DFFFEEE8E8FFE4D7C4FFB07D14FFB58100FFD5B766FFEAE4
      E6FFE9E1E1FFCAC5C3DF2726262A000000005D5B547AC2BBADFE1515141D0000
      00000000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      0000000000001717151FC2BBADFE5C5952770000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000086641DAAB17403FFBFA6
      72FFECEAEDFFBE8C18FFE0A503FFE6B72DFFEFE0C3FFF2EDEEFFF1ECEBFFF0EB
      EDFFF0EBECFFEFE9E9FFEEE9E8FFE9DFD2FFB78729FFB47E00FFD3B256FFEBE6
      E7FFEAE3E2FFCBC5C5DF2726262A000000001A191722C1BCAEFD66635B850000
      00000000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      00000000000069645E88C1BCAEFD1717151F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C6A1CAAC89324FFD8BA
      75FFC6B183FFD0B05DFFE4B017FFEBCD80FFF2ECE9FFF1EDEDFFF2ECEDFFF0EB
      ECFFF0EBEAFFEFEBEAFFEEEAE8FFEEE8E7FFDBC7A6FFD0B170FFE7DCC7FFEBE5
      E5FFEAE5E4FFCCC7C6DF2726262A0000000000000000837F75AABBB3A8F31515
      131C0000000000000000000000000000000000000000000000002562468049C3
      8BFF49C38BFF2562468000000000000000000000000000000000000000000000
      00001716151EBBB6A5F47F7B73A7000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000896920A9E6CE99FFD7AA
      40FFDDB044FFBDAC85FFEDEAECFFF4F0F2FFF2EFEFFFF2EDEDFFF2EDEDFFF2ED
      EDFFF0EBECFFF0EBEBFFF0EBEAFFEEEAE8FFEEE9EAFFEFEAECFFEDE7E7FFECE6
      E5FFEAE4E3FFCDC8C7DF2726262A000000000000000019191721BBB6A7F5928E
      81BE0303030400000000000000000000000000000000000000001B4B356249C3
      8BFF49C38BFF1B49346000000000000000000000000000000000000000000404
      0305969186C2BBB3A8F31716151E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000604E2081CAA040FAE3C4
      7AFFEAD5A2FFE3BC5EFFCAB78BFFEBE7E5FFF4EFEFFFF3EFEFFFF2EEEEFFF2ED
      EDFFF2ECEDFFF1ECEBFFF0EBEBFFEFEBEAFFEFE9E9FFEEE9E8FFEDE8E7FFEDE7
      E6FFECE6E5FFCDC8C7DF2726262A00000000000000000000000047453F5DC5BE
      B0FF807B73A60303030400000000000000000000000000000000010201021B4B
      35621C4A3561000101010000000000000000000000000000000004040305837E
      75A9C5BEB0FF45433E5A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004E4C4A54DBCDB0F4D7B0
      52FFE6CE93FFEBD091FFDFC27CFFC7B07CFFEEEAEBFFF3EFEFFFF3EFEFFFF2ED
      EDFFF1EDEDFFF2ECEDFFF0EBECFFF0EBEAFFEFEBEAFFEEEAE8FFEEE8E8FFEDE8
      E7FFECE6E7FFCEC9C8DF2727272A000000000000000000000000000000005C59
      5277C5BEB0FF928E81BE1515131C000000000000000000000000000000000000
      000000000000000000000000000000000000000000001716151E948F83C1C5BE
      B0FF58564F730000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000054525254E9E6E8F4E8DB
      C2FFD9B664FFEBCE87FFDAAE48FFD2A033FFB69E6BFFEDEAEBFFF4EFEFFFF2EF
      EFFFF2EDEDFFF2EDEDFFF2EDEDFFF0EBECFFF0EBEBFFF0EBEAFFEEEAE8FFEEE9
      E8FFEEE8E6FFCFCAC9DF2827272A000000000000000000000000000000000000
      000047453F5DBBB6A7F5BBB3A8F366635B851515141D00000000000000000000
      00000000000000000000000000001716151E67655D87BBB6A5F4BBB6A5F44644
      3F5B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004C4A4A4CE9E5E5F3F3EF
      F0FFE2CC9EFFD0A237FFDCBD73FFD7B15FFFBB7C04FFB9A173FFEAE6E5FFF4F0
      F1FFF3EFEFFFF2EEEEFFF2ECECFFF1ECEDFFF1ECEBFFEFEAEBFFEFEBEAFFEFE9
      E9FFEDE9E8FFCDC8C7DC24232326000000000000000000000000000000000000
      00000000000019191721827E74ABC1BCAEFDC2BBADFE9E988DCE79756B9D6863
      5C8668635C8679756B9DA0988FCFC2BBADFEC1BCAEFD837E75A91717151F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000E0E0E0E535252586563
      646A62605F6A5447266F9E7A25C7A88024CDA0771ECD987327CD988359CE7A73
      668E636262696362626A6361616A6361616A6361616A6361616A6361606A6260
      606A6361616A4644444C07070707000000000000000000000000000000000000
      00000000000000000000000000001A1917225D5B547A8F8B80BBB1A99FE6BFB8
      ACFABFB8ACFAB1AA9CE58F8B80BB5D5A54791918162000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000806000A120C0114060200060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010100040101
      0105000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006E440D75E28C1DEF422908470000000000000000000000000000
      00000000000000000000000000000000000000000000000000012E291F652F2A
      2066010100050000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000060000001500000016000000160000
      000F000000060000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000060000001500000016000000160000
      000F0000000600000001000000000000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      00000000000072460E79EA911EF6452B08490000000000000000000000000000
      000000000000000000000000000000000000000000002A261C5B70654DF17064
      4DEF2A251D5B0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000120000002D090B26692A3ABFFF2A3ABEFF2A3ABEFF202C
      8DD1090B26690000002D00000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000120000002D001B0E69008A48FF008948FF008948FF0065
      36D1001B0E690000002D000000030000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      00000000000072460E79EA911EF6452B08490000000000000000000000000000
      0000000000000000000000000000000000011D1A144071654EF1786C52FF786C
      52FF75694FFB1917113800000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000010000002D1A2371B43243C7FF6477FFFF687BFFFF687BFFFF5063
      EBFF3243C7FF1A2371B40000000E000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000010000002D00512BB4009151FF00CD90FF00D194FF00D194FF00B6
      78FF009151FF00512BB40000000E0000000100000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      00000000000072460E79EA911EF6452B08490000000000000000000000000000
      00000000000000000000000000000D0B081D5C533EC7786C52FE786C52FF786C
      52FF786C52FF5E543FC80C0B081E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000061A2371B13445CAFF5F71FEFF5F72FDFF5E71FCFF5E71FCFF6073
      FEFF5F71FEFF3445CAFF00000020000000060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000600512BB1009655FF00CB8FFF00C98AFF00C685FF00C685FF00CD
      8FFF00CB8FFF009655FF000000200000000600000000FFFFFF00DEEBEF00DEEB
      EF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      00000000000072460E79EA911EF6452B08490000000000000000000000000000
      00000000000000000000000000014E4535A6776B50FC786C52FF786C52FF786C
      52FF786C52FF766A50FC4B4332A00403020A000000050000001D0000001F0000
      001F0000001F0000001F0000001F0000001F0000001F0000001F0000001F0000
      001E0000002B4658E6FF556AFAFF5167F8FF5065F7FF5065F7FF5065F7FF5066
      F7FF5167F8FF556AFAFF212C8ECD00000015000000050000001D0000001F0000
      001F0000001F0000001F0000001F0000001F0000001F0000001F0000001F0000
      001E0000002B00B371FF00C88AFF00C586FF00BE78FFFFFFFFFFFFFFFFFF00C3
      83FF00C586FF00C88AFF006736CD0000001500000000FFFFFF00DEEBEF00DEEB
      EF0000000000C6C3C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3
      C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3C60000000000DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000503
      00070805000873470E7AEA911EF6452B08490000000000000000000000000000
      000000000000000000002C281E61665B46D8665B46D8675C46DC786C52FF786C
      52FF675C47DC665B46D8665B46D82B261C5D000000100E202D6D0D1D296C0D1D
      296C0D1D296C0D1D296C0D1D296C0D1D296C0D1D296C0D1D296C0D1D296C0C1C
      266A09161D654E62F6FF4960F5FF4058F3FF3B53F2FF3B53F2FF3B53F2FF3C54
      F2FF4058F3FF4960F5FF2C3BBFFF00000016000000100E202D6D0D1D296C0D1D
      296C0D1D296C0D1D296C0D1D296C0D1D296C0D1D296C0D1D296C0D1D296C0C1C
      276A0B161F6500C585FF00C383FF00BE7BFF00B86EFFFFFFFFFFFFFFFFFF00BC
      76FF00BE7BFF00C383FF008A49FF0000001600000000FFFFFF00DEEBEF00DEEB
      EF0000000000C6C3C60000000000C6C3C60000000000C6C3C60000000000C6C3
      C60000000000C6C3C60000000000C6C3C60000000000C6C3C60000000000DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000005536
      0A5B90591298A56715AFEA911EF6452B08490000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A090619000000000000000000000000000000164398D2FF3F94D0FF3D92
      CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3E94
      CFFF419DD0FF5D71F8FF3A52F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF3A52F2FF2B3ABFFF00000016000000164398D2FF3F94D0FF3D92
      CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3D92CEFF3F92
      D1FF4794DCFF19CC94FF00BD79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF00BD79FF008948FF0000001600000000FFFFFF00DEEBEF00DEEB
      EF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000002D1B
      0430A16414ABE78F1DF5EA911EF6452B08490000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A090619000000000000000000000000000000165CB3DFFF82D3F2FF9AEF
      FFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8DEC
      FFFF92F8FFFF919DF5FF324CEDFF2E49ECFF2A46EBFF2A46EBFF2A46EBFF2B46
      EBFF2E49ECFF324DEDFF2939C0FF0000000F000000165CB3DFFF82D3F2FF9AEF
      FFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8DEB
      FFFF97F1FFFF6ADAB5FF00BB77FF00B973FF00B267FFFFFFFFFFFFFFFFFF00B7
      70FF00B973FF00BB77FF008946FF0000000F00000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000FFFF0000DEEBEF00FFFF0000DEEBEF00FFFF0000DEEB
      EF00FFFF0000DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      0000000000000D07000D613C0B682C1B052F0000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A090619000000000000000000000000000000167BD3F2FF5EB2E0FFA5EF
      FFFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF88E7
      FDFF8DF0FFFF7E87E3FF596FF0FF314CEBFF3550EBFF3650EBFF3650EBFF344F
      EBFF314CEBFF5970F0FF1E2A8EC400000006000000167BD3F2FF5EB2E0FFA5EF
      FFFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF89E6
      FFFF90EBFFFF5BC397FF28C893FF00BA77FF00B46DFFFFFFFFFFFFFFFFFF00B9
      77FF00BA77FF29C895FF006635C40000000600000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000DEEBEF0000000000000000000000000000000000FFFF
      0000DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A0906190000000000000000000000000000001696ECFEFF3F96D1FFA6F0
      FFFF83E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E4
      FDFF87E9FFFF3036C1FFA4AEF5FF4C62EDFF304AE9FF324CE9FF324CE9FF2C47
      E9FF4C63EDFFA6B2F6FF080B263E000000010000001696ECFEFF3F96D1FFA6F0
      FFFF83E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF85E3
      FEFF89E6FFFF008C44FF8AE0C1FF1CC48AFF00B36CFFFFFFFFFFFFFFFFFF00B7
      73FF1CC48BFF8DE2C5FF001B0F3E0000000100000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000FFFF000000000000C6C3C60000000000FFFF0000DEEB
      EF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016A6F5FFFF5EBBE6FF68BB
      E5FF7CE0FCFF7BDFFCFF7CDFFCFF7CDFFCFF7CDFFCFF7CDFFCFF7CDFFCFF7CDF
      FCFF7CE0FCFF83EDFFFF4B7BD8FF2E36C1FFA5AEF3FFAFB9F7FFAFB9F7FF7681
      E1FF2F39C3FF3560C8FF000000030000000000000016A6F5FFFF5EBBE6FF68BB
      E5FF7CE0FCFF7BDFFCFF7CDFFCFF7CDFFCFF7CDFFCFF7CDFFCFF7CDFFCFF7CDF
      FCFF7CDFFDFF87E5FFFF2DAD91FF008C43FF92E0C2FF9CE6CBFF9CE6CBFF57C0
      93FF008F47FF189082FF000000030000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000DEEBEF000000000000000000FFFF0000DEEBEF000000
      0000DEEBEF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016A9F3FFFF75D7F6FF419B
      D5FF8BE2FBFF77DDFBFF79DDFBFF79DDFBFF79DDFBFF79DDFBFF79DDFBFF79DD
      FBFF79DDFBFF7BE1FDFF7EE8FFFF67BAEFFF1E24B9FF1E25BAFF1E25BAFF3B62
      D0FF92C8F2FF65B7DFFF0000000A0000000000000016A9F3FFFF75D7F6FF419B
      D5FF8BE2FBFF77DDFBFF79DDFBFF79DDFBFF79DDFBFF79DDFBFF79DDFBFF79DD
      FBFF79DDFBFF7CDFFFFF82E2FFFF5CCBD5FF007E30FF007E32FF007E32FF159E
      75FF88D9DAFF69AFEAFF0000000A0000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000FFFF000000000000FFFF0000DEEBEF0000000000DEEB
      EF00DEEBEF00000000000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016AAF2FFFF81E6FFFF3E96
      D0FFA1E7FEFF71DAFAFF74DBFAFF75DBFAFF75DBFAFF75DBFAFF76DBFAFF76DB
      FAFF76DBFAFF76DCFAFF77DEFBFF79E1FCFF7CE9FFFF7CEAFFFF7CEAFFFF78E5
      FDFFA1EEFFFF8ACAEAFF000000120000000000000016AAF2FFFF81E6FFFF3E96
      D0FFA1E7FEFF71DAFAFF74DBFAFF75DBFAFF75DBFAFF75DBFAFF76DBFAFF76DB
      FAFF76DBFAFF76DBFAFF78DCFDFF7BDEFFFF81E1FFFF82E2FFFF82E2FFFF7BE0
      FFFFA3EBFFFF8BC9ECFF000000120000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000DEEBEF00FFFF0000DEEBEF0000000000DEEBEF00DEEB
      EF00DEEBEF000000000000FFFF008482840000000000DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000008350
      108C995D13A2995D13A2995D13A2995D13A2995D13A2180F021A000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016B1F1FFFF79E1FDFF67C7
      EFFFC6F4FFFFC3F2FFFFC4F2FFFFC4F2FFFFC5F2FFFFC7F2FFFF70D7FAFF70D6
      F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF6ED6
      F9FF6BD5F9FFBDF1FFFF0206082F0000000800000016B1F1FFFF79E1FDFF67C7
      EFFFC6F4FFFFC3F2FFFFC4F2FFFFC4F2FFFFC5F2FFFFC7F2FFFF70D7FAFF70D6
      F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF70D6F9FF6ED6
      F9FF6BD5F9FFBDF1FFFF0206082F0000000800000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000FFFF0000DEEBEF0000000000DEEBEF00DEEBEF00DEEB
      EF00DEEBEF000000000000FFFF00C6C3C60000000000DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF000000000000000000000000000000000000000000C176
      18CCF3961FFFEB921EF8E28C1DEEE28C1DEEE28C1DEE22150325000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016B5F1FFFF76DDFCFF7BE0
      FEFF368BCAFF358BCBFF358BCBFF358BCBFF358BCBFF378BCBFF6FD8FCFF6ED6
      FAFF6CD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD3
      F9FF67D2F9FFA1E7FDFF1532477B0000001000000016B5F1FFFF76DDFCFF7BE0
      FEFF368BCAFF358BCBFF358BCBFF358BCBFF358BCBFF378BCBFF6FD8FCFF6ED6
      FAFF6CD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD4F9FF6BD3
      F9FF67D2F9FFA1E7FDFF1532477B0000001000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF000000000000FFFF008482840000000000DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000003D25
      0742D6851BE3B97218C4342005391E1202201E12022005030005000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016B8F1FFFF73DBFAFF76DC
      FBFF79E0FDFF79E1FDFF7AE1FDFF7AE1FDFF7AE1FDFF7BE2FEFF4EA8DDFF69D5
      FBFF64D2F9FF61D0F8FF61D0F8FF61D0F8FF61D0F8FF61D0F8FF61D0F8FF61D0
      F8FF5FD0F8FF7EDBFBFF2C6B98CA0000001300000016B8F1FFFF73DBFAFF76DC
      FBFF79E0FDFF79E1FDFF7AE1FDFF7AE1FDFF7AE1FDFF7BE2FEFF4EA8DDFF69D5
      FBFF64D2F9FF61D0F8FF61D0F8FF61D0F8FF61D0F8FF61D0F8FF61D0F8FF61D0
      F8FF5FD0F8FF7EDBFBFF2C6B98CA0000001300000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF000000000000FFFF000000000000000000DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000302
      0003492E094EE08C1CEEA56715B0130B02150000000000000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016C0F3FFFF6DD8FAFF71D8
      FAFF72D8FAFF72D8FAFF72D8FAFF72D8FAFF72D8FAFF72D8FAFF75DDFDFF50AB
      DDFF378CCBFF358CCBFF358CCBFF358CCBFF358CCBFF358BCBFF348BCBFF3790
      CEFF3991CEFF3A92CFFF2D6890B40000000400000016C0F3FFFF6DD8FAFF71D8
      FAFF72D8FAFF72D8FAFF72D8FAFF72D8FAFF72D8FAFF72D8FAFF75DDFDFF50AB
      DDFF378CCBFF358CCBFF358CCBFF358CCBFF358CCBFF358BCBFF348BCBFF3790
      CEFF3991CEFF3A92CFFF2D6890B40000000400000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF0000000000000084000000FF0000000000DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      0000000000003C260742E48C1DF3804F10890705000800000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016C4F3FFFF6BD6F9FF6FD7
      F9FF70D7F9FF70D7F9FF70D7F9FF70D7F9FF70D7F9FF70D7F9FF71D9FAFF72DA
      FBFF73DCFCFF73DCFCFF73DCFCFF73DCFCFF73DCFCFF72DCFCFF6FDCFDFF3C93
      CFFF0000001600000000000000000000000000000016C4F3FFFF6BD6F9FF6FD7
      F9FF70D7F9FF70D7F9FF70D7F9FF70D7F9FF70D7F9FF70D7F9FF71D9FAFF72DA
      FBFF73DCFCFF73DCFCFF73DCFCFF73DCFCFF73DCFCFF72DCFCFF6FDCFDFF3C93
      CFFF0000001600000000000000000000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00000000000000000000000000DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
      000000000000000000006A410D71E18C1DEE4329074800000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016C9F5FFFF68D4F9FF6DD5
      F9FF6ED5F9FF6ED5F9FF6ED5F9FF6DD5F9FF6DD5F9FF6CD5F9FF6DD5F9FF6DD5
      F9FF6DD5FAFF6DD5FAFF6DD5FAFF6DD5FAFF6DD5FAFF6CD5FAFF68D5FAFF3B92
      CFFF0000001600000000000000000000000000000016C9F5FFFF68D4F9FF6DD5
      F9FF6ED5F9FF6ED5F9FF6ED5F9FF6DD5F9FF6DD5F9FF6CD5F9FF6DD5F9FF6DD5
      F9FF6DD5FAFF6DD5FAFF6DD5FAFF6DD5FAFF6DD5FAFF6CD5FAFF68D5FAFF3B92
      CFFF0000001600000000000000000000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF0000000000000000000000000000000000060200068453
      108D472D084D0401000425160428D3821BDFB36E17BD00000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000016D3F6FFFF62D1F8FF67D2
      F8FF68D3F8FF68D3F8FF68D2F8FFA8E7FDFFDAF7FFFFDAF8FFFFDAF8FFFFDAF8
      FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFD9F9FFFF3C94
      D0FF0000000D00000000000000000000000000000016D3F6FFFF62D1F8FF67D2
      F8FF68D3F8FF68D3F8FF68D2F8FFA8E7FDFFDAF7FFFFDAF8FFFFDAF8FFFFDAF8
      FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFD9F9FFFF3C94
      D0FF0000000D00000000000000000000000000000000FFFFFF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF000000000000000000000000000000000001010001CF7E
      1ADBB97217C31D13031F41270745E38C1DF0B87217C300000000000000000000
      000000000000000000000000000000000000000000000C0B081D786C52FF786C
      52FF0A09061900000000000000000000000000000015D7F8FFFF5CCFF9FF5FCF
      F8FF60CFF8FF60CFF8FF60CFF8FFBCEEFFFF338CCCFF3891CEFF3992CFFF3992
      CFFF3992CFFF3992CFFF3992CFFF3992CFFF3992CFFF3992CFFF3992CFFF2D68
      90B40000000400000000000000000000000000000015D7F8FFFF5CCFF9FF5FCF
      F8FF60CFF8FF60CFF8FF60CFF8FFBCEEFFFF338CCCFF3891CEFF3992CFFF3992
      CFFF3992CFFF3992CFFF3992CFFF3992CFFF3992CFFF3992CFFF3992CFFF2D68
      90B40000000400000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000005936
      0B5FDD881CE9DD871CE9E28A1DEED9861CE558360A5F00000000000000000000
      000000000000000000000000000000000000000000000C0B081D766A51FD766A
      51FD0A0906180000000000000000000000000000000DDBFCFFFFD7F8FFFFD8F7
      FFFFD8F7FFFFD8F7FFFFD8F7FFFFDBFCFFFF3B93D0FF0000000D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000DDBFCFFFFD7F8FFFFD8F7
      FFFFD8F7FFFFD8F7FFFFD8F7FFFFDBFCFFFF3B93D0FF0000000D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000602
      00062F1C053257360A5D54340A5A2B1A052F0403000400000000000000000000
      00000000000000000000000000000000000000000000020201071D1A133E1D1A
      133E010101060000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C66B
      6B00C6636300CE636300B55252009C6B6B00B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5737300942929009431
      31009C3939009C4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000005A0000005A
      0000005A0000005A000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300BD5A5A009C6B6B00A58C8C00B5848400CEADAD00DECE
      CE00F7F7EF00FFFFF700F7F7F700EFEFE700E7E7E700B5737300942929009431
      31009C393900C65A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF00008C
      0800008C0800008C0800005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300BD5A5A009C737300A57B7B009C393900B5736B00C69C
      9C00EFE7E700F7F7F700FFF7F700F7F7EF00EFEFEF00BD7B7B00942929009431
      31009C393900C65A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF00008C
      0800008C0800008C0800005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300BD5A5A00A5737300A5848400943131009C424200B573
      7300DEDED600EFEFEF00F7F7F700FFF7F700F7F7F700BD7B7B00942929009431
      31009C393900C65A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF00008C
      0800008C0800008C0800005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300BD5A5A00A5737300AD8C8C0094313100943131009C4A
      4A00C6C6C600E7E7DE00EFEFEF00FFF7F700FFFFFF00C67B7B00942929009431
      31009C393900C65A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF00008C
      0800008C0800008C0800005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300B5525200AD7B7B00B58C8C0094292900942929009431
      3100ADA5A500CECECE00E7E7DE00F7EFEF00FFFFFF00C6848400942929009431
      31009C393900C65A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010528400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF000094
      0800008C0800008C0800005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300B5525200AD7B7B00C6ADAD00A5636300A56363009C63
      63009C9C9C00B5B5B500D6D6D600EFEFEF00FFFFFF00C6848400942929009431
      31009C393900BD5A5A009C4A4A000000000000000000000000005294BD004A6B
      9C004A6B9C004A6B9C004A6B9C004A6B9C004A6B9C004A6B9C004A6B9C004A6B
      9C004A6B9C000042730000000000000000000000000010528400004273000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF000894
      10000094100000941000005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300BD5A5A00B5737300D6A5A500C69C9C00BD9C9C00BD94
      9400AD8C8C00AD8C8C00C69C9C00D6ADAD00E7C6C600C6737300A5424200AD42
      4200AD4A4A00C66363009C4A4A0000000000000000000000000008639C00ADCE
      E700ADCEE700ADCEE700ADCEE700CECEDE00CECEDE00CECEDE00CECEDE008CB5
      C600004273000000000000000000000000000000000000000000004273001052
      840000000000000000000000000000000000000000000000000000000000005A
      0000005A0000005A0000005A0000005A0000005A0000005A0000FFFFFF00089C
      1800089C1000089C1000005A0000005A0000005A0000005A0000005A0000005A
      0000005A00000000000000000000000000000000000000000000000000000000
      000000006B0000006B0000006B0000006B0000006B0000006B0000006B000000
      6B0000006B0000006B0000006B0000006B0000006B0000006B0000006B000000
      6B00000000000000000000000000000000000000000000000000B5847300C66B
      6B00CE636300CE636300CE636300CE636300CE636300CE636300CE636300CE63
      6300CE636300CE636300C6636300C6636300C6636300CE636300CE636300CE63
      6300CE636300CE6363009C4A4A00000000000000000000000000086BA500DEF7
      FF00DEF7FF00DEF7FF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00C6D6E7001052
      8400000000000000000000000000000000000000000000000000105284001052
      84004A6B9C000000000000000000000000000000000000000000005A0000FFFF
      FF0039D6630031CE5A0029C6520029C64A0021BD420021B5390010A5290010A5
      2100089C180008941800089C18000894100000941000008C0800008C0800008C
      0800008C0800005A000000000000000000000000000000000000000000000000
      6B007B8CDE000000E7000000E7000000E7000000DE000000D6000000CE000000
      CE000000C6000000BD000000B5000000AD000000A5000000A50000009C000000
      9C0000006B000000000000000000000000000000000000000000B5847300C66B
      6B00BD5A5A00C6636300C66B6B00CE737300CE737300CE737300CE737300CE73
      7300CE737300CE737300CE737300CE737300CE737300CE737300CE737300CE7B
      7B00CE6B6B00CE6363009C4A4A00000000000000000000000000007BAD00CEF7
      FF00CEF7FF00CEF7FF00CEF7FF00CEF7FF00DEF7FF00C6D6E700105284000000
      00000000000000000000000000000000000000000000000000004A6B9C00739C
      AD00105284000000000000000000000000000000000000000000005A0000FFFF
      FF0039D6630031CE5A0029C6520029C64A0021BD420021B5390018AD310018A5
      290010A52100109C2100089C18000894100000941000008C0800008C0800008C
      0800008C0800005A000000000000000000000000000000000000000000000000
      6B00E7E7E7000000E7000000E7000000E7000000DE000000D6000000CE000000
      CE000000C6000000BD000000B5000000AD000000A5000000A50000009C000000
      940000006B000000000000000000000000000000000000000000B5847300AD4A
      4A00A54A4200B56B6B00C68C8C00CEADAD00D6BDBD00D6BDBD00D6BDBD00D6BD
      BD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00DEC6
      C600CE8C8C00CE6363009C4A4A00000000000000000000000000007BAD00B5E7
      FF00B5E7FF00B5E7FF00CEF7FF00CEF7FF00ADCEE70010528400000000000000
      00000000000000000000000000000000000000000000000000004A6B9C00739C
      AD00297BAD000000000000000000000000000000000000000000005A0000FFFF
      FF0039D66B0031CE630031CE5A0029C6520029C64A0021BD420021B5390018AD
      310018AD290010A5290010A52100089C18000894180008941000008C0800008C
      0800008C0800005A000000000000000000000000000000000000000000000000
      6B00E7E7E7000000DE000000DE000000DE000000DE000000D6000000CE000000
      CE000000C6000000BD000000B5000000B5000000AD000000A50000009C000000
      9C0000006B000000000000000000000000000000000000000000B5847300AD42
      4200CE9C9C00F7F7EF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
      EF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00EFE7
      E700CE8C8C00C65A5A009C4A4A000000000000000000000000001884C600B5E7
      FF00B5E7FF00B5E7FF00B5E7FF00B5E7FF00A5DEFF0029637B004A6B9C000000
      000000000000000000000000000000000000000000000000000029637B008CB5
      C600297BAD000000000000000000000000000000000000000000005A0000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0021B5
      390018B5310018AD3100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00005A000000000000000000000000000000000000000000000000
      6B00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700A5B5DE00A5B5DE007B8CDE007B8CDE007B8C
      DE0000006B000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700FFF7F700EFE7
      E700CE8C8C00BD5A5A009C4A4A0000000000000000000000000010A5D600A5DE
      FF00A5DEFF00A5DEFF00A5DEFF00A5DEFF00A5DEFF00A5DEFF0029637B002963
      7B000000000000000000000000000000000000000000739CAD0010528400B5E7
      FF00298CD600000000000000000000000000000000000000000000000000005A
      0000005A0000005A0000005A0000005A0000005A0000005A0000FFFFFF0029BD
      4A0021BD420021BD4200005A0000005A0000005A0000005A0000005A0000005A
      0000005A00000000000000000000000000000000000000000000000000000000
      000000006B0000006B0000006B0000006B0000006B0000006B0000006B000000
      6B0000006B0000006B0000006B0000006B0000006B0000006B0000006B000000
      6B00000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
      EF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7F7F700EFE7
      E700CE8C8C00BD5A5A009C4A4A0000000000000000000000000010A5D6008CD6
      FF008CD6FF0084BDE70084BDE7008CD6FF008CD6FF00A5DEFF008CD6FF005294
      BD00004A7B0029637B00739CAD00739CAD00216B9400105A940084BDE7008CD6
      FF00007BAD000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF0029C6
      520029C64A0029C64A00005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00E7E7E700CEC6C600CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00C6C6C600E7DEDE00EFE7
      E700CE8C8C00BD5A5A009C4A4A0000000000000000000000000010A5D6006BC6
      FF006BC6FF001884C600007BAD0084BDE7008CD6FF008CD6FF008CD6FF008CD6
      FF008CD6FF005294BD005294BD005294BD0084BDE700A5DEFF00A5DEFF0042A5
      DE0084BDE7000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF0031CE
      5A0031CE520031CE5200005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00F7EFEF00EFE7E700EFE7E700EFE7E700EFE7E700EFE7
      E700EFE7E700EFE7E700EFE7E700EFE7E700EFE7E700EFE7E700F7EFEF00EFE7
      E700CE8C8C00BD5A5A009C4A4A0000000000000000000000000010A5D6004ABD
      FF0010A5D60000000000000000001884C60042A5DE006BC6FF006BC6FF008CD6
      FF008CD6FF008CD6FF008CD6FF008CD6FF008CD6FF008CD6FF0042A5DE0042A5
      DE00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF0039D6
      630031D6630031D66300005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00EFE7E700D6CECE00D6CECE00D6CECE00D6CECE00D6CE
      CE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00CECECE00E7E7E700EFE7
      E700CE8C8C00BD5A5A009C4A4A0000000000000000000000000010A5D60010A5
      D6000000000000000000000000000000000042A5DE001884C60042A5DE004ABD
      FF006BC6FF006BC6FF006BC6FF004ABDFF0042A5DE0010A5D60042A5DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF0039DE
      6B0039DE6B0042E77300005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00EFEFE700E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00EFEFEF00EFE7
      E700CE8C8C00BD5A5A009C4A4A0000000000000000000000000010A5D6000000
      000000000000000000000000000000000000000000000000000042A5DE0042A5
      DE0010A5D60010A5D60010A5D60042A5DE0042A5DE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF0042DE
      730042DE730042E77300005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00EFEFE700E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00EFEFEF00EFE7
      E700CE8C8C00BD5A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000005A0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00005A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00E7E7E700CECECE00D6CECE00D6CECE00D6CECE00D6CE
      CE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00CECECE00E7E7E700EFE7
      E700CE8C8C00BD5A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000005A0000005A
      0000005A0000005A000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300AD42
      4200CEA5A500FFFFFF00FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700EFE7
      E700CE8C8C00C65A5A009C4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD42
      4200CE9C9C00C6CECE00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C68C8C00B552520000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000480000000100010000000000600300000000000000000000
      000000000000000000000000FFFFFF00800001FE007F000000000000000000F8
      001F000000000000800003F07E0F000000000000800007E1FF87000000000000
      800007C3C3C300000000000080000387C3E10000000000008000018FC3F10000
      000000008000011FC3F80000000000008000011FC3F80000000000008000013F
      C3FC00000000000080000130000C00000000000080000130000C000000000000
      80000130000C00000000000080000130000C0000000000008000013FC3FC0000
      000000008000011FC3F80000000000008000011FC3F80000000000008000018F
      C3F100000000000080000187C3E1000000000000800001C3C3C3000000000000
      800001E1FF87000000000000800001F07E0F000000000000800001F8001F0000
      00000000800001FE007F000000000000FFFFFFF8FFCFFFFFFFFFFFFFFFFFFFF8
      FF87FFFC03FFFC03800003F8FF87FFF801FFF801800003F8FE01FFF000FFF000
      800003F8FE01FFF000FFF000800003F8FC00000000000000800003E0FC000000
      00000000800003E0FF87000000000000800003E0FF87000000000000800003F8
      FF87000000000000800003FFFF87000000000000800003FFFF87000001000001
      800003FFFF87000001000001800003FFFF87000001000001800003E03F870000
      00000000800003E03F87000000000000800003E03F87000000000000800003E0
      FF87000000000000800003F87F87000007000007800003FC7F87000007000007
      800003C07F87000007000007800003C07F87000007000007800003E07F87003F
      FF003FFFFFFFFFE07F87FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE00003FFFFFFFFC3FFFFFFFFC00001FFFFFFFF81FFFFFFFFC00001FFFFFF
      FF81FFFFFFFFC00001FFFFFFFF81FFFFFFFFC00001FFFFFFFF81FFFFFFFFC000
      01FFFFBFFF81FFFFFFFFC00001C0039FFF81FFFFFFFFC00001C007CFE00007F0
      000FC00001C00FC7C00003E00007C00001C01FC7C00003E00007C00001C03FC7
      C00003E00007C00001C01FC7C00003E00007C00001C00F87E00007F0000FC000
      01C00007FF81FFFFFFFFC00001C00007FF81FFFFFFFFC00001C6000FFF81FFFF
      FFFFC00001CF001FFF81FFFFFFFFC00001DFC07FFF81FFFFFFFFC00001FFFFFF
      FF81FFFFFFFFC00001FFFFFFFFC3FFFFFFFFC00001FFFFFFFFFFFFFFFFFFE000
      03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object Timer1: TTimer
    Interval = 500
    Left = 280
    Top = 56
  end
  object alCatCopyPaste: TActionList
    Images = ilCutCopyPaste
    Left = 136
    Top = 56
    object actCut: TAction
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      Hint = #1042#1099#1088#1077#1079#1072#1090#1100' '#1082#1088#1080#1090#1077#1088#1080#1081' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 3
    end
    object actCopy: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1087#1083#1072#1085' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 2
      OnExecute = actCopyExecute
    end
    object actPaste: TAction
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1077#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1087#1083#1072#1085' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 1
      OnExecute = actPasteExecute
    end
  end
  object ilCutCopyPaste: TImageList
    Height = 24
    Width = 24
    Left = 360
    Top = 56
    Bitmap = {
      494C0101040009002C0118001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000003000000001002000000000000048
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D3D1E1007F76A3008980A7008B82A7008C84A7008D86A7008E88
      A7008F8AA7008682A300D5D5E000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CBC9DC0000006600528EFF002E6EFF00245AFF001845FF000D31FF00031E
      FF00000AFF00141DFF0000006800D5D5E0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006E649A0062ABFF007EB2FB00A5BDF7009DB4F700B6C6FB00B2BFFC00909D
      F700949CF7004A57FB00111AFF008683A4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000786DA50058B8FF00AECCF70000000000000000000005CE000000CB000000
      000000000000949DF700000AFF008F8BA8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C7B39D00C2B19B00C2B19C00C1B0
      9C00C0AF9C00BFAF9D00BFAE9C00BEAE9C00BEAD9C00BDAD9D00BCAC9C00C6B5
      A0006248670062CAFF00ACCFF7000000000000000000043EE5000023E3000000
      000000000000909DF700031EFF008E89A8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0099A8AC000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B56E3F00E37C4C00DC713E00D96F
      3B00D76C3800D56B3600D2693500D0683200CE663000CB652F00C7632E00CC66
      2B008833290066D7FF00CAE7FB00004BD700166BEA002E7CF7002561F3000022
      E2000000CB00B3C0FC000D31FF008D87A8000000000000000000000000000000
      000000000000000000000000000099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099A8AC00000000000000000099A8
      AC00000000000000000099A8AC0099A8AC000000000000000000000000000000
      000000000000000000000000000000000000BD794D00BF734400C2B4A100C1AD
      9700C0AC9700BEAB9600BEA99600BDA99500BCA89500BBA79400BBA69400C0AA
      96007D60740071E4FF00CBE9FA00065AD8001E81ED003894F9002E7AF6000339
      E5000000CD00B6C6FC001945FF008C85A8000000000000000000000000000000
      0000000000000000000099A8AC0099A8AC000000000099A8AC00840000008400
      00008400000084000000840000008400000084000000840000008400000099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      000084000000840000008400000084000000840000008400000099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008400000084000000000000000000000099A8
      AC000000000099A8AC00000000000000000099A8AC0000000000000000000000
      000000000000000000000000000000000000BF7D5000B46B3A0000000000FFFE
      FF00FFFEFF00FFFDFE00FFFCFD00FFFBFD00FFFBFC00FFFAFB00FFFAFA00FFFF
      FE00B09DBE0072E5FE00B7E0F70000000000000000001D7FEC001468E9000000
      0000000000009DB4F700245BFF008B83A8000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      00000000000099A8AC0099A8AC0099A8AC0099A8AC0084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000840000000000000099A8AC00840000000000000099A8
      AC008400000084000000000000000000000099A8AC0000000000000000000000
      000000000000000000000000000000000000C17F5400B76D3D0000000000FEFA
      FA000000000000000000FDF7F800F9F4F200FCF6F500FFFEFF00FFFDFF00FFFD
      F800A996B60074E5FF00BBE1F70000000000000000000457D8000047D6000000
      000000000000A5BEF7002E6EFF008981A8000000000000000000000000000000
      0000000000008484840099A8AC0084848400000000008484840084000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF008400000099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      00000000000099A8AC0099A8AC0099A8AC0099A8AC0084000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF008400000099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      000000000000000000008400000000000000000000008400000099A8AC008400
      00000000000099A8AC00840000000000000099A8AC0000000000000000000000
      000000000000000000000000000000000000C3825700B971410000000000F0E5
      DE00B3906900B08E6900F2EAE600FFFCFD00ECE1DA00A7876900A4856900F7ED
      E600C1B0C90078D3F900A0E9FB00BCE1F700B6E0F700CBE9FA00CAE6FB00ACD0
      F700AECCF7007DB1FB00508DFF007F77A4000000000000000000000000000000
      000000000000000000008484840000000000848484000000000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000084000000000000008400
      00000000000099A8AC008400000099A8AC000000000000000000000000000000
      000000000000000000000000000000000000C4855A00BC74450000000000B793
      6A0099462500934625007938010000000000AB8A6C007D2E0A007A310D006329
      000000000000696AA80079D2F70073E4FF0073E5FE0071E5FF0066D7FF0062C9
      FF0057B8FF0064ACFF0000006600D3D1E1000000000000000000000000000000
      0000000000008484840099A8AC0084848400000000008484840084000000FFFF
      FF00000000000000000000000000FFFFFF0084000000840000008400000099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF008400000099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000008400
      000099A8AC0099A8AC0084000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6885E00BD77480000000000BB9A
      7200BC674300B86845009C4E2800BEA28400BAA187009E4C27009C502C008137
      1200AC8F770000000000BFADC500A894B600B09CBE007C5E72008A342A006247
      6700786DA4006E639900CBC9DC00000000000000000000000000000000000000
      000000000000000000008484840000000000848484000000000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF008400000099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000099A8AC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C78B6100BF7A4C0000000000BC9B
      7100C8725000C4704C00BE6C4B008A3F0C00A7896400B15F3B00AA5A3500A253
      2F00661D0000F4EFEC00FFFBF700FFF9F300FFFFFD00C0A99400CF682D00C5B5
      A000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840099A8AC0084848400000000008484840084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000000000000000000099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF000000
      000000000000FFFFFF0084000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000000000008400
      000099A8AC0099A8AC0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C98E6400C17E4F0000000000BC9A
      6F00D5846600E4AB9700DD9F8800C47152006C2F0000C06F4F00C47C5D00D9A2
      8E00AB5A38007C4A230000000000F9F1EF00FFF9F900BAA59300CC653000BBAB
      9B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000008484840099A8AC00840000008400
      000084000000840000008400000084000000840000000000000099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000099A8
      AC000000000099A8AC0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CA916800C280530000000000BD99
      6D00E39D8500A5612A00BE8C6300E19E8600CC7B5C00C8785500D38364006631
      0000DFA38C0096441C00B59E8A00FFFEFF00FFF9FA00BAA59400CF673100BCAC
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000008484840099A8AC008484840099A8AC008484840099A8AC008484
      840099A8AC008484840099A8AC008484840099A8AC00000000000000000099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099A8AC0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC946B00C484570000000000BE9A
      6D00E6A89300AA652F00C3A98600D6A58800E1A08800D6896700D27F6000A586
      6200A26E4800DB8E72007F3E1300F9F5F400FFFCFD00BCA69400D2683400BDAD
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      000000000000000000000000000099A8AC00848484000000000099A8AC0099A8
      AC00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099A8AC000000
      00000000000099A8AC0099A8AC00000000000000000000000000000000000000
      000000000000000000000000000000000000CD976F00C5875C0000000000BD97
      6700E7AC9A00A25C200000000000B38A5E00ECC3B300DF9E8400D78E7000B698
      7900CBB8A600BD836200C97554008D65420000000000BCA79400D46B3600BEAD
      9C00000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840000000000C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00000000008484840099A8AC000000000099A8AC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099A8AC000000
      0000000000000000000099A8AC00000000000000000000000000000000000000
      000000000000000000000000000000000000CE9A7300C98F6600F6F3EC00BA7A
      4700EAB8A800DDA59100A05E2200F5F0EA009B5F2300F9D9CF00E8A99500AD8B
      660000000000935E3300EDA58D00A65A3300AE947D00C5B5A300D86D3900BEAE
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000FFFF00000000000000
      000000FFFF000000000084848400000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099A8AC000000
      0000000000000000000099A8AC00000000000000000000000000000000000000
      000000000000000000000000000000000000CF9E7800CD987100D1B58F00BA7D
      4400BC8C5700BB8B5800B4723A00C8A88400FBF8F800A36F3800AA744400C2A4
      84000000000087491300A67D5900A5724B0079360600CABCAB00DA6F3B00BFAF
      9B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099A8AC000000
      0000000000000000000099A8AC00000000000000000000000000000000000000
      000000000000000000000000000000000000D1A17C00C9926900000000000000
      000000000000000000000000000000000000FFFDFD0000000000000000000000
      0000FCF7F60000000000000000000000000000000000BFA99400DC723E00C0AF
      9B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D1A47F00CB966E0000000000FEFC
      FD00FEFDFB00FEFBFC00FDFBFA00FCFBFA00FDF9FA00FDFAF900FCF9F700FBF7
      F700FCF7F600FBF7F600FAF5F500FBF4F300FFFDFE00BFAB9500DE744300C0AF
      9B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D2A78200C9966B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C1B29E00E1794800C1AF
      9A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3A88400F7D4CA00C8976B00CB98
      6F00CA946A00C9916600C78E6200C68A5E00C5875B00C4845700C1805300C07E
      5000BF7B4E00BD784A00BB754700B9714300B76F4000C2784C00E9865B00C1AF
      9B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE8E5B00D2A88400D2A78300D2A5
      8000D1A27D00D09F7900CF9C7600CE9A7200CD966F00CA946C00CA906800C98E
      6500C88B6200C6895F00C4865C00C3845A00C1805700BF7E5300B7724500C7B3
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000300000000100010000000000400200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFF801FFFFFFFFFFFFFFFFFFFFF000FF
      FFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF198FFFFFFFFFFFFFFFFFF
      000198FFF007FFE00FFF9FFF000000FE0007FFE00FFF6CFF000000FC8007FF80
      0FFE6B7F200198F80007F8000FFD237F2C0198F08007F8000FFD897F200000F5
      4007E0000FFDA8FF210800F0800FE0000FFE21FF200401F5400FE0001FFFA3FF
      20000FF0802FE0003FFF83FF20020FF5000FE0007FFFCBFF20000FF0002FE000
      FFFF8BFF20000FF4000FE001FFFF89FF22008FF0001FE01FFFFF8DFF00080FF1
      013FE03FFFFF05FF00080FF8007FE07FFFFF55FF3F778FFF87FFFFFFFFFF77FF
      20000FFFFFFFFFFFFFFF77FF3FFF8FFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFF
      FFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    Grid = cxGrid
    PopupMenus = <
      item
        GridView = gdbbtvThemeUnions
        HitTypes = [gvhtNone, gvhtCell]
        Index = 0
        PopupMenu = pmThemeUnions
      end
      item
        GridView = gdbbtvLessonThemes
        HitTypes = [gvhtNone, gvhtCell]
        Index = 1
        PopupMenu = pmLessonThemes
      end>
    Left = 56
    Top = 216
  end
  object pmLessonThemes: TPopupMenu
    Images = ilCutCopyPaste
    Left = 56
    Top = 288
    object N1: TMenuItem
      Action = actCopyText
    end
    object N2: TMenuItem
      Action = actPasteLessonThemes
    end
  end
  object actCopyPasteText: TActionList
    Images = ilCutCopyPaste
    Left = 56
    Top = 144
    object actCopyText: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 2
      OnExecute = actCopyTextExecute
    end
    object actPasteLessonThemes: TAction
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnExecute = actPasteLessonThemesExecute
    end
    object actPasteThemeUnions: TAction
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnExecute = actPasteThemeUnionsExecute
    end
  end
  object pmThemeUnions: TPopupMenu
    Images = ilCutCopyPaste
    Left = 56
    Top = 344
    object N3: TMenuItem
      Action = actCopyText
    end
    object N4: TMenuItem
      Action = actPasteThemeUnions
    end
  end
end
