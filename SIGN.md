# Verify files signed with .asc

Download any file and sign with .asc extension in one folder and run

Bellow You can find samples for check signed .zip files

## On linux


check.sh [Download / view](AutoScript/check.sh)
```sh
curl -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | gpg --dearmor > /tmp/ace.gpg
for sig in *.zip.asc; do gpgv --keyring /tmp/ace.gpg "$sig" "${sig%.asc}"; done
rm -f /tmp/ace.gpg
```

## On Windows

check.ps1 [Download / view](AutoScript/check.ps1)

Execute ps1 file
```
powershell -ExecutionPolicy Bypass -File check.ps1
```
&nbsp;
```powershell
$KeyPath = "$env:TEMP\ace.gpg"

curl.exe -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | gpg --dearmor --yes -o $KeyPath

Get-ChildItem *.zip.asc | ForEach-Object {
    gpgv --keyring $KeyPath $_.Name $_.BaseName
}

Remove-Item $KeyPath -Force
```
one line command
```
curl -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | gpg --dearmor > "%TEMP%\ace.gpg" && (for %F in (*.zip.asc) do gpgv --keyring "%TEMP%\ace.gpg" "%F" "%~nF") && del /f /q "%TEMP%\ace.gpg"
```

check.cmd [Download / view](AutoScript/check.cmd)
```cmd
@echo off
curl -fsSL https://aceofsnakes.github.io/aceofsnakes.gpg | gpg --dearmor > "%TEMP%\ace.gpg"
for %%F in (*.zip.asc) do gpgv --keyring "%TEMP%\ace.gpg" "%%F" "%%~nF"
del /f /q "%TEMP%\ace.gpg"
```