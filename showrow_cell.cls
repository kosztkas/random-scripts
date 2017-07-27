VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Compare Text
Private Sub Worksheet_Change(ByVal Target As Range)
  If Target.Address = "$B$3" Then
        Rows("6").EntireRow.Hidden = Not (Target.Value = "Virtual machine")
  End If
  If Target.Address = "$B$13" Then
        Rows("24:27").EntireRow.Hidden = Not (Target.Value = "yes")
  End If
  If Target.Address = "$B$14" Then
        Rows("29:30").EntireRow.Hidden = Not (Target.Value = "yes")
  End If
End Sub
