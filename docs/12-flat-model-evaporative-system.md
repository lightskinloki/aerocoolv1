# 12 — Flat Model: Evaporative System Architecture

> **Status:** Design development (untested)  
> **Date:** 2026-06-23  
> **Author:** AeroCool Engineering

---

## The Problem

The Flat model is 25mm thick. It cannot contain a large water reservoir, a complex pump mechanism, or tall wicking structures. Water must be retained and evaporated within a thin, horizontal space where air flows at moderate-to-high velocity.

The PETG material is hydrophobic. Water beads up rather than spreading. Airflow wants to strip those beads away. The challenge is not "how do we move water?" — it is "how do we keep water on the surface long enough to evaporate, without choking the airflow?"

**The solution is a baffle cascade: water moves downstream through a series of aerodynamic catchment surfaces, evaporating at each stage, while air flows smoothly around them.**

---

## Core Design Principles

### 1. Let Water Move, Then Catch It

Instead of trying to anchor water in place against airflow, the design accepts that water will be stripped. It then catches the stripped droplets on a downstream surface. This repeats through a cascade of baffles. Some water evaporates at each stage. What remains reaches the end and drips back into a small collection trough.

This is the same principle as mist eliminators in industrial scrubbers and chevron separators in HVAC systems — but scaled to a 25mm window insert and printed in PETG.

### 2. Airfoils, Not Walls

Baffles are not perpendicular walls. They are airfoil-shaped surfaces with catchment pockets on the pressure side. Air flows around the curved leading edge with minimal separation. Water droplets, with higher inertia, cannot follow the curve and impact the pocket.

**Design rules:**
- Leading edge: curved, facing airflow, smooth surface
- Trailing edge: step or pocket where droplets impact
- Angle to flow: 15–30° (not 90°)
- Spacing: enough for airflow recovery between baffles, not so much that droplets re-accelerate and escape

### 3. FDM Roughness as a Functional Surface

PETG's hydrophobicity is a limitation, but FDM's layer-line texture is an advantage. The design intentionally uses the print process to create water-retaining surfaces.

**Fuzzy skin** (a slicer setting that applies random z-offset noise to outer walls) creates microscopic undercuts and pockets where surface tension can hold water even when the base material repels it. On thin fins, this is the primary retention mechanism.

**Layer-line orientation** is part of the design:
- Airflow channels: layer lines aligned with airflow → smooth, low drag
- Evaporative fins: layer lines cross-flow → rough, water-retaining

Because fins and channels are **separate printed parts**, each can be oriented optimally on the build plate. This is not a workaround — it is a functional requirement of the architecture.

### 4. Progressive Seasoning

Fresh PETG holds water poorly. Over time, dissolved minerals from hard tap water deposit on the fin and baffle surfaces. These deposits:
- Increase surface energy (better wetting)
- Fill layer-line valleys (more capillary retention)
- Create a composite surface that retains water better than raw PETG alone

**The "seasoning curve":**
- Days 1–3: Low efficiency — water beads and strips easily
- Days 7–14: Medium efficiency — mineral deposits begin to hold water
- Days 21–30: Peak efficiency — seasoned surface reaches optimal retention
- Months 6–12: Plateau or decline — excessive buildup may flake or clog

This is an emergent property, not a bug. The system gets better with use. Eventually, fins may need replacement — this is why they are designed as modular, snap-in parts.

**For users with soft water:** Initial efficiency will remain low. The design includes a recommendation to "prime" the fins with a hard-water rinse or a dilute calcium carbonate solution to jumpstart the seasoning process.

---

## The Baffle Cascade

### How It Works

```
Outside Air → [Venturi Funnel] → [Expansion Chamber] → [Baffle 1] → [Baffle 2] → [Baffle 3] → Room
                                                      ↓              ↓              ↓
                                                Water droplets impact, evaporate, drain
```

