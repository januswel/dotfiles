@if "%~1" == "" goto error

@cd /d "%~dp1"

@echo 1st pass
x264.exe --pass 1 --bitrate 3000 --output "%~dp1%~n1-x264-2pass-3000kbps.mp4" "%~f1"
@echo.
@echo.

@echo 2nd pass
x264.exe --pass 2 --bitrate 3000 --output "%~dp1%~n1-x264-2pass-3000kbps.mp4" "%~f1"
@pause
@exit

:error
@echo specify a source file
@pause
