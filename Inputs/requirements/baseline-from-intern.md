# Baseline from Intern PoC (ingested 2026-07-20)

Source workspace (do not treat as project-of-record):  
`C:\Users\Bobby\Documents\Intern\`

This project now holds **copies** under `raw/`, `02-process/`, `03-outputs/sims/`.

---

## Topology comparison completed

| Name | Structure | Phase shedding authority |
|------|-----------|---------------------------|
| **Topology 1** | Shared buck + 2-phase interleaved boost | Boost mode only |
| **Topology 2** (preferred baseline) | **2-phase interleaved buck + shared boost** | **Buck mode only** |

Simulink masters (project copies):

- `03-outputs/sims/final-circuits/Two_Stage_NIBB_Shared_Boost_data.slx` — Topology 2 family
- `03-outputs/sims/final-circuits/Two_Stage_NIBB_Shared_Buck*.slx` — Topology 1 family

Development ladder (NIBB path models): `03-outputs/sims/nibb-development/`

---

## Operating points exercised (open-loop)

| Mode | Vin → Vout | Notes |
|------|------------|--------|
| Buck | 48 V → 12 V | Light-load η benefits from PS on Topology 2 |
| Buck | 48 V → 24 V | PS improves light-load η; open-loop regulation can overshoot at very light load without PS |
| Boost | 24 V → 48 V | PS only meaningful on Topology 1 (2φ boost) |

Power class from Pin/Pout tables in `02-process/efficiency/Final_efficiency.m`: roughly **~200–270 W** full-load class (not traction, not OBC).

Load sweep: 10–100% (or reverse-ordered plots at 100→10%).

---

## Control state (baseline)

| Item | Status |
|------|--------|
| Phase shedding | **Open-loop** load-based only |
| Voltage regulation | Open-loop duty maps (no outer PI/PID on two-stage chain) |
| Inter-phase current sharing | Not closed-loop active share |
| Hardware | None |
| Monte Carlo / loss scripts | Present under `02-process/` |

Early closed-loop experiments exist only on **single-stage** multiphase buck path models (`NIBB_TwoPhase_Buck_Closed_Loop.slx`), not the two-stage + shedding system.

---

## Efficiency scripts and figures

| Path | Content |
|------|---------|
| `02-process/efficiency/Data.m` | T1 vs T2 η comparison (boost + two buck rails) |
| `02-process/efficiency/Final_efficiency.m` | Topology 2 PS vs no-PS + Vout regulation plots |
| `02-process/losses/*.m` | Loss / ANN switching-loss exploration |
| `02-process/figures/` | Saved PNG plots |

---

## Literature already on disk

| Path | Content |
|------|---------|
| `raw/papers/01_…`–`10_…pdf` | Core IEEE/related PDFs from Intern lit review |
| `raw/lit-review/Literature_Review_with_gaps.xlsx` | Per-paper summary + **your** gap column |
| `raw/lit-review/References.docx` | Citation list (partial DOIs) |
| `raw/Format - … STIRS-2026.docx` | Official proposal format (Annexure A = Research Project) |

---

## STIRS category intent (default)

**Research Project → Annexure A** (not product-first Annexure B), aligned with `AGENTS.md` portfolio PE build: sim + closed-loop + hardware + measured results.
