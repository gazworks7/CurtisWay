# Logs Schema (v0.1)
- signals.csv: ts,symbol,tf,setup,entryPeriod,exitPeriod,dir,HH_N,LL_N,C1
- risk.csv: ts,symbol,dir,lots,sl,risk_pct,risk_usd,sl_pips,tag
- orders.csv: ts,symbol,dir,lots,price,sl,tag,ticket,status,magic
- fills.csv: ts,symbol,event,dir,price,sl_before,sl_after,pnl_open,magic
- exceptions.csv: ts,module,stage,code,reason,payload