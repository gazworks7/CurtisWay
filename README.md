# CurtisWay

CurtisWay is a modular MQL5 trading framework inspired by Curtis Faith's *Way of the Turtle*. It enforces mechanical rules through cooperating small programs (EAs + Services) instead of one large EA.

## Goals
- Remove discretion from execution.
- Automate ATR-based risk sizing.
- Ensure discipline via modules that cannot override each other.
- Log everything for analysis and proof of expectancy.

## Repo Layout
```
CurtisWay/
  README.md
  CHANGELOG.md
  docs/specs/
  mql5/Experts/CurtisWay/
  mql5/Services/CurtisWay/
  mql5/Include/CurtisWay/
  data/
```

## Modules
- **Signal (Expert)** — detects setups only (Donchian S1 20/10, S2 55/20; ZLR optional later).
- **Risk Manager (Service)** — converts risk% + ATR → lot size; enforces caps.
- **Executor (Expert)** — places orders mechanically.
- **Steward (Expert)** — manages open trades (trail to previous bar, close-if-profit at 16:20 America/Toronto).
- **News Guard (Service)** — enforces no-trade windows.
- **Dashboard (Expert)** — read-only status display.
- **Watchdog (Service)** — checks heartbeats of the other modules.

## Safety Rails
- Max daily risk % enforced by Risk Manager.
- One position per symbol (v0.1).
- Session and news windows respected (news optional v0.2).
- Dry-run testing switch.

## Specs
Specs live in `/docs/specs/` with version numbers (v0.1, v0.2 …).

## Logging
CSV logs in `MQL5/Files/CurtisWay/logs/`: `signals.csv`, `risk.csv`, `orders.csv`, `fills.csv`, `exceptions.csv`.

## Versioning
- **MAJOR.MINOR.PATCH**
- Minor = new features; Patch = fixes.