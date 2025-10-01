# Logs Schema (v0.1)

## signals.csv
- **ts** — UTC ISO timestamp of signal
- **symbol** — instrument traded (e.g., USDCAD)
- **tf** — timeframe (e.g., H4, D1)
- **setup** — name of setup (DONCHIAN, ZLR, etc.)
- **entryPeriod** — breakout lookback period
- **exitPeriod** — exit lookback period
- **dir** — LONG or SHORT
- **HH_N** — highest high (entry lookback)
- **LL_N** — lowest low (entry lookback)
- **C1** — signal close price

---

## risk.csv
- **ts** — timestamp
- **symbol** — instrument
- **dir** — LONG or SHORT
- **lots** — computed lot size
- **sl** — stop loss price
- **risk_pct** — % of equity risked
- **risk_usd** — dollar risked
- **sl_pips** — stop distance in pips
- **tag** — strategy tag (e.g., DON_S1_v0.1)

---

## orders.csv
- **ts** — timestamp
- **symbol** — instrument
- **dir** — LONG or SHORT
- **lots** — order volume
- **price** — entry price
- **sl** — stop loss
- **tag** — setup tag
- **ticket** — MT5 ticket number
- **status** — FILLED / REJECTED / ERROR
- **magic** — EA magic number

---

## fills.csv
- **ts** — timestamp
- **symbol** — instrument
- **event** — TRAIL / CLOSE / EXIT
- **dir** — LONG or SHORT
- **price** — execution price
- **sl_before** — SL before adjustment
- **sl_after** — SL after adjustment
- **pnl_open** — profit/loss at event
- **magic** — EA magic number

---

## exceptions.csv
- **ts** — timestamp
- **module** — module name (SIGNAL, RISK, EXEC, STEW)
- **stage** — stage of failure (INIT, ORDER, ACK, etc.)
- **code** — error code
- **reason** — human-readable error message
- **payload** — JSON payload that triggered error