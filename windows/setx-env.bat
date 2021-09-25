@REM SET PERSONAL ENVIRONMENT
SET REPOSITORY=%SystemDrive%\repository
SET PYTHON_PATH=%LOCALAPPDATA%\Programs\Python\Python39
SET MY_PATH=

@REM DEFAUTLT WINDOWS PATH
SET MY_PATH=%SystemRoot%;%SystemRoot%\system32;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\OpenSSH\;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\

@REM WINDOWS STORE PATH
SET MY_PATH=%MY_PATH%;%LOCALAPPDATA%\Microsoft\WindowsApps

@REM MAVEN_HOME
SETX MAVEN_HOME %REPOSITORY%\maven

@REM GRADLE_HOME
SETX GRADLE_HOME %REPOSITORY%\gradle

@REM RUST
@REM SETX RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup
@REM SETX RUSTUP_HOME %REPOSITORY%\rustup
SETX CARGO_HOME %REPOSITORY%\cargo
SET MY_PATH=%MY_PATH%;%REPOSITORY%\cargo\bin

@REM @REM GO
@REM SETX GO111MODULE on
@REM SETX GOPROXY https://goproxy.cn
@REM SETX GOPATH %REPOSITORY%\golang
@REM SETX GOROOT %SystemDrive%\msys64\mingw64\lib\go
@REM SET MY_PATH=%MY_PATH%;%REPOSITORY%\golang\bin

@REM PYTHON
SETX PYTHONUSERBASE %REPOSITORY%\python
SET MY_PATH=%MY_PATH%;%PYTHON_PATH%;%PYTHON_PATH%\Scripts;%REPOSITORY%\python\Python39\Scripts

@REM NODEJS
SET MY_PATH=%MY_PATH%;%ProgramFiles%\nodejs;%REPOSITORY%\npm\bin;

@REM MYSY2 PATH
SET MY_PATH=%MY_PATH%;%SystemDrive%\msys64\mingw64\share\qt6\bin;%SystemDrive%\msys64\usr\bin;%SystemDrive%\msys64\mingw64\bin

@REM DOCKER
SET MY_PATH=%MY_PATH%;%SystemRoot%\Program Files\Docker\Docker\resources\bin

@REM some tools
SET MY_PATH=%MY_PATH%;%REPOSITORY%\bin

SETX Path "%MY_PATH%"
