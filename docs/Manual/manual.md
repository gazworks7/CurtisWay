# CurtisWay Trading Framework Manual (v0.1)

---

## 1. Overview
CurtisWay is a modular MQL5 trading framework inspired by Curtis Faith’s *Way of the Turtle*.  
It enforces mechanical rules through cooperating small programs (EAs + Services) instead of one large EA.

### Goals
- Remove discretion from execution.  
- Automate ATR-based risk sizing.  
- Ensure discipline via modules that cannot override each other.  
- Log everything for analysis and proof of expectancy.  

---

## 2. System Architecture
Modules (each independent):
1. **Signal (EA)** — detects setups only (Donchian, ZLR optional later).  
2. **Risk Manager (Service)** — converts risk% + ATR → lot size; enforces caps.  
3. **Executor (EA)** — places orders mechanically.  
4. **Steward (Service)** — manages open trades (trails stops, closes if profit at 16:20 Toronto).  
5. **News Guard (Service)** — enforces no-trade windows.  
6. **Dashboard (EA)** — read-only status display.  
7. **Watchdog (Service)** — monitors other modules’ heartbeats.  

**Messaging:**  
- Global Variables of Terminal (GVs) = message bus.  
- CSV logs in `MQL5/Files/CurtisWay/logs/` for audit trail.  

---

## 3. Setup Guide (Wiring)

### Quick Setup
- Open one **H4 chart USDCAD** → attach `CurtisWay_Signal_Donchian.mq5`.  
- Open a second **H4 chart** → attach `CurtisWay_Executor.mq5`.  
- Optional: Dashboard chart.  
- Run Services (Risk Manager, Steward, News Guard, Watchdog) from MT5’s *Services tab*.  

### Global Variables
- **Signals** → `CW/<SYMBOL>/SIGNAL/...`  
- **Orders** → `CW/<SYMBOL>/ORDER/...`  
- **Heartbeat** → `CW/HB/...`  
- **Risk** → `CW/<SYMBOL>/RISK/...`  

### Example Flow
1. Signal → detects setup → writes GV.  
2. Risk Manager → sizes lots → writes ORDER/REQ.  
3. Executor → places order → writes ACK.  
4. Dashboard → shows status & risk usage.  
5. Watchdog → confirms all alive.  

---

## 4. Module Specs

### 4.1 Signal — Donchian Breakout
- Entry: break of 20 or 55 bar high/low.  
- Exit (informational): 10 or 20 bar reversal.  
- Confirms on bar close.  
- Outputs GV + logs.  

### 4.2 Signal — ZLR (optional, later)
- Based on CCI(14), thresholds ±50/±100.  
- Requires ≥6 bars above/below zero line.  
- Bounce with angle ≥15–20 points.  
- Outputs GV only.  

### 4.3 Risk Manager
- Inputs: Equity × Risk%, ATR(14).  
- Daily cap: default 2% equity.  
- Lot = Risk$ ÷ (ATR pips × $/pip).  
- Blocks if cap exceeded, session closed, or news lock.  

### 4.4 Executor
- Listens for ORDER/REQ GV.  
- Places trade with `CTrade`, SL only.  
- One position per symbol enforced.  
- Publishes ORDER/ACK.  
- Logs to `orders.csv`.  

### 4.5 Steward
- On new bar:  
  - LONG → SL = prior bar low.  
  - SHORT → SL = prior bar high.  
- At 16:20 Toronto: if profit > 0 → close trade.  
- Logs to `fills.csv`.  

### 4.6 News Guard
- Blocks trading during defined news windows.  
- Sets `CW/NEWS/LOCK=1` to disable.  

### 4.7 Dashboard
- Displays read-only overlay of status and risk usage.  

### 4.8 Watchdog
- Monitors heartbeats of all modules.  
- Logs if any fail to update.  

---

## 5. Safety Rails
- Determinism: Signals on completed bars only.  
- One position per symbol (v0.1).  
- Daily risk cap (2%).  
- Auto-clamp to broker stop distance.  
- Fail-safe: on error, no new orders; existing SL remains.  
- Full audit logs (UTC timestamps, payloads).  

---

## 6. Logs Schema

### signals.csv
`ts, symbol, tf, setup, entryPeriod, exitPeriod, dir, HH_N, LL_N, C1`

### risk.csv
`ts, symbol, dir, lots, sl, risk_pct, risk_usd, sl_pips, tag`

### orders.csv
`ts, symbol, dir, lots, price, sl, tag, ticket, status, magic`

### fills.csv
`ts, symbol, event, dir, price, sl_before, sl_after, pnl_open, magic`

### exceptions.csv
`ts, module, stage, code, reason, payload`

---

## 7. Versioning
- **MAJOR.MINOR.PATCH**  
- Minor = new features; Patch = fixes.  
- Current version: **0.1.0 (2025-09-25)**  

---

## 8. Changelog (excerpt)

### [0.1.0] — 2025-09-25
- Base specs for modular system (Signals, Risk Manager, Executor, Steward, News Guard, Dashboard, Watchdog).  
- Donchian Signal spec (S1 20/10, S2 55/20).  
- Pro hardening requirements documented.  

---

# End of Manual