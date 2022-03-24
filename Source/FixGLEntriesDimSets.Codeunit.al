codeunit 50100 "DYK Fix G/L Entries Dim. Sets"
{
    Permissions = tabledata "G/L Entry" = m;

    var
        ProgressWindow: Dialog;
        ProgressWindowMsg: Label 'Processing entry #1#######', Comment = '#1 = Entry No., %1 = Total Entries Count';

    trigger OnRun()
    begin
        FixGLEntriesDimSets();
    end;

    local procedure FixGLEntriesDimSets()
    var
        ConfirmMgt: Codeunit "Confirm Management";
        YouAreGoingToRecreateDimensionSetsForTheGLEntriesDoYouWantToContinueQst: Label 'You are going to recreate Dimension Sets for the G/L Entries, based on 2 global dimensions. Do you want to continue?';
        GLEntry: Record "G/L Entry";
    begin
        if not ConfirmMgt.GetResponse(YouAreGoingToRecreateDimensionSetsForTheGLEntriesDoYouWantToContinueQst, false) then
            exit;

        ProgressWindow.Open(ProgressWindowMsg);
        if GLEntry.FindSet() then
            repeat
                ProgressWindow.Update(1, GLEntry."Entry No.");
                RecreateGLEntryDimSetFrom2GlobalDimensions(GLEntry);
            until GLEntry.Next() = 0;
        ProgressWindow.Close();
    end;

    local procedure RecreateGLEntryDimSetFrom2GlobalDimensions(GLEntry: Record "G/L Entry")
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateShortcutDimValues(1, GLEntry."Global Dimension 1 Code", GLEntry."Dimension Set ID");
        DimMgt.ValidateShortcutDimValues(2, GLEntry."Global Dimension 2 Code", GLEntry."Dimension Set ID");
        GLEntry.Modify();
    end;
}