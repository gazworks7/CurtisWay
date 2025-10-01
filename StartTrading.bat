@echo off
:: Launch MetaTrader 5
start "" "C:\Program Files\TradeMax Global MT5 Terminal\terminal64.exe"



:: Wait for MT5 to steal focus & finish loading
timeout /t 6 /nobreak >nul


:: Launch daily trading checklist (CurtisWay script, Morning mode) - hidden console
start "" powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File "C:\Users\gmurp\Documents\CurtisWay\OpenDailyChecklist.ps1" -Mode Morning

