# Executor Spec (executor_spec_v0.1)

Module: `CurtisWay_Executor.mq5` (Expert)

- Consumes `ORDER/REQ` GV; validates; places market orders via `CTrade` with SL only.
- Publishes `ORDER/ACK` GV; logs to `orders.csv`; errors to `exceptions.csv`.
- One position per symbol enforced; stale request guard (default 10s).