@REM ALL_MODULES
@rem @cscript.exe //B ".\.vbs" //nologo
@ECHO OFF
@cscript.exe //B ".\cpu_usage.vbs" //nologo
@cscript.exe //B ".\physical_memory.vbs" //nologo
@cscript.exe //B ".\virtual_memory.vbs" //nologo
@cscript.exe //B ".\disk_perfomance_logical_disk.vbs" //nologo
@cscript.exe //B ".\disk_perfomance_physical_disk.vbs" //nologo
@cscript.exe //B ".\interfaces.vbs" //nologo
@cscript.exe //B ".\system_uptime.vbs" //nologo
