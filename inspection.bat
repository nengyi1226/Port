@echo off
setlocal enabledelayedexpansion
set PORTS=3389 445 137 138 139 5985 5986

for %%p in (%PORTS%) do (
    echo Checking port %%p...
    netstat -ano | findstr :%%p
)

pause