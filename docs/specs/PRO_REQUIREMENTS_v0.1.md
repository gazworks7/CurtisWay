# Pro System Requirements & Hardening (v0.1)

## Non‑negotiables
- **Determinism**: Signals computed on completed bars by default; identical results across machines given identical data.
- **Separation of concerns**: Signal, Risk, Executor, Steward, News, Dashboard, Watchdog remain independent.
- **Fail‑safe defaults**: On any module error → no new orders. Existing positions remain protected by broker‑side SL.
- **Auditability**: Every decision is logged (UTC ISO timestamps, payload snapshots). Replays reproduce the exact path.
- **Idempotency**: Re‑emitting the same signal/order request cannot create duplicate positions.

## Quality Gates
1. Latency: Signal → Risk → Exec path < 250ms avg; retries bounded.
2. Spread & slippage guards: Executor respects `MaxSpreadPoints`; aborts after 3 attempts; logs reason.
3. Stop distance compliance: Auto‑clamp to broker min distance with explicit `SL_CLAMPED` log.
4. Position uniqueness: One position per symbol in v0.1 (Executor enforces).
5. Daily risk cap: Hard stop at Risk Manager (e.g., 2%); persists across restarts.
6. TZ correctness: Steward close‑time validated against broker time; offset sanity check on init.

## Testing & Acceptance (v0.1 → v0.3)
- **Unit-like (manual harness)**: `CW_Testing.mqh` feeds synthetic bars; verify Donchian windows, duplicate suppression, exit signals.
- **Integration path**: Fake `SIGNAL` GV → Risk lots → Exec dry‑run ACK → Steward trail.
- **Soak test (demo)**: 30 trading days on USDCAD D1 and M30, EURUSD D1. No manual overrides.
- **Corner cases**: min lot/step, exotic symbols, weekend gaps, DST transition day.

## Roadmap
- v0.1: Donchian S1/S2 signals, ATR sizing, single position per symbol, steward trailing, daily close-if-profit.
- v0.2: News Guard automation, session windows, equity curve on Dashboard.
- v0.3: Optional pyramiding (N-units) with strict risk expansion; stop-and-reverse exits.