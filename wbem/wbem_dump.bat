@if "%1" EQU "-help" (
  @goto help
)

@if "%1" EQU "--help" (
  @goto help
)

@if "%1" EQU "help" (
  @goto help
)

@if "%1" EQU "-h" (
  @goto help
)

@if "%1" EQU "" (
 @echo IP地址是必须的
 goto :eof
)

@if "%2" NEQ "" (
  @if "%3" EQU "" (
    @echo 密码是必须的
  )

  @set cmd_opt=-l %1 -u %2 -p %3
) else (
  @set cmd_opt=-l %1
)
@set address=%1

@if "%4" EQU "" (
  @goto all
)

@set cmd_opt=%cmd_opt% -n %4

@echo 遍历所有的类名
cimcli nc -di -ic -iq %cmd_opt% >>%address%_class_names.txt 2>>%address%_error.txt

@echo 遍历所有的类
cimcli ec -di -ic -iq %cmd_opt% >>%address%_classes.txt 2>>%address%_error.txt

@echo 遍历所有的实例
@for /F %%i in (%address%_class_names.txt) do cimcli ei %cmd_opt% %%i >>%address%_instances.txt 2>>%address%_error.txt
@exit /b 0

:all
@if exist %address% del /F /Q /S %address%
@if not exist %address% mkdir %address%
@echo 遍历命名空间
@echo 遍历命名空间  >>%address%\error.txt
@cimcli ns %cmd_opt% >%address%\namespaces.txt 2>%address%\error.txt

@for /F %%i in (%address%\namespaces.txt) do set namespace=%%i&&call :namespace_one %%i %1
@exit /b 0

:help
@echo %~dp0dump_all.bat 地址 [用户名 用户密码 [命名空间]]
@exit /b -1

:namespace_one

@echo 创建目录%namespace%
@echo 创建目录%namespace% >>%address%\error.txt
@set namespace_path=%namespace:/=\%
@set namespace_path=%namespace_path::=_%
@if not exist %address%\%namespace_path% mkdir %address%\%namespace_path%

@echo 遍历%namespace%中所有的类名
@echo 遍历%namespace%中所有的类名  >>%address%\error.txt
cimcli nc -di -ic -iq -n %namespace% %cmd_opt% >>%address%\%namespace_path%\class_names.txt 2>>%address%\error.txt

@echo 遍历%namespace%中所有的类
@echo 遍历%namespace%中所有的类  >>%address%\error.txt
cimcli ec -x -di -ic -iq -n %namespace% %cmd_opt% >>%address%\%namespace_path%\classes.txt 2>>%address%\error.txt

@echo 遍历%namespace%中所有的Qualifier
@echo 遍历%namespace%中所有的Qualifier  >>%address%\error.txt
cimcli eq -x -di -ic -iq -n %namespace% %cmd_opt% >>%address%\%namespace_path%\qualifiers.txt 2>>%address%\error.txt

@echo 遍历%namespace%中所有的实例
@echo 遍历%namespace%中所有的实例  >>%address%\error.txt
for /F %%i in (%address%\%namespace_path%\class_names.txt) do cimcli ei -x -di -ic -iq -n %namespace% %cmd_opt% %%i >>%address%\%namespace_path%\instances.txt 2>>%address%\error.txt

@exit /b 0