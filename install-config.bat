@REM
mkdir %SystemDrive%\repository
SET REPOSITORY=%SystemDrive%\repository
@REM windows/setx-env.bat

@REM git
copy .\tools\git\gitconfig %USERPROFILE%\.gitconfig

@REM vim
mkdir %REPOSITORY%\vimfiles\autoload
copy .\tools\vim\_vimrc %USERPROFILE%
copy .\tools\vim\plug.vim %REPOSITORY%\vimfiles\autoload

@REM cargo
mkdir %REPOSITORY%%\cargo
copy .\tools\cargo\config.toml %REPOSITORY%%\cargo

@REM pip
mkdir %APPDATA%\pip
copy .\tools\pip\pip.conf %APPDATA%\pip\pip.ini

@REM npm
copy .\tools\npm\_npmrc %USERPROFILE%%\.npmrc

@REM maven
mkdir %USERPROFILE%\.m2
copy .\tools\maven\settings.xml %USERPROFILE%\.m2

@REM windows/regHelper.bat
