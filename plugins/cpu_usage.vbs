' https://social.technet.microsoft.com/Forums/ie/en-US/39fa1281-c6f9-4b9f-a8bc-d627ea78979e/vbscript-to-monitor-total-cpu-usage-in-percentage?forum=ITCG
' https://wutils.com/wmi/root/cimv2/win32_perfformatteddata_perfos_processor/

On Error Resume Next
strComputer = "."

Set objWMIService = GetObject("winmgmts:\\localhost\root\CIMV2") 
Set CPUInfo = objWMIService.ExecQuery("SELECT * FROM Win32_PerfFormattedData_PerfOS_Processor",,48) 

For Each Item in CPUInfo 
    'Wscript.Echo "PercentProcessorTime: " & Item.PercentProcessorTime
	'Wscript.Echo Item.Name
	call outputModuleGenericData("Processor - " & Item.Name & " Percent Processor Time", "", Item.PercentProcessorTime)
	'Wscript.Echo "InterruptsPersec: " & Item.InterruptsPersec
	call outputModuleGenericData("Processor - " & Item.Name & " Interrupts Per sec", "", Item.InterruptsPersec)
	'Wscript.Echo "PercentInterruptTime: " & Item.PercentInterruptTime
	call outputModuleGenericData("Processor - " & Item.Name & " Percent Interrupt Time", "", Item.PercentInterruptTime)
	'Wscript.Echo "PercentPrivilegedTime: " & Item.PercentPrivilegedTime
	call outputModuleGenericData("Processor - " & Item.Name & " Percent Privileged Time", "", Item.PercentPrivilegedTime)
	'Wscript.Echo "PercentProcessorTime: " & Item.PercentProcessorTime
	call outputModuleGenericData("Processor - " & Item.Name & " Percent Processor Time", "", Item.PercentProcessorTime)
	'Wscript.Echo "PercentUserTime: " & Item.PercentUserTime
	call outputModuleGenericData("Processor - " & Item.Name & " Percent User Time", "", Item.PercentUserTime)
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


' call outputModuleGenericData("Processor - " & objItem.Name & " - Split I/O Per Second", "", objItem.SplitIOPerSec)