@ECHO OFF
@REM C:\Program Files\Microsoft VS Code\Code.exe
SET VSCODE=
@REM C:\tools\IntelliJIDEA.Community\bin\idea64.exe
SET IDEA=
@REM C:\Program Files\Vim\vim82\gvim.exe
SET GVIM=
@REM C:\Program Files\7-Zip\7zFM.exe
SET ZIP=
@REM C:\tools\v2ray\v2ray.exe
SET V2RAY=
@REM C:\Program Files\Zeal\zeal.exe
SET ZEAL=

SET CLASS_ROOT=HKCU\SOFTWARE\Classes

if NOT "%VSCODE%" == "" (
    GOTO OPEN_WITH_VSCODE
)

if NOT "%IDEA%" == "" (
    GOTO OPEN_WITH_IDEA
)

if NOT "%GVIM%" == "" (
    GOTO ADD_GVIM_FILE_EXTS
)

if NOT "%ZIP%" == "" (
    GOTO ADD_ZIP_FILE_EXTS
)

if NOT "%V2RAY%" == "" (
    GOTO V2RAY_AUTO_RUN
)

if NOT "%ZEAL%" == "" (
    GOTO ZEAL_AUTO_RUN
)

:OPEN_WITH_VSCODE
ECHO OPEN_WITH_VSCODE
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\VSCODE /f /t REG_SZ /d "Open With VsCode"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\VSCODE /f /t REG_SZ -v "Icon" /d "%VSCODE%"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\VSCODE\command /f /t REG_SZ /d "\"%VSCODE%\" \"%%1\""
GOTO FINAL

:OPEN_WITH_IDEA
ECHO OPEN_WITH_IDEA
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA /f /t REG_SZ /d "Open With Idea"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA /f /t REG_SZ -v "Icon" /d "%IDEA%"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA\command /f /t REG_SZ /d "\"%IDEA%\" \"%%1\""
GOTO FINAL

:ADD_GVIM_FILE_EXTS
ECHO ADD_GVIM_FILE_EXTS
REG ADD %CLASS_ROOT%\Applications\gvim.exe\shell\open\command /f /t REG_SZ /d "\"%GVIM%\" \"%%1\""
REG ADD %CLASS_ROOT%\Applications\gvim.exe\DefaultIcon /f /t REG_SZ /d "%GVIM%"
SET fileExts=.c .cpp .conf .cs .go .h .ini .java .json .log .md .py .properties .rs .sh .sql .toml .txt .xml .yaml .yml .vim
(for %%v in (%fileExts%) do (
    ECHO regeister %%v
    REG DELETE %CLASS_ROOT%\%%v /
    REG ADD %CLASS_ROOT%\%%v /f /t REG_SZ /d "Applications\gvim.exe"
    REG ADD %CLASS_ROOT%\%%v /f /t REG_SZ /v "Content Type" /d "text"
))
GOTO FINAL

:ADD_ZIP_FILE_EXTS
ECHO ADD_ZIP_FILE_EXTS
REG ADD %CLASS_ROOT%\Applications\7zFM.exe\shell\open\command /f /t REG_SZ /d "\"%ZIPFM%\" \"%%1\""
REG ADD %CLASS_ROOT%\Applications\7zFM.exe\DefaultIcon /f /t REG_SZ /d "%ZIPFM%"
SET fileExts=.7z .gz .tar .tgz .xz .zip
(for %%v in (%fileExts%) do (
    ECHO regeister %%v
    REG DELETE %CLASS_ROOT%\%%v /f
    REG ADD %CLASS_ROOT%\%%v /f /t REG_SZ /d "Applications\7zFM.exe"
    REG ADD %CLASS_ROOT%\%%v /f /t REG_SZ /v "Content Type" /d "application"
))
GOTO FINAL

:V2RAY_AUTO_RUN
ECHO V2RAY_AUTO_RUN
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /f /t REG_SZ /v "V2Ray" /d "\"%V2RAY%\""
GOTO FINAL

:ZEAL_AUTO_RUN
ECHO ZEAL_AUTO_RUN
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /f /t REG_SZ /v "Zeal" /d "\"%ZEAL%\""
GOTO FINAL

:FINAL
@REM EXIT
