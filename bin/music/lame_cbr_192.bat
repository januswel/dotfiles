@if "%~1" == "" goto error

@cd /d "%~dp1"

@echo 1st pass
avs2wav.exe "%~f1" | lame -b 192 - "%~dp1%~n1-lame-cbr-192.mp3"
@pause

@exit
:error
@echo specify a source file
@pause
