# CurtisWay System Wiring Guide

## Cheat Sheet (Quick Setup)

Use this for fast reference when wiring up the CurtisWay system.

### Charts
- Open one **H4 chart** for USDCAD → attach `CurtisWay_Signal_Donchian.mq5`.
- Open a second **H4 chart (optional, monitoring)** → attach `CurtisWay_Dashboard.mq5`.
- No other charts needed unless testing additional signals.

### Services
- `CurtisWay_Risk_Manager.mq5` → risk sizing + daily cap.
- `CurtisWay_News_Guard.mq5` → blocks trades during news.
- `CurtisWay_Watchdog.mq5` → monitors heartbeat of all components.
- `CurtisWay_Steward.mq5` → housekeeping, trailing stops, timed close.

### Expert Advisor
- `CurtisWay_Executor.mq5` → attach to H4 chart (USDCAD).
- Reads `ORDER/REQ` GVs, places trades, writes `ORDER/ACK`.

### Global Variables (GVs)
- Signals → `CW/<SYMBOL>/SIGNAL/...`
- Orders → `CW/<SYMBOL>/ORDER/...`
- Heartbeat → `CW/HB/...`
- Risk → `CW/<SYMBOL>/RISK/...`

---

## Detailed Wiring Guide

### 1. Charts Setup
- **Signal Chart (H4)** → `CurtisWay_Signal_Donchian.mq5` → publishes trade signals (GV).
- **Dashboard Chart (H4)** → `CurtisWay_Dashboard.mq5` → displays status overlay.
- **Executor Chart (H4)** → `CurtisWay_Executor.mq5` → executes trades.
- Optional extra charts for monitoring.

### 2. Services
- Run from MT5 *Services tab*:
  - **Risk_Manager**: computes lot size, enforces daily cap.
  - **News_Guard**: blocks during news windows.
  - **Watchdog**: checks all modules alive.
  - **Steward**: resets, logs, orchestrates trailing + timed closes.

### 3. Expert Advisor
- `CurtisWay_Executor.mq5` → attached to chart.
- Watches `CW/USDCAD/ORDER/REQ/*`.
- Places trades, acknowledges via `ORDER/ACK`.
- Logs to `orders.csv`.

### 4. Global Variables
- Use **F3** in MT5 to view.
- Categories:
  - **Heartbeat**: `CW/HB/<MODULE>`
  - **Signals**: `CW/<SYMBOL>/SIGNAL/...`
  - **Orders**: `CW/<SYMBOL>/ORDER/REQ/...`
  - **Risk**: `CW/<SYMBOL>/RISK/...`

### 5. Example Flow
1. **Signal** → detects setup, writes GV.  
2. **Risk Manager** → sizes lots, writes `ORDER/REQ`.  
3. **Executor** → places trade, writes `ORDER/ACK`.  
4. **Dashboard** → displays status + risk usage.  
5. **Watchdog** → confirms all modules alive.