@ECHO OFF
SET GVIM=
SET IDEA=
SET ZIPFM=Program Files\7-Zip\7zFM.exe
@REM SET GVIM=C:\Program Files\Vim\vim82\gvim.exe
@REM SET IDEA=C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2020.3.2\bin\idea64.exe
@REM SET ZIPFM=C:\Program Files\7-Zip\7zFM.exe


SET CLASS_ROOT=HKCU\SOFTWARE\Classes
SET REPOSITORY=%UserProfile%\repository
SET MY_PATH=

if NOT "%GVIM%" == "" (
    GOTO ADD_GVIM_FILE_EXTS
)

if NOT "%ZIP%" == "" (
    GOTO ADD_ZIP_FILE_EXTS
)

if NOT "%IDEA%" == "" (
    GOTO OPEN_WITH_IDEA
)

GOTO SET_PATH

:ADD_GVIM_FILE_EXTS
ECHO ADD_GVIM_FILE_EXTS
REG ADD %CLASS_ROOT%\Applications\gvim.exe\shell\open\command /f /t REG_SZ /d "\"%GVIM%\" \"%%1\""
REG ADD %CLASS_ROOT%\Applications\gvim.exe\DefaultIcon /f /t REG_SZ /d "%GVIM%"
SET fileExts=.c .cpp .conf .cs .go .h .ini .java .json .log .md .py .properties .rs .sh .sql .toml .txt .xml .yaml .yml .vim
(for %%v in (%fileExts%) do (
    ECHO regeister %%v
    REG DELETE %CLASS_ROOT%\%%v /f
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

:OPEN_WITH_IDEA
ECHO OPEN_WITH_IDEA
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA /f /t REG_SZ /d "Open With Idea"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA /f /t REG_SZ -v "Icon" /d "%IDEA%"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA\command /f /t REG_SZ /d "\"%IDEA%\" \"%%1\""
GOTO FINAL

:SET_PATH
ECHO SET PATH
SET MY_PATH=C:\msys64\usr\bin;C:\msys64\mingw64\bin

SETX GRADLE_HOME %REPOSITORY%\gradle

@REM x86_64-pc-windows-gnu
SETX RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup
SETX RUSTUP_HOME %REPOSITORY%\rustup
SETX CARGO_HOME %REPOSITORY%\cargo
SET MY_PATH=%MY_PATH%;%REPOSITORY%\cargo\bin

SETX GO111MODULE on
SETX GOPROXY https://goproxy.cn
SETX GOPATH %REPOSITORY%\golang
SETX GOROOT C:\msys64\mingw64\lib\go
SET MY_PATH=%MY_PATH%;%REPOSITORY%\golang\bin

SETX PYTHONUSERBASE %REPOSITORY%\python
SET MY_PATH=%MY_PATH%;%REPOSITORY%\python\bin

SET MY_PATH=%MY_PATH%;%REPOSITORY%\npm\bin;D:\tools\nodejs

SETX Path %MY_PATH%


:FINAL
PAUSE
@REM EXIT