# Signal Spec — Donchian Breakout (signal_spec_Donchian_v0.1)

Module: `CurtisWay_Signal_Donchian.mq5` (Expert)

## Defaults
- System 1: Entry=20, Exit=10
- System 2: Entry=55, Exit=20
- Timeframe: D1 (or attached chart TF)
- ConfirmOnClose=true (use completed bar Close[1])

## Rules
Let C1 = Close[1]. HH_N = highest high of last EntryPeriod bars (1..N). LL_N = lowest low likewise.
- Long entry: C1 > HH_N
- Short entry: C1 < LL_N

Exits (informational for v0.1; Steward manages actual exits):
- Exit long: C1 < LL_X (X=ExitPeriod)
- Exit short: C1 > HH_X

## Output (GV + CSV)
Key: `CW/<SYMBOL>/SIGNAL/<ID>`
Payload example:
```
{"v":1,"ts":"2025-09-25T15:20:00Z","symbol":"USDCAD","tf":"D1","setup":"DONCHIAN","entryPeriod":20,"exitPeriod":10,"dir":"LONG","ref":{"HH_N":1.3942,"LL_N":1.3821,"C1":1.3950},"notes":"S1; confirmOnClose=true"}
```