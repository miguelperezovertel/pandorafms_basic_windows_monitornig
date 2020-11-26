' Verify System Uptime
' https://www.vbsedit.com/scripts/Hardware/monitor/scr_378.asp
' http://www.wisesoft.co.uk/scripts/vbscript_display_system_up_time-last_boot_up_time.aspx

'Conversion de tiempo datetime
'https://stackoverflow.com/questions/7011357/how-do-i-get-the-date-time-vbs

On Error Resume Next

strComputer = "."
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
 
For Each objOS in colOperatingSystems
    dtmBootup = objOS.LastBootUpTime
    dtmLastBootupTime = WMIDateStringToDate(dtmBootup)
    dtmSystemUptime = DateDiff("h", dtmLastBootUpTime, Now)
    'Wscript.Echo dtmBootup
	'Wscript.Echo dtmLastBootupTime 
	'Wscript.Echo dtmSystemUptime
Next

SET objWMIDateTime = CREATEOBJECT("WbemScripting.SWbemDateTime")
SET objWMI = GETOBJECT("winmgmts:\\" & strComputer & "\root\cimv2")
SET colOS = objWMI.InstancesOf("Win32_OperatingSystem")
FOR EACH objOS in colOS
	objWMIDateTime.Value = objOS.LastBootUpTime
	'Wscript.Echo "Last Boot Up Time: " & objWMIDateTime.GetVarDate & vbcrlf & "System Up Time: " &  TimeSpan(objWMIDateTime.GetVarDate,NOW) & " (hh:mm:ss)"
	'Wscript.Echo "Last Boot Up Time Sec : " & TimeSpanSec(objWMIDateTime.GetVarDate,NOW)
	tmp = TimeSpanSec(objWMIDateTime.GetVarDate,NOW)
	' Seconds from last boot
	call outputModuleGenericData("System Uptime - Seconds from Last Boot","",tmp)
	' Date time in string format of last boot
	call outputModuleGenericDataString("System Uptime - Date and Time of Last Boot","",objWMIDateTime.GetVarDate)
	' Local Date and Time as string
	call outputModuleGenericDataString("System Uptime - Local Date and Time","",FormatDateTime(Now))
NEXT
 
Function WMIDateStringToDate(dtmBootup)
    WMIDateStringToDate = CDate(Mid(dtmBootup, 5, 2) & "/" & _
        Mid(dtmBootup, 7, 2) & "/" & Left(dtmBootup, 4) _
            & " " & Mid (dtmBootup, 9, 2) & ":" & _
                Mid(dtmBootup, 11, 2) & ":" & Mid(dtmBootup,13, 2))
End Function

FUNCTION TimeSpan(dt1, dt2) 
	' Function to display the difference between
	' 2 dates in hh:mm:ss format
	IF (ISDATE(dt1) AND ISDATE(dt2)) = FALSE THEN 
		TimeSpan = "00:00:00" 
		EXIT FUNCTION 
        END IF 
 
        seconds = ABS(DATEDIFF("S", dt1, dt2)) 
        minutes = seconds \ 60 
        hours = minutes \ 60 
        minutes = minutes MOD 60 
        seconds = seconds MOD 60 
 
        IF LEN(hours) = 1 THEN hours = "0" & hours 
 
        TimeSpan = hours & ":" & RIGHT("00" & minutes, 2) & ":" & RIGHT("00" & seconds, 2) 
END FUNCTION 

FUNCTION TimeSpanSec(dt1, dt2) 
	' Function to display the difference between
	' 2 dates in hh:mm:ss format
	IF (ISDATE(dt1) AND ISDATE(dt2)) = FALSE THEN 
		TimeSpan = "00:00:00" 
		EXIT FUNCTION 
        END IF 
 
        seconds = ABS(DATEDIFF("S", dt1, dt2)) 
        minutes = seconds \ 60 
        hours = minutes \ 60 
        minutes = minutes MOD 60 
        seconds = seconds MOD 60 
 
        IF LEN(hours) = 1 THEN hours = "0" & hours 
 
        'TimeSpan = hours & ":" & RIGHT("00" & minutes, 2) & ":" & RIGHT("00" & seconds, 2) 
		TimeSpanSec = (CInt(hours)*60*60) + (CInt(minutes)*60) + CInt(seconds) 
END FUNCTION 

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

Sub outputModuleGenericDataString(module_name,module_description,cdata)
	Wscript.StdOut.Write "<module>"                                                                   & vbCrLf
	Wscript.StdOut.Write vbTab & "<name><![CDATA["        & module_name        & "]]></name>"         & vbCrLf
	Wscript.StdOut.Write vbTab & "<type><![CDATA[generic_data_string]]></type>"                       & vbCrLf
	Wscript.StdOut.Write vbTab & "<description><![CDATA[" & module_description & "]]></description>"  & vbCrLf
	Wscript.StdOut.Write vbTab & "<module_interval><![CDATA[1]]></module_interval>"                   & vbCrLf
	Wscript.StdOut.Write vbTab & "<data><![CDATA["        & cdata              & "]]></data>"         & vbCrLf
	Wscript.StdOut.WriteLine "</module>"
	'Wscript.StdOut.flush
End Sub