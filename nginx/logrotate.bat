set current_dir=%~dp0%


if exist "%current_dir%\logs\access_5.log" DEL /F /Q "%current_dir%\logs\access_5.log"
if exist "%current_dir%\logs\access_4.log" RENAME "%current_dir%\logs\access_4.log" access_5.log
if exist "%current_dir%\logs\access_3.log" RENAME "%current_dir%\logs\access_3.log" access_4.log
if exist "%current_dir%\logs\access_2.log" RENAME "%current_dir%\logs\access_2.log" access_3.log
if exist "%current_dir%\logs\access_1.log" RENAME "%current_dir%\logs\access_1.log" access_2.log
if exist "%current_dir%\logs\access.log" RENAME "%current_dir%\logs\access.log" access_1.log

if exist "%current_dir%\logs\error_5.log" DEL /F /Q "%current_dir%\logs\error_5.log"
if exist "%current_dir%\logs\error_4.log" RENAME "%current_dir%\logs\error_4.log" error_5.log
if exist "%current_dir%\logs\error_3.log" RENAME "%current_dir%\logs\error_3.log" error_4.log
if exist "%current_dir%\logs\error_2.log" RENAME "%current_dir%\logs\error_2.log" error_3.log
if exist "%current_dir%\logs\error_1.log" RENAME "%current_dir%\logs\error_1.log" error_2.log
if exist "%current_dir%\logs\error.log" RENAME "%current_dir%\logs\error.log" error_1.log

cd /D %current_dir%
FOR /F "eol=; tokens=1 delims=, " %%i in (logs\nginx.pid) do taskkill /F /PID %%i /T
