On Error Resume Next

' Virtual Memory
strComputer = "."

Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colSettings = objWMIService.ExecQuery _
("Select * from Win32_OperatingSystem")

For Each objOperatingSystem in colSettings 
  ' TotalVirtualMemorySize
  call outputModuleGenericData("Virtual Memory - Total Size", "", objOperatingSystem.TotalVirtualMemorySize)
  ' FreeVirtualMemory
  call outputModuleGenericData("Virtual Memory - Free", "", objOperatingSystem.FreeVirtualMemory)
  ' UsedVirtualMemory
  call outputModuleGenericData("Virtual Memory - Used", "", (objOperatingSystem.TotalVirtualMemorySize-objOperatingSystem.FreeVirtualMemory))
  ' Free Percent
  freepercent = Round(( 100 * objOperatingSystem.FreeVirtualMemory)/objOperatingSystem.TotalVirtualMemorySize)
  call outputModuleGenericData("Virtual Memory - Free %", "", freepercent)
  ' Used Percent
  call outputModuleGenericData("Virtual Memory - Used %", "", Round(100-freepercent))
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

