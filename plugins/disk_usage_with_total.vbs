' https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-logicaldisk
On Error Resume Next


' Get drive information
Set objWMIService = GetObject ("winmgmts:\\.\root\cimv2")
'Set colItems = objWMIService.ExecQuery ("Select * from Win32_LogicalDisk") ' Todos los discos
'Set colItems = objWMIService.ExecQuery ("Select * from Win32_LogicalDisk where (DriveType = 3 OR DriveType = 2)") ' Fijos y Removibles
Set colItems = objWMIService.ExecQuery ("Select * from Win32_LogicalDisk where (DriveType = 3)") ' Solo locales

' Drive Types
'  Unknown (0)
'  No Root Directory (1)
'  Removable Disk (2)
'  Local Disk (3)
'  Network Drive (4)
'  Compact Disc (5)
'  RAM Disk (6)

' En pandora se configura asi en pandora.conf
'####### Monitorizacion basica
'# Trafico de interfaces de red
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\interfaces.vbs" //nologo
'# Memoria Fisica
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\physical_memory.vbs" //nologo
'# Virtual Fisica
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\virtual_memory.vbs" //nologo
'# Logical Disk
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\disk_perfomance_logical_disk.vbs" //nologo
'# Physical Disk
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\disk_perfomance_physical_disk.vbs" //nologo
'# Disk usage with total
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\disk_usage_with_total.vbs" //nologo
'# CPU Usage
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\cpu_usage.vbs" //nologo
'# System Uptime and Local Date and Time
'module_plugin cscript.exe //B "%PROGRAMFILES%\Pandora_Agent\util\system_uptime.vbs" //nologo


For Each objItem in colItems
	'If argc = 0 Or argv.Exists(objItem.Name) Then
		' Include only harddrivers (type 3)
		If (objItem.FreeSpace <> "") Then
            'Percent = round (100 - (objItem.FreeSpace / objItem.Size) * 100, 1)
			Percent = round ( (objItem.FreeSpace / objItem.Size) * 100, 1)
			' 1073741824 = 1024 * 1024 * 1024
			Total   = round ((objItem.Size / 1073741824), 1)
			call outputModuleGenericData("Free Disk " & objItem.Name & " % - " & Total & " Gb" , "Free Space on Drive " & objItem.Name & " %", Percent)
	    End If
	'End If
Next

Sub outputModuleGenericData(module_name,module_description,cdata)
	Wscript.StdOut.Write "<module>"                                                                   & vbCrLf
	Wscript.StdOut.Write vbTab & "<name><![CDATA["        & module_name        & "]]></name>"         & vbCrLf
	Wscript.StdOut.Write vbTab & "<type><![CDATA[generic_data]]></type>"                              & vbCrLf
	Wscript.StdOut.Write vbTab & "<description><![CDATA[" & module_description & "]]></description>"  & vbCrLf
	'Wscript.StdOut.Write vbTab & "<module_interval><![CDATA[1]]></module_interval>"                   & vbCrLf
	Wscript.StdOut.Write vbTab & "<min_critical><![CDATA[0]]></min_critical>"                         & vbCrLf
	Wscript.StdOut.Write vbTab & "<max_critical><![CDATA[30]]></max_critical>"                         & vbCrLf
	Wscript.StdOut.Write vbTab & "<min_warning><![CDATA[30]]></min_warning>"                           & vbCrLf
	Wscript.StdOut.Write vbTab & "<max_warning><![CDATA[40]]></max_warning>"                           & vbCrLf
	Wscript.StdOut.Write vbTab & "<data><![CDATA["        & cdata              & "]]></data>"         & vbCrLf
	Wscript.StdOut.WriteLine "</module>"
End Sub