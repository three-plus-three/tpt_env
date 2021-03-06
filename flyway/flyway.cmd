@REM
@REM Copyright 2010-2016 Boxfuse GmbH
@REM
@REM Licensed under the Apache License, Version 2.0 (the "License");
@REM you may not use this file except in compliance with the License.
@REM You may obtain a copy of the License at
@REM
@REM         http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing, software
@REM distributed under the License is distributed on an "AS IS" BASIS,
@REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM See the License for the specific language governing permissions and
@REM limitations under the License.
@REM

@Echo off

setlocal

@REM Set the current directory to the installation directory
set INSTALLDIR=%~dp0

if EXIST "%INSTALLDIR%\..\jre\bin\java.exe" (
  set JAVA_CMD="%INSTALLDIR%\..\jre\bin\java.exe"
) ELSE if EXIST "%INSTALLDIR%\..\java\bin\java.exe" (
  set JAVA_CMD="%INSTALLDIR%\..\java\bin\java.exe"
) ELSE if EXIST "%INSTALLDIR%\..\jdk\bin\java.exe" (
  set JAVA_CMD="%INSTALLDIR%\..\jdk\bin\java.exe"
) ELSE (
 if "%JAVA_HOME%" EQU "" (
  JAVA_CMD=java
 ) ELSE (
  JAVA_CMD="%JAVA_HOME%\bin\java.exe"
 )
)

%JAVA_CMD% -cp "%INSTALLDIR%\lib\*;%INSTALLDIR%\drivers\*" org.flywaydb.commandline.Main %* -jarDirs="%INSTALLDIR%\..\..\lib\server_biz"

@REM Exit using the same code returned from Java
EXIT /B %ERRORLEVEL%
