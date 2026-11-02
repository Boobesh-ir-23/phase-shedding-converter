# Phase-shedding converter

Internship at **Shrimitha Energy Solutions**, 25 May 2026 to 25 June 2026.
College guide: Dr. R. Seyezhai, Department of EEE, SSN College of Engineering.

Simulink study of a two-stage non-inverting buck-boost for 12 V, 24 V and 48 V auxiliary rails, in the 200–270 W class. Two plants:

1. **Topology 1** — shared buck, two-phase boost. Phase shedding only in boost.
2. **Topology 2** — two-phase interleaved buck, shared boost. Phase shedding only in buck.

Topology 2 is the one I carried forward. Shedding is open-loop and based on load percent. Both phases stay on at high load. One phase drops off at light load, which is where the efficiency moves. There is no hardware here. `NIBB_TwoPhase_Buck_Closed_Loop.slx` is an early trial on the buck stage alone, not closed-loop control of the two-stage converter.

The STIRS 2026 proposal (July) and the slides (August) came after the internship. That proposal is with Deepalakshmi M, same guide.

## What is where

- `Outputs/deliverables/sims/learning/` — first buck, boost and interleaving models, plus the early ripple plots
- `Outputs/deliverables/sims/nibb-development/` — the model ladder up to the two-stage plant
- `Outputs/deliverables/sims/final-circuits/` — Topology 1 and Topology 2, with and without shedding
- `Outputs/process/efficiency/` — efficiency scripts (`Data.m` compares the two topologies, `Final_efficiency.m` is Topology 2 with shedding vs without)
- `Outputs/process/losses/` — loss scripts
- `Outputs/process/figures/` — June plots
- `Inputs/raw/graphs/` — scope screenshots from the later runs
- `Inputs/raw/Final_INTERN.pdf` — efficiency tables
- `Inputs/raw/lit-review/` — my notes on the papers. The PDFs are not in this repo.
- `Inputs/raw/Proposal.pdf` and `Outputs/deliverables/STIRS-2026_Proposal_Phase_Shedding_Converter_DRAFT.docx` — STIRS proposal
- `Outputs/deliverables/ppt/STIRS_2026_PhaseShedding_12.pptx` — slides
- `Wiki/` — decisions, literature list, research gap
- `Inputs/requirements/` — what the internship sim actually was, and the design target for the work after it

## Runs I actually took

| Mode | Conversion | Shedding |
|------|------------|----------|
| Boost | 24 V → 48 V | Topology 1 |
| Buck | 48 V → 24 V | Topology 2 |
| Buck | 48 V → 12 V | Topology 2 |

Open the `.slx` files in Simulink. The `.m` files are plain MATLAB scripts and they already contain the Pin/Pout numbers used for the plots.

Commit dates follow the save times of the files. I was not using git during the internship.
