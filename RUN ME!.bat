@ECHO OFF
ECHO Hello IT person and welcome to Austin's Office 2019 install tool.
ECHO.
ECHO -----------------------------------------------------------------------------
ECHO Please ensure that this BAT file is located where the setup and configuration file is located for Office 2019
ECHO Also ensure that all USB sticks are removed from the PC
ECHO ------------------------------------------------------------------------------
ECHO.
ECHO.

ECHO Would you like to make changes to the CD key or version of office?
CHOICE /C KS /M "Press K for Key and Version, S to Skip and user current configuration file"
IF %ERRORLEVEL% EQU 1 GOTO K
IF %ERRORLEVEL% EQU 2 GOTO INSTALL


:K
ECHO.

ECHO Please enter your new CD key, ENSURE the key is all CAPS. After entering Key hit enter.
ECHO The format for the key is #####-#####-#####-#####-#####  (5 characters per segment)

SET /P KEY=

ECHO.

ECHO Please select the version you would like to install and then hit enter.
ECHO 1. Office Standard 2019 (32-bit)
ECHO 2. Office Standard 2019 (64-bit)
ECHO 3. Office Professional Plus 2019 (32-bit)
ECHO 4. Office Professional Plus 2019 (64-bit)
SET /P VERSION=


IF %VERSION% EQU 1 SET XMLVERSION=Office Standard 2019 (32-bit)
IF %VERSION% EQU 2 SET XMLVERSION=Office Standard 2019 (64-bit)
IF %VERSION% EQU 3 SET XMLVERSION=Office Professional Plus 2019 (32-bit)
IF %VERSION% EQU 4 SET XMLVERSION=Office Professional Plus 2019 (64-bit)

ECHO %XMLVERSION%

ECHO.

ECHO ^<Configuration^> > configuration.xml
ECHO ^<Info Description=^"%XMLVERSION%^" /^> >> configuration.xml
ECHO ^<Add OfficeClientEdition="32" Channel="PerpetualVL2019" SourcePath="C:\OfficeSetup"^> >> configuration.xml
ECHO ^<Product ID="Standard2019Volume" PIDKEY=^"%KEY%^"^> >> configuration.xml
ECHO ^<Language ID="en-us" /^> >> configuration.xml
ECHO ^</Product^> >> configuration.xml
ECHO ^</Add^> >> configuration.xml
ECHO ^<RemoveMSI /^> >> configuration.xml
ECHO ^<Display Level="Full" AcceptEULA="TRUE" /^> >> configuration.xml
ECHO ^</Configuration^> >> configuration.xml

ECHO.
GOTO INSTALL


:INSTALL

ECHO.
ECHO Are you ready to start the install?

CHOICE /C YN /M "Press Y for Yes, N for No"
IF %ERRORLEVEL% EQU 1 GOTO Y
IF %ERRORLEVEL% EQU 2 GOTO N

:Y
ECHO.
ECHO Starting install process
ECHO This will take some time and may look like nothing is happening
ECHO.
ECHO.

ECHO setup.exe /download configuration.xml
setup.exe /download configuration.xml

PAUSE

ECHO setup.exe /configure configuration.xml
setup.exe /configure configuration.xml

ECHO Office should now be installed!

:N

EXIT
