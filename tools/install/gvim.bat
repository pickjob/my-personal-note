@echo off
set GVIM=C:\Program Files\Vim\vim82\gvim.exe

if "%GVIM%" == "" (
    goto EXIT_WITH_MSG
) else (
    goto ADD_FILE_EXTS
)

:EXIT_WITH_MSG
echo EXIT_WITH_MSG
pause
exit


:ADD_FILE_EXTS
echo ADD_FILE_EXTS
REG ADD HKCR\gvim\shell\open\command /f /t REG_SZ /d "\"%GVIM%\" \"%%1\""
REG ADD HKCR\gvim\DefaultIcon /f /t REG_SZ /d "%GVIM%"
set fileExts=.c .go .h .java .json .log .md .rs .sh .sql .toml .txt
(for %%v in (%fileExts%) do (
    echo REG%%v
    REG DELETE HKCR\%%v /f
    REG ADD HKCR\%%v /f /t REG_SZ /d "gvim"
    REG ADD HKCR\%%v /f /t REG_SZ /v "Content Type" /d "text"
))
pause
