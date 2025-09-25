# Risk Spec (risk_spec_v0.1)

Module: `CurtisWay_Risk_Manager.mq5` (Service)

## Inputs
- Equity; Risk % (0.5/1/2); ATR(14); pip value
- Caps: daily risk (2%), per-symbol exposure
- Session hours

## Calculations
1. Risk$ = Equity × Risk%
2. SL pips = ATR(14) × multiplier (default 1) or from signal SL distance
3. Lot size ≈ (Risk$ / (SL_pips × $/pip)) adjusted to broker min/step/max

## Output (GV + CSV)
```
{
  "v":1,
  "symbol":"USDCAD",
  "dir":"LONG",
  "lots":0.11,
  "sl":1.38900,
  "tag":"DON_S1_v0.1",
  "risk_pct":0.01,
  "risk_usd":5.00,
  "sl_pips":36
}
```

## Blocks
- Daily risk cap hit, news lock=1, outside session.