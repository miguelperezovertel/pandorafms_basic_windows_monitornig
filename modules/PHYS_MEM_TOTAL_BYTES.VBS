Dim WMI
Set WMI = GetObject("winmgmts:root/cimv2")

Dim Collection, Item
Set Collection = WMI.InstancesOf("Win32_ComputerSystem")
For Each Item In Collection
  WScript.Echo Item.TotalPhysicalMemory
  Exit For
Next