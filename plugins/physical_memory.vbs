' https://www.vbsedit.com/scripts/misc/wmi/scr_1343.asp
On Error Resume Next

' Available physical Memory
strComputer = "."
data_0 = 0
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colSettings = objWMIService.ExecQuery _
("Select * from Win32_OperatingSystem")

For Each objOperatingSystem in colSettings 
  'Wscript.Echo objOperatingSystem.FreePhysicalMemory
  call outputModuleGenericData("Physical Memory - Free", "", objOperatingSystem.FreePhysicalMemory)
  data_0 = (data_0 + objOperatingSystem.FreePhysicalMemory)*1024
Next

'Wscript.Echo data_0

Dim WMI
Set WMI = GetObject("winmgmts:root/cimv2")

Dim Collection, Item
Set Collection = WMI.InstancesOf("Win32_ComputerSystem")
For Each Item In Collection
  'WScript.Echo Item.TotalPhysicalMemory
  call outputModuleGenericData("Physical Memory - Total", "", Item.TotalPhysicalMemory)
  'WScript.Echo Item.TotalPhysicalMemory - data_0
  call outputModuleGenericData("Physical Memory - Used", "", data_0)
  ' Free Percent
  freepercent = Round(( 100 * data_0)/Item.TotalPhysicalMemory)
  'freepercent = ( 100 * (data_0*1024))/Item.TotalPhysicalMemory
  'Wscript.Echo freepercent
  'Wscript.Echo data_0
  'Wscript.Echo Item.TotalPhysicalMemory
  call outputModuleGenericData("Physical Memory - Free %", "", freepercent)
  ' Used Percent
  call outputModuleGenericData("Physical Memory - Used %", "", Round(100-freepercent))
  Exit For
Next


Sub outputModuleGenericData(module_name,module_description,cdata)
Wscript.StdOut.Write "<module>"                                                                   & vbCrLf
Wscript.StdOut.Write vbTab & "<name><![CDATA["        & module_name        & "]]></name>"         & vbCrLf
Wscript.StdOut.Write vbTab & "<type><![CDATA[generic_data]]></type>"                              & vbCrLf
Wscript.StdOut.Write vbTab & "<description><![CDATA[" & module_description & "]]></description>"  & vbCrLf
Wscript.StdOut.Write vbTab & "<module_interval><![CDATA[1]]></module_interval>"                   & vbCrLf
Wscript.StdOut.Write vbTab & "<min_critical><![CDATA[0]]></min_critical>"                         & vbCrLf
Wscript.StdOut.Write vbTab & "<max_critical><![CDATA[0]]></max_critical>"                         & vbCrLf
Wscript.StdOut.Write vbTab & "<min_warning><![CDATA[0]]></min_warning>"                           & vbCrLf
Wscript.StdOut.Write vbTab & "<max_warning><![CDATA[0]]></max_warning>"                           & vbCrLf
Wscript.StdOut.Write vbTab & "<data><![CDATA["        & cdata              & "]]></data>"         & vbCrLf
Wscript.StdOut.WriteLine "</module>"
'Wscript.StdOut.flush
End Sub

