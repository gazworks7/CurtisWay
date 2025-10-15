# Signal_TLB — v0.2 (Draft)

## Purpose
Provide CCI Trend Line Break (TLB) as an optional signal source that publishes to GV bus for CurtisWay.

## Inputs (initial)
- Timeframe to read CCI from (default: H1)
- CCI period (default: 14)
- Min touches for line validity (2+)
- R² threshold (0.70 default)
- Break threshold (points above/below line)
- Lookback bars (e.g., 250)

## Outputs (GV schema)
- CW/<SYMBOL>/SIGNAL/TLB  = { -1, 0, +1 }  (sell, none, buy)
- CW/<SYMBOL>/SIGNAL/TLB/QUALITY = float  (0..1 R²)
- CW/<SYMBOL>/SIGNAL/TLB/TIME = datetime  (server)

## Rules (first pass)
1) Detect swing points on CCI; build bullish/bearish lines with min touches & R² ≥ threshold.
2) A valid **BUY** when CCI breaks a bearish line upward by `break_threshold`.
3) A valid **SELL** when CCI breaks a bullish line downward by `break_threshold`.
4) Only one active signal per bar; don’t repeat on the same bar.
5) Write GV and heartbeat `CW/HB/Signal_TLB` every X seconds.

## Integration
- Risk Manager treats TLB like Donchian signals (same GV bus).
- News Guard can still block entries.
- Executor unchanged.

## Logs/Diagnostics
- Write human-readable note to `MQL5/Files/CurtisWay/logs/signal_tlb_*.csv`
- ChartComment (optional) mirrors last signal & quality.

## Test Plan (demo)
- Symbols: USDCAD
- TFs: H1 (signal), H4 (execution)
- Duration: 2–4 weeks
- Metrics: hit-rate, avg MAE/MFE, equity curve, false triggers

## Out of scope (v0.2)
- Pyramiding changes
- Multi-symbol orchestration



## Out of scope (v0.2)
- Pyramiding changes
- Multi-symbol orchestration
