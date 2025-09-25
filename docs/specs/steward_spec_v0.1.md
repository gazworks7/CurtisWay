# Steward Spec (steward_spec_v0.1)

Module: `CurtisWay_Steward.mq5` (Expert)

- On new bar: LONG → SL = prior bar Low; SHORT → SL = prior bar High; clamp to broker stop distance.
- At 16:20 America/Toronto: if position profit > 0 → close; log event.
- Logs SL moves & time closes to `fills.csv`.