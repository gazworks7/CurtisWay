# System Spec (system_spec_v0.1)

A modular trading framework inspired by *Way of the Turtle*, implemented in MQ5 as cooperating small programs.

## Modules
1. **Signal EAs (per setup)** — Donchian (S1 20/10, S2 55/20) initially; ZLR later. Signals only.
2. **Risk Manager (Service)** — Equity × Risk% + ATR → lot size; caps & sessions.
3. **Executor (Expert)** — Places/acknowledges orders; one position per symbol (v0.1).
4. **Steward (Expert)** — Trail to previous bar low/high; close-if-profit at 16:20 America/Toronto.
5. **News Guard (Service)** — Maintains no-trade window flag.
6. **Dashboard (Expert)** — Read-only status.
7. **Watchdog (Service)** — Heartbeats of modules; alerts if any stop.
8. **Includes (.mqh)** — Messages, State, Logging, Config, Testing.

## Messaging
- **Primary:** Global Variables of Terminal (GV). Namespace: `CW/<SYMBOL>/<TOPIC>/<ID>`
- **Secondary:** CSV logs in `MQL5/Files/CurtisWay/logs/`

### GV Cheat-Sheet
- `CW/<SYMBOL>/SIGNAL/<ID>` — signal payload
- `CW/<SYMBOL>/ORDER/REQ/<ID>` — risk-approved order request
- `CW/<SYMBOL>/ORDER/ACK/<ID>` — executor ack / error
- `CW/NEWS/LOCK` — 1=block trading
- `CW/RISK/CAP_REMAIN` — remaining daily risk fraction
- `CW/SESSION/ALLOW` — override for sessions
- `CW/HB/<MODULE>` — heartbeats (RISK, EXEC, SIGNAL/<symbol>, STEW/<symbol>)

## Safety Rails
- Daily risk cap at Risk Manager (e.g., 2%).
- One position per symbol (v0.1).
- Session & news windows respected.
- Dry-run switch for all modules.

## Logs
- `signals.csv`, `risk.csv`, `orders.csv`, `fills.csv`, `exceptions.csv` — UTC ISO timestamps, normalized prices, daily rotation optional.