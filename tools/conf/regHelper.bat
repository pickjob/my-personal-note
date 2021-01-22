@ECHO off
SET GVIM=
SET IDEA=

:STEP_1
if NOT "%GVIM%" == "" (
    GOTO ADD_GVIM_FILE_EXTS
)

:STEP_2
if NOT "%IDEA%" == "" (
    GOTO ADD_IDEA_DIRECTORY
)

:SETP_FINAL
GOTO EXIT_WITH_MSG

:EXIT_WITH_MSG
ECHO EXIT_WITH_MSG
PAUSE
exit


:ADD_GVIM_FILE_EXTS
ECHO ADD_GVIM_FILE_EXTS
REG ADD HKCU\SOFTWARE\Classes\gvim\shell\open\command /f /t REG_SZ /d "\"%GVIM%\" \"%%1\""
REG ADD HKCU\SOFTWARE\Classes\gvim\DefaultIcon /f /t REG_SZ /d "%GVIM%"
SET fileExts=.c .cpp .conf .cs .go .h .ini .java .json .log .md .py .properties .rs .sh .sql .toml .txt .xml .yaml .yml .vim
(for %%v in (%fileExts%) do (
    ECHO %%v
    REG DELETE HKCR\%%v /f
    REG ADD HKCU\SOFTWARE\Classes\%%v /f /t REG_SZ /d "gvim"
    REG ADD HKCU\SOFTWARE\Classes\%%v /f /t REG_SZ /v "Content Type" /d "text"
))
PAUSE
GOTO STEP_2

:ADD_IDEA_DIRECTORY
ECHO ADD_IDEA_DIRECTORY
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA /f /t REG_SZ /d "Open With Idea"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA /f /t REG_EXPAND_SZ -v "Icon" /d "%IDEA%"
REG ADD HKCU\SOFTWARE\Classes\Directory\shell\IDEA\command /f /t REG_EXPAND_SZ /d "\"%IDEA%\" \"%%1\""
PAUSE
GOTO SETP_FINAL