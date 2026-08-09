# Research gap analysis — STIRS Research Project (Annexure A)

**Date:** 2026-07-20  
**Scope:** Two-stage interleaved DC–DC for EV **auxiliary** loads with phase shedding; baseline = open-loop Topology 2 (2φ buck + shared boost).  
**Full narrative:** session analysis; this page is the project-of-record summary.

---

## Baseline (what exists)

- Open-loop two-stage NIBB-style sim (Topology 1 vs 2)
- Phase shedding only on the multiphase stage of each topology
- Monte Carlo / loss scripts
- **No** closed-loop PI on two-stage + shedding chain
- **No** hardware validation

See: [baseline-from-intern](../../Inputs/requirements/baseline-from-intern.md), [design-target-draft](../../Inputs/requirements/design-target-draft.md)

---

## State of the art (tight map)

| Theme | What literature covers | Gap relative to this project |
|-------|------------------------|------------------------------|
| Cascaded / shared-stage interleaved NIBB | Alajmi IEEE Access 2022 (exp.); Alajmi CPERE 2023 (OBC) | No dynamic phase shedding; not aux dual-mode η story |
| Two-stage cascaded interleaved bidirectional | Leal IEEE TIE 2024 | Closed-loop stages; **fixed** phase count; charging station scale |
| Composite EV DC–DC | Chen IEEE TPEL 2017 | Multi-stage efficiency idea; series composite ≠ parallel multiphase NIBB |
| Phase shedding + digital current control | Mao IEEE TCAS-II 2023 (rotating PS, HW) | Multiphase **buck**, not two-stage shared-stage aux |
| PS for ripple + η on EV chargers | Alharbi et al. | High-power interleaved **buck** charger modules |
| Multiphase bidirectional + PS for EV drive | IPRECON 2021 (Ramya/Das) | Sim BLDC/regen; not two-stage aux |
| Boost-mode phase shedding (recent) | Pilati IEEE TTE 2025 (stacked IB boost, FC, HW) | Boost-only, FC dynamics; not dual-mode aux |
| EV auxiliaries survey | Kotb Energies 2023 | Architecture survey; little on dynamic PS inside two-stage aux |

**Structural fact from baseline (not generic):** Topology 2 can shed in **buck** only; Topology 1 can shed in **boost** only. Shared-stage papers rarely address this asymmetry.

---

## Ranked gaps (STIRS relevance)

| Rank | Gap | Importance | Addressable by CL + HW + optional 4φ? |
|------|-----|------------|----------------------------------------|
| 1 | Closed-loop voltage + current share **co-designed** with dynamic PS on two-stage aux plant | Critical | Yes — core |
| 2 | Experimental validation (η, share, transient) of two-stage + adaptive PS | Critical | Yes — core |
| 3 | Boost-mode shedding DOF on shared-stage two-stage topologies | High, topology-unique | Partially now; fully with 4φ+2φ extension later |
| 4 | Thermal / current stress under shedding (shared stage hotspot + mismatch) | High | Yes if measurement plan includes share + thermal |
| 5 | Documented low-cost STM32 implementation of the above | Medium novelty, high STIRS value | Yes as enabler, not sole claim |

**Do not lead with:** “phase shedding improves light-load efficiency” or “interleaving reduces ripple” (settled).

---

## Novelty statements (for STIRS §11)

1. Integrated dual-loop control (voltage + inter-phase current share) with load-adaptive phase shedding on a **two-stage EV-auxiliary** converter, not open-loop duty maps alone.  
2. Quantified **open-loop vs closed-loop** phase-shedding performance (regulation, load-step, share error, η) on the same two-stage plant.  
3. Hardware-validated shared-stage thermal/current stress under shedding, including component mismatch effects.  
4. *(Optional stretch)* Dual multiphase two-stage layout (e.g. 4φ buck + 2φ boost) restoring shedding authority in **both** conversion directions.

---

## STIRS Annexure A mapping (skeleton)

| Section | Content source in this project |
|---------|--------------------------------|
| 5 Summary (~200 words) | Draft from novelty + baseline + outcome (HW + closed-loop PS) |
| 7 Objectives | `Inputs/requirements/design-target-draft.md` §7 |
| 9 Definition of problem | Gaps 1–3 above |
| 10 R&D status | This page + `sources/` |
| 11 Novelty | Four statements above |
| 13 Work plan | Closed-loop sim → STM32 → low-power PCB → measure |
| 14 Testing | η curves, share, load-step, PS vs no-PS, open- vs closed-loop |
| 19 References | `raw/papers/` + `raw/lit-review/References.docx` |

---

## Extra papers still useful (not yet in `raw/papers/`)

See [extra-papers-wanted](extra-papers-wanted.md).
