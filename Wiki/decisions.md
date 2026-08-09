# Decisions — Phase-Shedding Converter

Living file. Locks, kills, open questions.

**Last updated:** 2026-08-09

---

## Locked

| Decision | Choice | Why |
|----------|--------|-----|
| Project type | Portfolio PE build (sim → HW → measured figures) for MS path | Not a product hunt |
| Application class | EV **auxiliary / dual LV rail** context — not OBC/traction | Keeps scope buildable |
| Hard deadline | Working prototype + docs by **31 Mar 2027** | Agent / STIRS path |
| Baseline starting point | Intern open-loop multiphase / NIBB-style work | Existing sims + loss scripts |
| Intern paper venue | IEEE **conference** format | Sim-only PoC; conference page budget |
| Intern paper template | [IEEE Conference Template](https://www.overleaf.com/latex/templates/ieee-conference-template/grfzhhncsfqn) | Official IEEEtran conference starter |
| Intern paper core claim (your sections) | Topology 2 + open-loop PS vs no-PS performance | Matches completed intern work |

## Draft only (not locked — challenge before BOM/PCB)

See [../Inputs/requirements/design-target-draft.md](../Inputs/requirements/design-target-draft.md):

| Axis | Draft |
|------|--------|
| Power class | ~200–300 W prototype |
| High side | 48 V nominal |
| Low side | 12 V and/or 24 V |
| Multiphase stage | 2-phase interleaved buck (Topology 2 baseline) + load-adaptive shedding |

## Open / not locked

- [ ] Final Vin/Vout/Iout + primary HW conversion direction
- [ ] Phase count N (2 vs more)
- [ ] Digital vs analog control / controller IC
- [ ] Switching frequency
- [ ] Closed-loop strategy with phase add/drop

## Killed / out of scope

- Full OBC / DCFC / traction inverter
- GaN + AI + wireless feature soup
- BOM/PCB before design target is challenged and locked

## Pointers

- Research gaps: [research-gap-stirs.md](research-gap-stirs.md)
- Optional papers: [extra-papers-wanted.md](extra-papers-wanted.md)
- Local paper catalog: [papers-catalog.md](papers-catalog.md)
- Intern baseline: [../Inputs/requirements/baseline-from-intern.md](../Inputs/requirements/baseline-from-intern.md)
