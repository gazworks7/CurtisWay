# Changelog — CurtisWay
All notable changes will be documented in this file.

## [0.1.0] — 2025-09-25
### Added
- Base specs for modular system (Signals, Risk Manager, Executor, Steward, News Guard, Dashboard, Watchdog).
- Donchian Signal spec (S1 20/10, S2 55/20).
- Pro hardening requirements (determinism, idempotency, audit logs, caps).

### Security
- Daily risk cap (2%) — documented in specs.

---

## Format
- **MAJOR.MINOR.PATCH**
- Increment MINOR for feature adds; PATCH for bug fixes.

## 2025-10-06
- Dashboard: three-line layout (Title/Server Time, Risk, Positions)
- Added Buy/Sell counts with lot totals
- “Server Time” label for clarity
- Printable Wiring Guide Rev 2 (D1 monitor, H4 execution)

### Changed
- **Dashboard (EA)**: UI refresh to three-line layout (Title/Server Time, Risk, Positions) — component **v1.0**.  
  No trading logic changed; visual only.  
  _Files:_ `MQL5/Experts/CurtisWay_Dashboard.mq5`

### Added
- Positions breakdown shown on chart: **Buy**/**Sell** counts with lot totals.

### Docs
- Printable **Wiring Guide Rev 2** (D1 monitor, H4 execution).

### Notes
- System version remains **[0.1.0]**; this is a UI-only enhancement to the Dashboard module.