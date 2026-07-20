# Design target — DRAFT (challenge before lock)

**Status:** Draft only. Do not start BOM / PCB until this is challenged and locked in `design-target.md` (remove `-draft`).

**Date:** 2026-07-20  
**Basis:** Intern open-loop PoC + STIRS Research Project path (Annexure A)

---

## 1. Application rail (problem lock)

| Axis | Draft choice | Rationale |
|------|--------------|-----------|
| Vehicle role | **EV auxiliary / dual LV rail support** on intermediate bus | Matches Intern 12/24/48 V work; not OBC/traction |
| Power class | **~200–300 W** prototype | Matches existing sim Pin/Pout; bench-safe; STIRS-scale |
| Why multiphase + shedding | Light-load aux duty cycles waste switching energy if all phases always on | Portfolio story: efficiency vs load + control under phase add/drop |

**Out of scope (reaffirm):** full OBC, DCFC, traction inverter, GaN/AI feature soup.

---

## 2. Electrical target (draft numbers)

| Parameter | Draft | Notes |
|-----------|-------|--------|
| High side | **48 V** (nominal) | EV LV / mild hybrid style bus class |
| Low side rails | **12 V** and/or **24 V** | Aux loads; primary demo rail pick one for HW |
| Boost path | **24 V → 48 V** | Dual-mode demonstration |
| Rated power (proto) | **200–250 W** | Scale current for safe lab PCB |
| Prototype primary demo | **48 → 12 V or 48 → 24 V** with PS | Buck is where Topology 2 can shed |

*Lock one primary HW conversion for the first board (recommend **48→12 V or 48→24 V**) and keep the other modes in sim.*

---

## 3. Topology target

| Stage | Draft | Shedding |
|-------|-------|----------|
| Multiphase stage | **2-phase interleaved buck** (Topology 2 baseline) | Load-adaptive phase shed/add |
| Shared stage | **Shared boost** | No multi-phase shed on boost in baseline |
| Optional extension (after CL+HW) | **4-phase buck + 2-phase boost** | Restore shed authority in both modes |

**Default for STIRS year path:** stay on **2φ buck + shared boost** until closed-loop hardware works.

---

## 4. Control target

| Loop | Draft approach |
|------|----------------|
| Voltage | Outer PI/PID (digital) on Vout (and/or intermediate bus if needed) |
| Current share | Per-phase current sense + share loop or digital average-current style |
| Phase shedding | Load (or current) thresholds + **hysteresis + dwell**; re-interleave on N change |
| Implementation | **STM32** (HRTIM / timer PWM preferred for multiphase) |
| Modes | Buck primary on HW; boost path in sim (and HW if time) |

Open-loop PS remains the **baseline comparator**, not the deliverable.

---

## 5. Validation targets (must produce figures)

1. η vs load: **with vs without** phase shedding (closed-loop)  
2. Phase current balance (active phases) under mismatch  
3. Load-step + phase add/drop transient (Vout dip/overshoot)  
4. Optional: thermal map of always-on shared stage vs multiphase legs  

---

## 6. Still to challenge before lock

- [ ] Exact Vin range, Vout setpoint(s), Iout max  
- [ ] f_sw class (e.g. 50–200 kHz) and device tech (Si MOSFET default)  
- [ ] Single board voltage pair for HW  
- [ ] Current sensing method (shunt vs Hall)  
- [ ] Whether intermediate capacitor voltage is regulated or passive  
- [ ] Keep 4φ extension in proposal as **optional future** vs core objective  

---

## 7. Proposed STIRS objectives (measurable draft)

1. Design and simulate a two-stage multiphase DC–DC converter for EV-aux voltage class with **closed-loop voltage regulation and inter-phase current sharing**.  
2. Implement **dynamic phase shedding** integrated with the closed-loop controller; compare open-loop vs closed-loop shedding on regulation and efficiency.  
3. Build and test a **low-power hardware prototype** (STM32 digital control); report measured η, current share, and load-step response.  
4. *(Optional / stretch)* Analyze and (if time) simulate **multiphase boost extension** for boost-mode shedding flexibility.
