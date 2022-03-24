report 50100 "DYK Fix G/L Entries Dim. Sets"
{
    Caption = 'Fix G/L Entries Dimension Sets';
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                label(NoteLabel)
                {
                    ApplicationArea = Dimensions;
                    MultiLine = true;
                    ShowCaption = false;
                    CaptionClass = NoteLbl;
                }
            }
        }
    }


    var
        CompletedTxt: Label 'The task was successfully completed.';
        NoteLbl: Label 'Fix inconsistent global dimensions on G/L Entries. Depending on the number of records, this might take some time. Choose OK to fix now, or Schedule to run the report later, for example, during non-working hours.';


    trigger OnPreReport()
    begin
        Codeunit.Run(Codeunit::"DYK Fix G/L Entries Dim. Sets");
        Message(CompletedTxt);
    end;

}