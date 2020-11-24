' Virtual Memory Total
strComputer = "."
'data_0 = 0
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colSettings = objWMIService.ExecQuery _
("Select * from Win32_OperatingSystem")

For Each objOperatingSystem in colSettings 
  Wscript.Echo objOperatingSystem.TotalVirtualMemorySize
  'data_0 = data_0 + objOperatingSystem.TotalVirtualMemorySize
Next

'Wscript.Echo data_0