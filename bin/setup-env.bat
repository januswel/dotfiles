@echo off
rem sets up environment
cd /d %~dp0
powershell Set-ExecutionPolicy RemoteSigned
powershell .\setup-env.ps1
powershell Set-ExecutionPolicy Restricted
pause
