# 13 — Design Evolution Log

> **Status:** Living document — updated as design changes  
> **Date:** 2026-06-25  
> **Author:** AeroCool Engineering

---

## Purpose of This Document

This is the **design decision log** for AeroCool V1. Every time the CAD geometry, specs, or architecture changes, this document records:

1. **What changed** (the new design)
2. **What preceded it** (the old design)
3. **Why it changed** (the trigger — physics, test data, printability, or new insight)
4. **What we learned** (the insight that drove the change)
5. **What was abandoned** (and why it won't come back)

**This document exists because open hardware projects without decision logs become impossible to follow.** Someone finding this repo in six months needs to understand not just the current state, but how we got here and why dead ends stayed dead.

---

## V0: The Initial Concept (Pre-Repository)

**What it was:** A 3D-printed passive cooling window insert using the Venturi effect to create adiabatic cooling, with evaporative water channels and a tower version for stack effect.

**Key assumptions:**
- Multi-stage Venturi funnels produce cumulative temperature drops (6 stages × 2°C = 12°C total)
- A 2.5mm throat maximizes velocity and cooling
- Water sits in an expansion chamber and passively evaporates
- The tower's 6 stacked stages each add cooling independently

**Why it was abandoned:** The assumptions were tested against physics and found to be incorrect before any printing occurred. The pre-repository analysis (the concept board and early math) revealed that adiabatic cooling in a Venturi is temporary — it recovers in the expansion zone. The core mechanism was misunderstood.

**What we learned:** The Venturi effect is real, but its value is suction (pressure drop), not temperature drop. The temperature drop at the throat is a transient, not a cumulative, phenomenon.

**Status:** Superseded. Only the concept board images remain as historical artifacts.

---

## V1: First Prototype CAD (First Commit)

**What changed:**
- Generated the first STL files: `aerocool_flat_tile_v1.stl` and `throat_test_v1.stl`
- 2.5mm throat, 28mm tile thickness (to fit the 24° funnel geometry)
- Chamber depth: 5mm
- Water system: passive chamber evaporation (water fills the chamber, air flows over it)
- 7 funnels per tile in a hex pattern

**What preceded it:** V0 concept.

**Why it changed:** We needed printable geometry to test the core assumptions. The first step was a single complete tile to validate the Venturi geometry, chamber design, and printability.

**What we learned:**
- The 2.5mm throat is only 6.25 nozzle widths on a 0.4mm nozzle. PETG oozes and blobs in small cavities. Print quality would be poor.
- The 28mm tile thickness was a compromise to fit the 15°→24° funnel geometry, but it was arbitrary.
- The chamber evaporation concept was untested and likely insufficient.

**What was abandoned:** Nothing yet — this was the first printed geometry. But the 2.5mm throat and passive chamber evaporation were already flagged as risks.

**Status:** Superseded. Files remain for historical reference.

---

## V2: The Atomization Pivot

**Trigger:** Document 09 — "Venturi Analysis: Making It Do Real Work"

**What changed:**
- Throat increased from **2.5mm to 4mm**
- Tile thickness reduced from **28mm to 25mm** (the 4mm throat fits cleanly at 24° in 25mm)
- Water system changed from **passive chamber evaporation** to **Venturi-aspirated atomization**
- A **1.5mm water injection channel** was added to the throat test, intersecting the throat at 90°
- The Venturi was reframed as a **zero-power pump**, not a cooler

**What preceded it:** V1 geometry with the physics assumptions of V0.

**Why it changed:**
The physics analysis (Doc 09) revealed that:
1. The adiabatic temperature drop at the Venturi throat is **recovered** in the expansion zone — it does not accumulate across stages.
2. The **pressure drop** at the throat is substantial (614 Pa at 25% efficiency, 2,458 Pa at 50% efficiency).
3. This pressure drop is enough to **draw water upward** from a reservoir (63mm at 25% efficiency, 250mm at 50% efficiency).
4. Atomized water droplets have **3–5× more surface area** than a passive wet surface, dramatically improving evaporative cooling.

The insight: **The Venturi is not a cooling engine. It is a cooling facilitator — a zero-power pump that atomizes water into the airstream.**

**What we learned:**
- The 4mm throat is **10 nozzle widths** — much more printable than 2.5mm.
- The 25mm tile thickness is cleaner geometry (no awkward compromises).
- The atomization concept is theoretically sound but **requires empirical validation** — will the throat actually draw water in a printed part?
- The throat test V2 was designed to answer this question directly.

**What was abandoned:**
- **Multi-stage adiabatic stacking:** The 6-stage tower was originally conceived as stacking 6 adiabatic drops. This was abandoned because adiabatic drops do not accumulate. The tower was reimagined as a multi-stage evaporative chimney.
- **2.5mm throat:** Abandoned for printability. The 4mm throat provides 2.6× more airflow and is much easier to print cleanly.
- **Passive chamber evaporation:** Abandoned as the primary mechanism. Atomization is theoretically 3–5× more effective.

**Status:** Superseded as the primary prototype, but the atomization concept remains validated and may be incorporated into the Tower design or future variants. The `throat_test_v2.stl` is still the correct test for validating atomization physics.

---

## V3: The Baffle Cascade (Current)

**Trigger:** The conversation about water retention on hydrophobic PETG surfaces.

**What changed:**
- The **atomization channel** was removed from the Flat model.
- The water system changed from **throat-aspirated atomization** to a **baffle cascade with fuzzy-skin fins**.
- The chamber is no longer a reservoir for atomization — it now holds a **drop-in baffle insert**.
- The baffle insert is a **separate printed part** with:
  - 3 angled fins (20° to airflow, 1.5mm thick, 3mm tall, 55mm long)
  - Fuzzy skin texture enabled in the slicer
  - Layer lines oriented **cross-flow** to the air direction (printed flat on the bed)
- The base tile chamber was resized to **79mm** (1mm clearance) to accept the insert.

**What preceded it:** V2 geometry with the atomization channel.

**Why it changed:**
1. **Atomization is hard to validate.** The throat test V2 requires holding a water source against a small channel while blowing air through a funnel. It is a fiddly test that might fail for reasons unrelated to the physics (channel alignment, seal quality, air turbulence).

2. **PETG is hydrophobic.** Water on smooth PETG beads up and rolls off. The atomization concept assumes water stays in the chamber until drawn into the throat. If the chamber walls are hydrophobic, water may not distribute evenly.

3. **Fuzzy skin is a single slicer setting.** It requires no design change, no extra parts, no post-processing. It creates a chaotic texture that mechanically traps water droplets through microscopic undercuts.

4. **Baffle cascades are proven technology.** Mist eliminators, chevron separators, and airfoil catchment surfaces are standard industrial practice. The physics is well-understood: water droplets have more inertia than air, so they impact surfaces that air flows around.

5. **The baffle approach is more testable.** You can see the water on the fins. You can feel whether the air is moist. You can measure the temperature drop with a simple thermocouple. The atomization test requires more complex setup.

6. **The insert is replaceable.** If the fins get clogged, mineral-caked, or algae-covered, the user swaps a $5–8 insert instead of replacing the entire tile. This aligns with the repairable, modular ethos.

**What we learned:**
- **Simpler is better for the first test.** The baffle cascade is less elegant than atomization but more printable, more testable, and more reliable.
- **FDM roughness is a feature, not a bug.** The layer lines, fuzzy skin, and print orientation can all be designed to serve the water retention function.
- **Separate parts allow separate optimizations.** The base tile (smooth channels, vertical layer lines) and the baffle insert (rough fins, cross-flow layer lines) cannot be optimized simultaneously in a single print. Modularity is a functional requirement, not just a repairability feature.
- **Seasoning is real.** Mineral deposits from hard tap water will improve the fin surfaces over time. The system gets better with use.

**What was abandoned:**
- **Atomization as the Flat model's primary mechanism:** The throat test V2 is still valid and should be printed to validate the physics, but the baffle cascade is the simpler, more reliable approach for the first commercial Flat design. Atomization may be revisited for the Tower model or a future high-performance variant.
- **The water injection channel:** The 1.5mm bore intersecting the throat in the throat test V2 is a test feature, not a production feature. It was never incorporated into the full tile design.
- **The chamber as a water reservoir:** In V2, the chamber held water for atomization. In V3, the chamber holds the baffle insert. Water is applied directly to the fins (spray or pour), not held in a reservoir.

**Status:** **Current design.** The V3 files (`aerocool_flat_tile_v3.stl`, `baffle_insert_v3.stl`) are the active prototype.

---

## Why the Tower Design Hasn't Changed (Yet)

The Tower model (Doc 11, Section "AeroCool Tower") has remained conceptually stable through all three pivots because:

1. **It was never based on multi-stage adiabatic cooling.** The tower's 6 stages were always described as "evaporation contact zones" in the design philosophy, even if the physics doc (01) originally described them as Venturi stages. The reframing in Doc 09 confirmed what the tower design was already doing.

2. **The stack effect is independent of the Venturi mechanism.** The tower's no-wind backup (chimney draft) works regardless of whether the Venturi atomizes water or the fins evaporate it. The tower has a larger interior volume that can accommodate either approach.

3. **The overflow reservoir system is gravity-fed.** It does not depend on Venturi suction. Water flows down through overflow notches regardless of the airflow mechanism.

**What may change for the Tower:**
- If atomization is validated by the throat test V2, the Tower may incorporate Venturi-aspirated water injection at the top stage, with overflow notches distributing water downward.
- If the baffle cascade performs well in the Flat model, the Tower may use a similar fin-based approach in each stage.
- The Tower is waiting for Flat test data before committing to a specific evaporative mechanism.

---

## The Meta-Pattern: What Each Pivot Teaches Us

| Pivot | Trigger | Lesson |
|-------|---------|--------|
| V0 → V1 | Need to print something | You can't test physics without geometry. The first print is always a leap. |
| V1 → V2 | Physics analysis (Doc 09) | The core mechanism was misunderstood. Honest math is cheaper than failed prints. |
| V2 → V3 | Material reality (PETG hydrophobicity) | The slicer and the material are part of the design space, not constraints to overcome. |
| (Future) | Flat test data | The Tower will inherit the best mechanism from the Flat tests. |

**The consistent pattern:** Each pivot simplifies the design while making it more testable. V0 was ambitious but unproven. V1 was printable but risky. V2 was theoretically powerful but empirically fragile. V3 is the simplest design that can produce a measurable result.

---

## Abandoned Ideas and Why They Stay Dead

### 1. Multi-Stage Adiabatic Cooling

**What it was:** Stacking 6 Venturi stages, each producing a 2°C adiabatic drop, for a cumulative 12°C cooling.

**Why it was abandoned:** The adiabatic temperature drop at the Venturi throat is recovered in the expansion zone. The air exits the Venturi at approximately the same temperature it entered. Cascading stages does not produce cumulative cooling.

**Why it stays dead:** This is fundamental thermodynamics. The only way to get cumulative cooling from a Venturi is to extract work from the pressure drop (e.g., atomizing water), not to rely on the temperature drop itself.

### 2. 2.5mm Throat

**What it was:** A 2.5mm throat diameter for maximum velocity and area ratio (36:1).

**Why it was abandoned:** Only 6.25 nozzle widths on a 0.4mm nozzle. PETG oozes, strings, and produces poor surface finish in small cavities. The throat would be rough, oval, or partially clogged.

**Why it stays dead:** The 4mm throat provides 2.6× more airflow and is 10 nozzle widths — much more printable. The slight velocity reduction is more than offset by the improved flow and reliability.

### 3. 28mm Tile Thickness

**What it was:** A 28mm tile to fit the 2.5mm throat at a 24° cone angle.

**Why it was abandoned:** The 4mm throat fits cleanly in 25mm at 24°. The extra 3mm was unnecessary material and print time.

**Why it stays dead:** 25mm is the natural thickness for the 4mm throat geometry. It is also a cleaner number for marketing ("1 inch thick").

### 4. Passive Chamber Evaporation (as primary mechanism)

**What it was:** Water fills the expansion chamber, and air flows over the wet surface to evaporate it.

**Why it was abandoned:** Surface evaporation is limited by surface area. A 5mm deep chamber has minimal surface area relative to the air volume. The cooling effect would be negligible.

**Why it stays dead:** Atomization (V2) and baffle fins (V3) both provide orders of magnitude more surface area than a flat chamber surface. Chamber evaporation might exist as a secondary effect but cannot be the primary mechanism.

### 5. Monolithic Single-Print Design

**What it was:** Printing the entire tile — funnels, chamber, fins, everything — in one piece.

**Why it was abandoned:** FDM layer-line orientation is global. A single print cannot have smooth channel walls (vertical layer lines) and rough fin surfaces (cross-flow layer lines) simultaneously.

**Why it stays dead:** The two-surface problem is fundamental to FDM. Until multi-material or multi-axis printing becomes standard, the solution is separate parts with optimal orientations.

---

## Current Decision Map

```
V3 Flat Model (active test):
├── Base tile: 7 funnels, 4mm throat, smooth channels
├── Baffle insert: 3 fins, fuzzy skin, cross-flow layer lines
├── Water: applied directly to fins (spray/pour)
├── Mechanism: surface evaporation on rough fins
└── Next: vibe test, then instrumented test

V2 Throat Test (still valid):
├── Single funnel, 4mm throat, 1.5mm water channel
├── Purpose: validate Venturi suction/atomization physics
└── Next: blow air, observe water aspiration

V1 Files (historical):
├── 2.5mm throat, 28mm tile
└── Status: superseded, do not print

Tower Model (pending Flat test data):
├── 6-stage gravity-fed overflow system
├── Stack effect for no-wind ventilation
├── Evaporative mechanism: TBD (fins or atomization)
└── Next: commit after Flat test results
```

---

## How to Use This Document

**If you are a new contributor:** Read this first. It tells you why the current design looks the way it does and what dead ends were explored.

**If you are proposing a change:** Reference this document. Explain why your proposal is better than the current approach and why it doesn't repeat an abandoned idea.

**If you are writing about the project:** This document provides the narrative arc. The story is not "we had a perfect idea and executed it." The story is "we tested our assumptions, found them wrong, and adapted."

**If you are testing a prototype:** The validation plan in Doc 11 and the test notes in Doc 12 are your guides. This document tells you why those tests matter.

---

*This document is updated whenever the design changes. If you are reading a version that does not match the current CAD files, check the git log for the most recent update.*

*Current as of: V3 baffle cascade (2026-06-25)*