1. **Air exits the Venturi funnel** at high velocity into the expansion chamber
2. **Water is present on the expansion chamber surfaces** (from prior wetting, or from a shallow initial tray)
3. **Airflow strips water droplets** from the surfaces
4. **Droplets travel downstream** and impact the first baffle
5. **Some evaporate on the baffle surface** — latent heat cools the air passing over it
6. **Remaining water drains to the next baffle** or drips into a collection trough
7. **Air continues around the baffles** with minimal pressure drop

### Baffle Geometry

**Airfoil profile:**
- Leading edge radius: 2–3mm (rounded, facing flow)
- Chord length: 15–20mm
- Thickness: 1–2mm
- Trailing edge: small step or pocket (0.5–1mm deep, 2–3mm wide) for droplet catchment
- Angle to horizontal airflow: 15–30° (upward into flow)

**Why this angle matters:**
- Too steep (>45°): blocks airflow, creates turbulence, reduces Venturi efficiency
- Too shallow (<10°): water slides off rather than pooling, droplets skip over
- 15–30°: water is pressed against the surface by airflow, but the surface is gentle enough that air follows the contour

**S-curve alternative:**
For users who prefer a single printed insert rather than individual fins, an S-curve baffle with a catchment pocket on the inner radius of each bend achieves the same separation. Air follows the smooth curve. Water cannot make the turn and hits the pocket. This is printable as a single corrugated sheet that snaps into the expansion chamber.

### Baffle Spacing

| Spacing | Airflow Recovery | Water Stripping Risk | Notes |
|---------|-----------------|----------------------|-------|
| 5mm | Minimal | Low | Tight, high pressure drop |
| 10mm | Good | Medium | Balanced |
| 15mm | Full | High | Loose, may let droplets escape |

**Recommended: 10mm center-to-center spacing.** This gives the boundary layer enough distance to reattach after each baffle while maintaining tight enough spacing that stripped droplets impact the next surface before re-accelerating.

### Number of Baffle Stages

| Stages | Total Chamber Depth | Evaporation Surface | Notes |
|--------|--------------------|---------------------|-------|
| 2 | 10mm + frame | 2 catchment surfaces | Minimal cooling |
| 3 | 15mm + frame | 3 catchment surfaces | Target for Flat model |
| 4 | 20mm + frame | 4 catchment surfaces | Aggressive, may choke flow |

**Recommended: 3 baffle stages in the 5mm expansion chamber.** This is tight. The baffles are thin (1mm) and angled, so the effective air path is larger than the raw spacing suggests. The three surfaces provide enough cumulative evaporation to produce a meaningful temperature drop.

---

## The Fuzzy Skin Strategy

### What It Is

Fuzzy skin is a slicer setting (available in Cura, PrusaSlicer, and others) that applies a random z-offset to the outer wall of a print. The result is a chaotic, velcro-like texture of tiny hairs and undercuts.

### Why It Helps

On a smooth hydrophobic surface, water forms beads with minimal contact area. Fuzzy skin multiplies the contact area by orders of magnitude. Water gets trapped in the microscopic geometry. Surface tension holds it there. Airflow cannot easily strip it because the water is mechanically anchored, not just sitting on top.

### Application

**Where to use fuzzy skin:**
- Evaporative fins: **yes** — maximize water retention
- Baffle surfaces: **yes** — catchment pockets benefit from texture
- Airflow channels: **no** — keep smooth to minimize drag
- Venturi funnel walls: **no** — keep smooth to maximize velocity

**Settings (starting point):**
- Fuzzy skin thickness: 0.3–0.5mm
- Fuzzy skin density: 1.0–2.0 (higher = more chaotic)
- Fuzzy skin point distance: 0.8–1.2mm

These are slicer-dependent. The user should print a small test coupon and observe water retention.

### Trade-Offs

| Benefit | Cost |
|---------|------|
| Dramatically improved water retention | Increased surface drag (airflow resistance) |
| No extra parts, single slicer setting | Slightly longer print time |
| Works with any PETG, any water | Harder to clean if algae or biofilm develops |
| Gets better with mineral seasoning | Initial efficiency is lower than long-term |

