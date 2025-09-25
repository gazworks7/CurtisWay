# Contributing to CurtisWay

Thanks for helping improve the CurtisWay system!  
This project uses **MAJOR.MINOR.PATCH** versioning:

- **MAJOR**: breaking changes or new modules
- **MINOR**: new features in existing modules
- **PATCH**: bug fixes, clarifications

## Workflow
1. Create/update files locally (Experts, Services, Includes, or Specs).
2. Update `CHANGELOG.md` with a new entry under the correct version.
3. Use clear commit messages:
   - `Add: Donchian Signal v0.2 logic`
   - `Fix: Executor stale request guard`
   - `Docs: update risk_spec clarifications`
4. Push changes to GitHub.

## Notes
- Never bypass logging — every decision must have a trace.
- Keep modules independent: Signal ≠ Risk ≠ Executor.
- Specs live in `docs/specs/` and should always be updated first before coding changes.
