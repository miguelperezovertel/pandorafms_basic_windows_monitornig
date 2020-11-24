' https://www.activexperts.com/admin/vbscript-collection/storage/diskdrives/monitoring/
' http://www.cruto.com/resources/vbscript/vbscript-examples/storage/disks/monitor/Monitor-Physical-Disk-Performance.asp
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
set objRefresher = CreateObject("WbemScripting.SWbemRefresher")
Set colItems = objRefresher.AddEnum _
    (objWMIService, "Win32_PerfFormattedData_PerfDisk_PhysicalDisk").objectSet
objRefresher.Refresh


For Each objItem in colItems
	'Wscript.Echo "Average Disk Bytes Per Read: "       &  objItem.AvgDiskBytesPerRead
	'Wscript.Echo "Average Disk Bytes Per Transfer: "   &  objItem.AvgDiskBytesPerTransfer
	'Wscript.Echo "Average Disk Bytes Per Write: "      &  objItem.AvgDiskBytesPerWrite
	'Wscript.Echo "Average Disk Queue Length: "         &  objItem.AvgDiskQueueLength
	call outputModuleGenericData("Physical Disk - " & objItem.Name & " - Avg Disk Queue Length", "", objItem.AvgDiskQueueLength)
	'Wscript.Echo "Average Disk Read Queue Length: "    &  objItem.AvgDiskReadQueueLength
	call outputModuleGenericData("Physical Disk - " & objItem.Name & " - Avg Disk Read Queue Length", "", objItem.AvgDiskReadQueueLength)
	'Wscript.Echo "Average Disk Seconds Per Read: "     &  objItem.AvgDisksecPerRead
	'Wscript.Echo "Average Disk Seconds Per Transfer: " &  objItem.AvgDisksecPerTransfer
	'Wscript.Echo "Average Disk Seconds Per Write: "    &  objItem.AvgDisksecPerWrite
	'Wscript.Echo "Average Disk Write Queue Length: "   &  objItem.AvgDiskWriteQueueLength
	call outputModuleGenericData("Physical Disk - " & objItem.Name & " - Avg Disk Write Queue Length", "", objItem.AvgDiskWriteQueueLength)
	'Wscript.Echo "Caption: "                           &  objItem.Caption
	'Wscript.Echo "Current Disk Queue Length: "         &  objItem.CurrentDiskQueueLength
	'Wscript.Echo "Description: "                       &  objItem.Description
	'Wscript.Echo "Disk Bytes Per Second: "             &  objItem.DiskBytesPersec
	'Wscript.Echo "Disk Read Bytes Per Second: "        &  objItem.DiskReadBytesPersec
	call outputModuleGenericData("Physical Disk - " & objItem.Name & " - Disk Read Bytes Per sec", "", objItem.DiskReadBytesPersec)
	'Wscript.Echo "Disk Reads Per Second: "             &  objItem.DiskReadsPersec
	'Wscript.Echo "Disk Transfers Per Second: "         &  objItem.DiskTransfersPersec
	'Wscript.Echo "Disk Write Bytes Per Second: "       &  objItem.DiskWriteBytesPersec
	call outputModuleGenericData("Physical Disk - " & objItem.Name & " - Disk Write Bytes Per sec", "", objItem.DiskWriteBytesPersec)
	'Wscript.Echo "Disk Writes Per Second: "            &  objItem.DiskWritesPersec
	'Wscript.Echo "Name: "                              &  objItem.Name
	'Wscript.Echo "Percent Disk Read Time: "            &  objItem.PercentDiskReadTime
	'Wscript.Echo "Percent Disk Time: "                 &  objItem.PercentDiskTime
	'Wscript.Echo "Percent Disk Write Time: "           &  objItem.PercentDiskWriteTime
	'Wscript.Echo "Percent Idle Time: "                 &  objItem.PercentIdleTime
	'Wscript.Echo "Split I/O Per Second: "              &  objItem.SplitIOPerSec
	call outputModuleGenericData("Physical Disk - " & objItem.Name & " - Split I/O Per Second", "", objItem.SplitIOPerSec)
	'Wscript.Sleep 2000
	'objRefresher.Refresh
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