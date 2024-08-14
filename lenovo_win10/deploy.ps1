
# In order to run this script, create shortcut with following text as target (Properties->Shortcut, Target)
# C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -f C:\mago\igorba\git\setup\lenovo_win10\deploy.ps1
# In Advanced choose "Run as administrator", double click

Import-Module $PSScriptRoot\DotFiles.psm1

# TODO: deploy.ps1 doesn't support the latest format of the manifest

$HomeExists = Test-Path Env:HOME
if ($HomeExists -ne $True) {
    echo "Creating HOME environment variable and targeting it to $env:USERPROFILE"
    #[Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, "User")
} else {
    Write-Warning "HOME environment variable already exists. Not modifying the existing value."
}

#Deploy-Manifest MANIFEST

$EnvHome = $env:HOME
$SourcePath = "$PSScriptRoot\..\common\config\emacs.d"
$DestPath = "$EnvHome\.emacs.d"
Symlink-File $DestPath $SourcePath

$EnvHome = $env:HOME
$SourcePath = "$PSScriptRoot\..\common\config\gitconfig"
$DestPath = "$EnvHome\.gitconfig"
Symlink-File $DestPath $SourcePath

$EnvHome = $env:HOME
$SourcePath = "$PSScriptRoot\..\lenovo_win10\config\bash_profile"
$DestPath = "$EnvHome\.bash_profile"
Symlink-File $DestPath $SourcePath

pause