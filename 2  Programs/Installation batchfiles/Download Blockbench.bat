@echo Downloading Blockbench, please wait
@echo off
powershell Invoke-WebRequest "https://github-releases.githubusercontent.com/93747383/87a0aa1c-a88c-4ff3-9e8a-713ae3cbdd48?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20210921%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210921T141531Z&X-Amz-Expires=300&X-Amz-Signature=ddda813bedc086d69a24d0698010ffc9ff9b6b626f287d89244ceda00812004c&X-Amz-SignedHeaders=host&actor_id=81349208&key_id=0&repo_id=93747383&response-content-disposition=attachment%3B%20filename%3DBlockbench_3.9.3.exe&response-content-type=application%2Foctet-stream" -OutFile "%homepath%\Downloads\Anydesk.exe"
@echo off
pause