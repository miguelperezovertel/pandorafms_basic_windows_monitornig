@ECHO OFF
@ECHO TODOS_LOS_VALORES
@ECHO Memoria Fisica
@echo TOTAL:
cscript.exe "PHYS_MEM_TOTAL_BYTES.VBS" //nologo
@echo FREE:
cscript.exe "PHYS_MEM_FREE_BYTES.VBS" //nologo
@echo USED:
cscript.exe "PHYS_MEM_USED_BYTES.VBS" //nologo
@ECHO Memoria Virtual
@echo TOTAL:
cscript.exe "PHYS_MEM_TOTAL_BYTES.VBS" //nologo
@echo FREE:
cscript.exe "PHYS_MEM_FREE_BYTES.VBS" //nologo
@echo USED:
cscript.exe "PHYS_MEM_USED_BYTES.VBS" //nologo