The surface drag cost is acceptable because the baffle cascade is in the **expansion zone**, not the Venturi throat. Air has already slowed down after the constriction. A moderate increase in drag here does not significantly impact the Venturi pump performance.

---

## Layer Line Orientation: The Engineering Constraint

### The Problem

A single printed part cannot have two layer-line orientations. FDM builds layer by layer. The orientation is global to the part.

### The Solution: Separate Parts

| Component | Print Orientation | Layer Line Direction | Function |
|-----------|-------------------|----------------------|----------|
| **Base tile** (with Venturi funnels) | Flat on bed, funnels vertical | Vertical (Z-axis) | Smooth channel walls, structural rigidity |
| **Baffle insert** (fins/corrugated sheet) | Flat on bed, thin profile | Cross-flow to air direction | Rough, water-retaining |

The baffle insert snaps into the expansion chamber of the base tile. It is a separate print. This allows:
- Base tile layer lines: vertical, aligned with funnel airflow → smooth
- Baffle insert layer lines: horizontal across the fins → cross-flow roughness

**Print time for baffle insert:** ~20–30 min, ~10g PETG

### Why This Matters

If the baffle insert were printed as part of the same piece as the base tile, the layer lines would be vertical on the fins. Vertical layer lines on a horizontal fin create a ribbed surface that channels water along the fin rather than holding it. The cross-flow orientation creates ridges perpendicular to the fin surface — each ridge is a tiny dam that water must overcome to slide off.

---

## Seasoning: The Mineral Buildup Timeline

### Phase 1: Raw PETG (Days 1–7)

- Water beads up on the fuzzy skin
- Some droplets get trapped in the texture, but most are easily stripped by airflow
- Efficiency: 20–40% of theoretical maximum
- **User experience:** "It works a little, but not great."

### Phase 2: Initial Deposition (Days 7–21)

- Calcium, magnesium, and other dissolved solids from tap water begin to deposit in the fuzzy texture
- Deposits bridge between texture features, creating a more continuous wettable surface
- Efficiency: 40–70% of theoretical maximum
- **User experience:** "Getting better each day."

### Phase 3: Peak Seasoning (Days 21–90)

- Deposit layer is thick enough to significantly improve wicking but not so thick that it blocks airflow
- Water now forms a thin film rather than discrete beads on the seasoned surface
- Film evaporation is much faster than droplet evaporation
- Efficiency: 70–90% of theoretical maximum
- **User experience:** "This is working really well."

### Phase 4: Plateau or Decline (Months 3–12+)

- Deposits continue to build. At some point, the surface becomes too clogged.
- Excess buildup may flake off, creating chunks rather than a smooth film.
- Airflow may be restricted if deposits fill the gaps between baffles.
- Efficiency: 60–80% (declining) or requires fin replacement
- **User experience:** "It was great, then slowly got worse. Time to replace the fins."

### Design Implications

The modular baffle insert is designed to be replaced every 6–12 months. This is not a failure — it is scheduled maintenance. The base tile (with the Venturi funnels) lasts indefinitely. The baffle insert is a consumable part, priced accordingly ($5–8 replacement cost).

---

## Water System: Minimal Reservoir

The Flat model does not need a large reservoir. The baffle cascade handles water distribution and evaporation. What is needed is:

- **Initial wetting:** A small spray or pour of water onto the baffle insert before installation
- **Drip tray:** A thin channel or pocket at the bottom of the expansion chamber that collects any water that drips through the cascade
- **Optional top-up:** A small fill port (3mm) in the top edge of the tile for adding water without removing the unit

**Water consumption:** 0.5–1L/day in dry climates, less in humid climates. The baffle cascade is self-regulating — more airflow strips more water, which evaporates more, which cools more. Less airflow means less stripping, less evaporation, less water consumed.

---

## Validation Protocol

### Test 1: Baffle Insert Print Quality

