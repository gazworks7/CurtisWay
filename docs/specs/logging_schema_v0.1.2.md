# CurtisWay — Uniform CSV Logging (v0.1.2)

All modules write the SAME header, one CSV per module.

## CSV header (exact order)
timestamp,module,symbol,timeframe,action,state,ticket,order_type,side,entry_price,sl,tp,size_lots,risk_percent,risk_amount,balance,equity,comment,error_code

## Field notes
- **timestamp**: broker time ISO 8601 (e.g., 2025-09-25T14:03:21)
- **module**: Executor|RiskManager|Dashboard|Watchdog|NewsGuard|Signal-Donchian|Signal-ZLR
- **symbol**: e.g., EURUSD
- **timeframe**: M1|M5|M15|M30|H1|H4|D1 (or `-` for Services)
- **action**: OPEN|CLOSE|MODIFY|BLOCK|INFO|ERROR
- **state**: short machine state label (e.g., Ready, WaitingBreakout, RiskBlocked)
- **ticket**: order/deal ticket or 0 if N/A
- **order_type**: MARKET|LIMIT|STOP|N/A
- **side**: BUY|SELL|N/A
- **entry_price/sl/tp**: 0 if N/A
- **size_lots**: lots (double)
- **risk_percent**: % of balance for this trade (double)
- **risk_amount**: account currency amount at risk (double)
- **balance/equity**: snapshot at log time
- **comment**: free text (no commas or quote it)
- **error_code**: last error (0 if none)

## Example row
2025-09-25T14:03:21,Executor,EURUSD,M30,OPEN,Ready,12345678,MARKET,BUY,1.06780,1.06530,1.07280,0.10,1.0,100.00,10000.00,10020.00,"Donchian breakout",0
