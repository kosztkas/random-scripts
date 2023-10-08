Function decode(CellRef As Range)
    Dim AscArray() As String
    Dim Element As Variant
    Dim Result As String

    AscArray() = Split(CellRef, "-")
    
    For Each Element In AscArray
        Result = Result + Chr(Element)
    Next
    
    decode = Result
    
End Function