- Print one baffle insert with fuzzy skin
- Print one baffle insert smooth (no fuzzy skin)
- Inspect both under magnification: fuzzy skin should show chaotic texture, smooth should show clean layer lines

### Test 2: Water Retention Under Static Conditions

- Wet both inserts with 10ml of water
- Hold vertically (as installed in the tile)
- Time how long water remains on the surface
- **Pass:** Fuzzy skin retains water >10× longer than smooth

### Test 3: Water Retention Under Airflow

- Install baffle insert in the base tile
- Wet the insert
- Blow air through the Venturi funnel (desk fan, compressed air, or lung power)
- Observe: does water stay on the fins or get blown through?
- **Pass:** At least 50% of water remains on the baffles after 30 seconds of airflow

### Test 4: Temperature Drop (Dry vs. Wet)

- Thermocouple upstream (outside) and downstream (room side)
- Test dry: airflow through dry baffles
- Test wet: airflow through wet baffles
- **Target:** Wet mode produces >3°C temperature drop vs. dry mode

### Test 5: Seasoning Simulation

- Soak baffle insert in hard water or calcium solution for 48 hours
- Allow to dry
- Repeat Tests 2–4
- **Target:** Seasoned insert performs >50% better than fresh insert

---

## Risk Register

| Risk | Mitigation | Status |
|---|---|---|
| Fuzzy skin on thin fins weakens structure | Increase fin thickness to 1.5mm, or use ribs | Design option |
| Fuzzy skin creates too much airflow drag | Test smooth vs. fuzzy side by side; reduce density if needed | Active test |
| Baffles choke airflow at 3 stages | Reduce to 2 stages or increase spacing | Design option |
| Water drips into room instead of evaporating | Add bottom collection tray; tilt tile slightly upward | Design option |
| Soft water users never reach seasoning peak | Include "priming" instruction (hard water rinse) | Documentation |
| Algae growth in fuzzy texture | Add 1 drop bleach per liter; design fins for easy replacement | Accepted |
| Mineral flakes clog Venturi throat | Fins are downstream of throat; tray is below; geometry prevents backflow | Design safe |
| Baffle insert too hard to snap in/out | Dovetail or twist-lock mechanism; test fit tolerance | Design option |

---

## Comparison: Flat Model vs. Tower Model Water Systems

| | **Flat Model** | **Tower Model** |
|---|---|---|
| **Mechanism** | Baffle cascade + fuzzy skin | Overflow reservoirs + gravity-fed stages |
| **Water distribution** | Airflow strips water from surface to surface | Water flows downward through overflow notches |
| **Water retention** | Fuzzy skin + mechanical trapping | Deep reservoirs hold water naturally |
| **Airflow driver** | Wind (Venturi) only | Stack effect (always) + wind (bonus) |
| **Reservoir size** | Minimal (drip tray) | Large (~200ml per stage) |
| **Refill frequency** | Daily spray or weekly pour | Weekly to biweekly |
| **Consumable part** | Baffle insert (6–12 months) | None (reservoirs are permanent) |
| **Best for** | Breezy, dry climates | Still air, humid climates |

---

## Summary

The Flat model's evaporative system is a **baffle cascade**: aerodynamic fins with fuzzy-skin texture that catch and hold water droplets as air flows past them. Water is stripped from one surface, caught on the next, and evaporates progressively. The system is self-regulating, gets better with use (mineral seasoning), and is designed around the constraints of thin PETG prints in a 25mm window insert.

The key insight: **do not fight PETG's hydrophobicity. Use FDM's roughness as a feature. Accept that water will move, then design surfaces that catch it. Let the geometry do the work.**

---

*This document is the current engineering specification for the Flat model's evaporative system. It supersedes any earlier descriptions of "water channels" or "chamber reservoirs" in the Flat model context. The Tower model uses a different architecture (see [Design Philosophy](11-design-philosophy.md)).*

*Next: [Design Philosophy](11-design-philosophy.md)*
