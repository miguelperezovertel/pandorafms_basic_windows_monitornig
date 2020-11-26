
On Error Resume Next

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
set objRefresher = CreateObject("WbemScripting.SWbemRefresher")
Set colItems = objRefresher.AddEnum _
    (objWMIService, "Win32_PerfFormattedData_TCPIP_NetworkInterface").objectSet
objRefresher.Refresh


For Each objItem in colItems
    ' Nombre y descripcion
    'Wscript.Echo "Name: "                                    & objItem.Name
    'Wscript.Echo "Description: "                             & objItem.Description
	'Wscript.Echo "Caption: "                                 & objItem.Caption
		
	'Wscript.Echo "Bytes Received Per Second: "               & objItem.BytesReceivedPersec
	call outputModuleGenericData("Network Interface - " & objItem.Name & " Bytes Received Per sec", "", objItem.BytesReceivedPersec)
    
	'Wscript.Echo "Bytes Sent Per Second: "                   & objItem.BytesSentPersec
	call outputModuleGenericData("Network Interface - " & objItem.Name & " Bytes Sent Per sec",     "", objItem.BytesSentPersec)
    
	'Wscript.Echo "Bytes Total Per Second: "                  & objItem.BytesTotalPersec
    
    'Wscript.Echo "Current Bandwidth: "                       & objItem.CurrentBandwidth
	call outputModuleGenericData("Network Interface - " & objItem.Name & " Current Bandwidth",     "", objItem.CurrentBandwidth)
    'Wscript.Echo "Output Queue Length: "                     & objItem.OutputQueueLength
	call outputModuleGenericData("Network Interface - " & objItem.Name & " Output Queue Length",     "", objItem.OutputQueueLength)
    'Wscript.Echo "Packets Outbound Discarded: "              & objItem.PacketsOutboundDiscarded
    'Wscript.Echo "Packets Outbound Errors: "                 & objItem.PacketsOutboundErrors
	call outputModuleGenericData("Network Interface - " & objItem.Name & " Packets Outbound Errors",     "", objItem.PacketsOutboundErrors)
    'Wscript.Echo "Packets Per Second: "                      & objItem.PacketsPersec
    'Wscript.Echo "Packets Received Discarded: "              & objItem.PacketsReceivedDiscarded
    'Wscript.Echo "Packets Received Errors: "                 & objItem.PacketsReceivedErrors
	call outputModuleGenericData("Network Interface - " & objItem.Name & " Packets Received Errors",     "", objItem.PacketsReceivedErrors)
    'Wscript.Echo "Packets Received Non-Unicast Per Second: " & objItem.PacketsReceivedNonUnicastPersec
    'Wscript.Echo "Packets Received Per Second: "             & objItem.PacketsReceivedPersec
    'Wscript.Echo "Packets Received Unicast Per Second: "     & objItem.PacketsReceivedUnicastPersec
    'Wscript.Echo "Packets Received Unknown: "                & objItem.PacketsReceivedUnknown
    'Wscript.Echo "Packets Sent Non-Unicast Per Second: "     & objItem.PacketsSentNonUnicastPersec
    'Wscript.Echo "Packets Sent Per Second: "                 & objItem.PacketsSentPersec
    'Wscript.Echo "Packets Sent Unicast Per Second: "         & objItem.PacketsSentUnicastPersec
	
	
	' No usar, dan error y hacen que vaya mas lento
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

