@echo off
Setlocal EnableDelayedExpansion

set /p input= Input name:
set name=%input:~0,4%

set user="UPart2%name%"
set group="GPart2%name%"

net user "%user%" /passwordreq:no /add
net localgroup "%group%" /add
net localgroup "%group%" "%user%" /add
net user "%user%" /active:yes