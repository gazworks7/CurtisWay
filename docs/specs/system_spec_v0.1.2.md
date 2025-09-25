# CurtisWay — v0.1.2 Spec (DRAFT)
**Goal:** Small quality bump after v0.1.1 baseline.

## Scope
- [ ] Uniform CSV logging fields across all modules
- [ ] Example `CW_Config.mqh` defaults + comments
- [ ] Compile warnings = 0 (all modules)
- [ ] README quick-start for MT5 install

## Changes by module
### Executor
- [ ] Guard: no duplicate orders per signal tick
- [ ] Log: entry/exit reason, ticket, SL/TP, risk

### Risk Manager
- [ ] Enforce: per-trade risk %, daily loss cap
- [ ] Log: risk calc inputs/outputs

### Dashboard
- [ ] Show: loaded modules, last log line, error badge

### Watchdog / News Guard
- [ ] Watchdog: hang detection stub
- [ ] News Guard: quiet windows from config

## Config (`CW_Config.mqh`)
- [ ] Defaults: RiskPercent, Symbols, MagicBase, LogPath
- [ ] Comment every key

## Tests
- [ ] All compile in MT5 (no warnings)
- [ ] Dry-run load/unload each EA/Service
- [ ] Logs match `logs_schema.md`

## Out of scope
- Strategy changes (signals) — later release
