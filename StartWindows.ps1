$Repository = "C:\repository"

$MyPath = "C:\WINDOWS\system32;C:\WINDOWS"
$Version = (Get-Content "StartWindows.json") | ConvertFrom-Json
$Start = (Get-Location).Path
# 
# Msys2配置
# 
$MsysRepository = "$Repository\msys64"
$MyPath = "$MyPath;$MsysRepository\usr\bin;$MsysRepository\clang64\bin"
# MINGW
[Environment]::SetEnvironmentVariable("MINGW", "$MsysRepository\mingw64", [System.EnvironmentVariableTarget]::User)
# CLANG
[Environment]::SetEnvironmentVariable("CLANG", "$MsysRepository\clang64", [System.EnvironmentVariableTarget]::User)
# 
# vcs
# 
$VcsRepository = "$Repository\vcs"
# Git
$MyPath = "$MyPath;$VcsRepository\git-win-$($Version.Git)\bin"
Copy-Item "$Start\utils\git\gitconfig" -Destination "$env:USERPROFILE\.gitconfig" -Force
# Subversion
$MyPath = "$MyPath;$VcsRepository\subversion-win-$($Version.Subversion)\bin"
# 
# Editor
# 
$EditorRepository = "$Repository\editor"
function Set-DirectoryAssociate {
    param (
        $Key,
        $ExecutePath
    )
    New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Shell\$Key" -Value "Open With $Key" -Force
    New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Shell\$Key" -Name "Icon" -Value "`"$ExecutePath`", 0" -Force
    New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Shell\$Key\Command" -Value "`"$ExecutePath`" `"%1`"" -Force
}
Set-DirectoryAssociate VsCode "$EditorRepository\code-win-$($Version.Code)\Code.exe"
function Set-FileyAssociate {
    param (
        $Key,
        $ExecutePath,
        $Extensions
    )
    foreach ($Extension in $Extensions) {
        New-Item -Path "HKCU:\SOFTWARE\Classes\$Extension" -Value $Key -Force
    }
    New-Item -Path "HKCU:\SOFTWARE\Classes\$Key" -Value "$Key" -Force
    New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\$Key" -Name "Icon" -Value "`"$ExecutePath`", 0" -Force
    New-Item -Path "HKCU:\SOFTWARE\Classes\$Key\Shell\Open\Command" -Value "`"$ExecutePath`" `"%1`"" -Force
}
# Gvim
$Extensions = ".c,.cpp,.conf,.cs,.gradle,.go,.h,.inc,.ini,.java,.json,.kt,.log,.md,.ps1,.py,.properties,.rs,.sh,.sql,.toml,.txt,.xml,.yaml,.yml,.vim,.vmoptions".Split(",")
Set-FileyAssociate GVim "$EditorRepository\vim-win-$($Version.Vim)\gvim.exe" $Extensions
# VimScript
$VimFileRepository = "$Repository\vimfiles"
Set-Content "$env:USERPROFILE\_vimrc" -Value "set runtimepath+=$VimFileRepository"
Add-Content "$env:USERPROFILE\_vimrc" -Value "source $Start\utils\vim\vimrc.vim"
Add-Content "$env:USERPROFILE\_vimrc" -Value "let `$Path = '$env:CLANG' .. '\bin;' .. `$Path"
Copy-Item "$Start\utils\vim\coc-settings.json" -Destination "$VimFileRepository\coc-settings.json" -Force
Copy-Item "$Start\utils\vim\.tasks" -Destination "$VimFileRepository\.tasks" -Force
[Environment]::SetEnvironmentVariable("VIM_FILES_HOME", "$VimFileRepository", [System.EnvironmentVariableTarget]::User)
# IntellJ
Set-DirectoryAssociate IntelliJ "$EditorRepository\idea-win-$($Version.Idea)\bin\idea64.exe"
[Environment]::SetEnvironmentVariable("IntellJ", "$Repository\idea-win", [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("IDEA_PROPERTIES", "$Repository\idea-win\idea.properties", [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("IDEA64_VM_OPTIONS", "$Repository\idea-win\idea64.exe.vmoptions", [System.EnvironmentVariableTarget]::User)
# 
# Program language
# 
$LanguageRepository = "$Repository\language"
# java
$JavaRepository = "$LanguageRepository\jdk-win-$($Version.Java)"
[Environment]::SetEnvironmentVariable("JAVA_HOME", $JavaRepository, [System.EnvironmentVariableTarget]::User)
$MyPath = "$MyPath;$JavaRepository\bin"
$GraalvmRepository = "$LanguageRepository\graalvm-win-$($Version.Graalvm)"
[Environment]::SetEnvironmentVariable("GRAALVM_HOME", $GraalvmRepository, [System.EnvironmentVariableTarget]::User)
$MyPath = "$MyPath;$GraalvmRepository\bin"
# Rustup
$RustupRepository = "$Repository\rustup-win"
[Environment]::SetEnvironmentVariable("RUSTUP_HOME", $RustupRepository, [System.EnvironmentVariableTarget]::User)
# Cargo
$CargoRepository = "$Repository\cargo-win"
[Environment]::SetEnvironmentVariable("CARGO_HOME", $CargoRepository, [System.EnvironmentVariableTarget]::User)
Copy-Item "$Start\utils\cargo\config.toml" -Destination "$CargoRepository\config.toml" -Force
$MyPath = "$MyPath;$CargoRepository\bin"
# Python
New-Item "$env:APPDATA\pip" -ItemType "directory" -Force
Copy-Item "$Start\utils\pip\pip.conf" -Destination "$env:APPDATA\pip\pip.ini" -Force
Add-Content "$env:APPDATA\pip\pip.ini" -Value "cache-dir = $Repository\pip-win"
# Node
$NpmRepository = "$Repository\npm-win"
Set-Content "$env:USERPROFILE\.npmrc" -Value "prefix=$NpmRepository\node_module"
Add-Content "$env:USERPROFILE\.npmrc" -Value "cache=$NpmRepository\node_cache"
$MyPath = "$MyPath;$LanguageRepository\node-win-$($Version.Node)"
$MyPath = "$MyPath;$NpmRepository\node_module"
# Go
[Environment]::SetEnvironmentVariable("GO111MODULE", "on", [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("GOPROXY", "https://goproxy.cn", [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("GOPATH", "$Repository\go-win", [System.EnvironmentVariableTarget]::User)
# Powershell
Copy-Item "$Start\utils\powershell\profile.ps1" -Destination "$LanguageRepository\PowerShell-win-$($Version.Powershell)\profile.ps1" -Force
$MyPath = "$MyPath;$LanguageRepository\PowerShell-win-$($Version.Powershell)"
# 
# Program Utils
# 
$JavaPlatformRepository = "$Repository\java-platform"
# Maven
$MavenRepository = "$JavaPlatformRepository\apache-maven-$($Version.Maven)"
[Environment]::SetEnvironmentVariable("MAVEN_HOME", $MavenRepository, [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("MAVEN_REPOSITORY", "$Repository\maven", [System.EnvironmentVariableTarget]::User)
New-Item "$env:USERPROFILE\.m2" -ItemType "directory" -Force
Copy-Item "$Start\utils\maven\settings.xml" -Destination "$env:USERPROFILE\.m2\" -Force
$MyPath = "$MyPath;$MavenRepository\bin"
# Gradle
$GradleRepository = "$Repository\gradle"
[Environment]::SetEnvironmentVariable("GRADLE_USER_HOME", $GradleRepository, [System.EnvironmentVariableTarget]::User)
Copy-Item "$Start\utils\gradle\gradle.properties" -Destination "$GradleRepository\gradle.properties" -Force
# Tomcat
$TomcatRepository = "$JavaPlatformRepository\apache-tomcat-$($Version.Tomcat)"
[Environment]::SetEnvironmentVariable("CATALINA_HOME", $TomcatRepository, [System.EnvironmentVariableTarget]::User)
# 
# Utils
# 
function Set-AutoRun {
    param (
        $Key,
        $ExecutePath
    )
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name $Key -Value `"$ExecutePath`" -Force
}
$UtilsRepository = "$Repository\utils"
Set-AutoRun "V2ray" "$UtilsRepository\v2ray-win-$($Version.V2ray)\v2ray.exe"
Set-AutoRun "Everything" "$UtilsRepository\Everything-win-$($Version.Everything)\Everything.exe"
# WSL
Copy-Item "$Start\utils\wsl\wslconfig" -Destination "$env:USERPROFILE\.wslconfig" -Force
# zsh
Copy-Item "$Start\utils\zsh\zshenv" -Destination "$MsysRepository\home\$env:UserName\.zshenv" -Force
Copy-Item "$Start\utils\zsh\zshrc" -Destination "$MsysRepository\home\$env:UserName\.zshrc" -Force
# fzf
[Environment]::SetEnvironmentVariable("FZF_DEFAULT_COMMAND", "fd --type f", [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("FZF_DEFAULT_OPTS", "--height=50% --layout=reverse --preview='bat {}' --preview-window='right:50%'", [System.EnvironmentVariableTarget]::User)
# 
# bin
# 
$MyPath = "$MyPath;$Repository\bin"
[Environment]::SetEnvironmentVariable("Path", $MyPath, [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("Repository", $Repository, [System.EnvironmentVariableTarget]::User)
