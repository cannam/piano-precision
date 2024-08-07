rem  Run this from within the top-level dir: deploy\win64\build-and-package.bat

set STARTPWD=%CD%

if not exist "C:\Program Files (x86)\SMLNJ\bin" (
@   echo Could not find SML/NJ, required for Repoint
@   exit /b 2
)

if not exist "C:\Program Files (x86)\WiX Toolset v3.14\bin" (
@   echo Could not find WiX Toolset
@   exit /b 2
)

set ORIGINALPATH=%PATH%

set ARG=%1
shift

@echo Rebuilding 64-bit

cd %STARTPWD%
del /q /s build_win64
call .\deploy\win64\build-64.bat
if %errorlevel% neq 0 exit /b %errorlevel%

if "%ARG%" == "sign" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "& 'deploy\win64\package.ps1' 'sign'"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "& 'deploy\win64\package.ps1'"
)
if errorlevel 1 exit /b %errorlevel%

set PATH=%ORIGINALPATH%

cd %STARTPWD%
@echo Done

