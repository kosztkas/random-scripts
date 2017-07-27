Attribute VB_Name = "Module1"
Sub CheckBox12_Click()
Attribute CheckBox12_Click.VB_ProcData.VB_Invoke_Func = " \n14"
'
' CheckBox12_Click -> Show Hosting tab
'
    Sheets("Hosting").Visible = Sheets("Calcs").Range("A10").Value
End Sub
