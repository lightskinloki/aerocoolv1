# 11 — Design Philosophy: From Concept to Architecture

> **Status:** Current design framework (post-prototype-analysis)  
> **Date:** 2026-06-23  
> **Author:** AeroCool Engineering

---

## The Core Insight: The Venturi Is a Pump, Not a Cooler

The single most important design pivot we made:

**The Venturi effect does not produce meaningful cumulative adiabatic cooling.** The temperature drop at the throat is temporary — it recovers in the expansion zone. In an ideal Venturi, outlet temperature equals inlet temperature. In a real Venturi with friction, the outlet can be slightly *warmer*.

**What the Venturi *does* produce is suction.** The low pressure at the throat draws water from a reservoir and shears it into fine droplets suspended in the airstream. This transforms the Venturi from a marginal direct cooler into a **zero-power atomization pump** that drives highly effective evaporative cooling.

This is proven technology. It is the same principle used in carburetors, medical nebulizers, Venturi scrubbers, and garden fertilizer injectors. The physics is real, but the value proposition is evaporative — not adiabatic.

**Implication:** Multi-stage Venturi stacking does not produce cumulative cooling. The 6-stage tower design in earlier documents was based on this misconception. The new architecture treats the Venturi as a single-stage pump and focuses all cooling effort on maximizing evaporative effectiveness.

---

## Two Models, Two Mechanisms, One Physics Core

| | **AeroCool Flat** | **AeroCool Tower** |
|---|---|---|
| **Form** | Thin panel (25mm) | Vertical box (300–450mm) |
| **Price** | $45–55 | $110 |
| **Primary mechanism** | Venturi atomization + wind-driven airflow | Stack effect + multi-stage gravity-fed evaporation |
| **Wind dependency** | Required — pure Venturi mode | Optional — stack effect works without wind |
| **Best for** | Sliding windows, consistent breezes, budget | Double-hung windows, still air, maximum cooling |
| **No-wind backup** | None (install a second unit for cross-flow) | Yes — stack effect draft |
| **Water system** | Chamber reservoir, throat-aspirated atomization | Multi-layer overflow reservoirs, gravity-fed |
| **Cooling ceiling** | ~10–15°C (limited by wind speed) | ~15–20°C (stack + multi-stage evaporation) |
| **Print time** | ~2.5 hrs per tile | ~8–12 hrs |
| **Material** | ~50g PETG per tile | ~1kg PETG |

**The two models are not variants of the same design. They are two different architectures that share a common physics understanding.**

---

## AeroCool Flat: The Venturi Atomization Panel

### How It Works

```
Outside Wind → Omni Scoop → Venturi Funnel → Throat Atomization → Expansion Chamber → Room
                    ↓
            Water Chamber (reservoir)
```

1. **Wind hits the omni scoop** — a fixed multi-opening cowl that captures wind from any direction and normalizes it into a single intake flow
2. **Air accelerates through the Venturi funnel** — 15mm inlet → 4mm throat → ~10mm outlet
3. **Low pressure at the throat draws water** from the chamber reservoir up into the airstream
4. **High-velocity air shears water into droplets** — atomization
5. **Droplets evaporate in the expansion chamber** — latent heat absorption cools the air
6. **Cool, humidified air flows into the room**

### Key Design Parameters

| Parameter | Value | Rationale |
|---|---|---|
| Tile size | 100mm hex point-to-point | Modular, scalable to any window |
| Thickness | 25mm | Fits 4mm throat geometry at 24° cone angle |
| Throat diameter | 4mm | 10 nozzle widths (printable), 2.6× more flow than 2.5mm |
| Inlet/throat area ratio | 14:1 | Sufficient for atomization, better flow than 36:1 |
| Cone angle | 24° half-angle | Self-supporting (66° from horizontal), no supports needed |
| Chamber depth | 5mm | Water reservoir + expansion zone |
| Chamber size | 80mm hex | Large enough for all 7 funnel outlets |
| Funnels per tile | 7 | 1 center + 6 ring |
| Fill port | 3mm vertical bore | Manual refill |

### The Omni Scoop (Wind Attachment)

The Flat model is pure Venturi — it needs wind. To maximize the probability of wind capture, an **omnidirectional wind scoop** attaches to the outside face:

- **Fixed multi-opening cowl** — a ring of curved intake vanes around the tile perimeter
- No moving parts, no bearings, no maintenance
- Normalizes chaotic wind from any direction into a single downward/horizontal flow before it hits the funnel inlets
- Printable as a snap-on ring or integrated into the tile perimeter

Without the omni scoop, the Flat model only works when wind happens to align with the window. With it, the Flat works in any wind condition.

### Water System: Baffle Cascade + Fuzzy Skin

The Flat model uses a **baffle cascade** in the 5mm expansion chamber to retain and evaporate water. This is a different architecture from the Tower's gravity-fed reservoirs:

```
Air → [Venturi Funnel] → [Expansion Chamber] → [Baffle 1] → [Baffle 2] → [Baffle 3] → Room
                                                  ↓            ↓            ↓
                                            Water impacts, evaporates, drains
```

1. **Air exits the Venturi** at moderate velocity into the expansion chamber
2. **Water is present on the baffle surfaces** (from initial wetting or a small drip tray)
3. **Airflow strips water droplets** from the first baffle
4. **Droplets impact the next baffle** downstream — some evaporate, some continue
5. **Remaining water drips into a collection trough** or drains back

**Baffle design:** Airfoil-shaped fins angled 15–30° to the airflow, with catchment pockets on the pressure side. Not perpendicular walls — aerodynamic curves that let air flow smoothly while water separates by inertia.

**Fuzzy skin:** A slicer setting that applies random z-offset noise to the outer wall, creating microscopic pockets where water gets mechanically trapped on the hydrophobic PETG. This is the primary water retention mechanism.

**Layer line orientation:** Baffle inserts are printed as **separate parts** from the base tile. This allows:
- Base tile: layer lines vertical, aligned with funnel airflow → smooth
- Baffle insert: layer lines cross-flow to the fins → rough, water-retaining

**Seasoning:** Over time, mineral deposits from hard tap water build up on the fuzzy texture, improving wicking. The system gets better with use. After 6–12 months, the baffle insert is replaced ($5–8).

Full engineering spec: [Flat Evaporative System](12-flat-model-evaporative-system.md)

**Note on atomization:** The throat test V2 validates that Venturi suction can draw water into the airstream. This is a real physical effect. However, the baffle cascade is the simpler, more reliable, and more printable approach for the Flat model. Atomization may be incorporated into the Tower design or future variants.

---

## AeroCool Tower: The Stack-Effect Evaporative Chimney

### How It Works

```
Outside Air (any direction)
    ↓
[Inlet Vents] → [Stage 1: Overflow Reservoir + Evap Fins] → [Stage 2: Overflow Reservoir + Evap Fins] → ...
    ↑                                                    ↓
[Stack Effect Draft] ← [Stage 6: Overflow Reservoir + Evap Fins] ← [Hot Air Exhaust]
    ↓
Cooled Air to Room
```

1. **Water starts at the top reservoir** — gravity-fed from a fill port or drip system
2. **Overflow notches** transfer water from each level to the one below
3. **Evaporative fins** on each stage hold water via FDM roughness and capillary action
4. **Stack effect** creates continuous upward airflow — hot air rises, pulling cooler air in from below
5. **Air passes through all 6 stages** in series, picking up moisture and shedding heat
6. **Hot, humid air exhausts from the top** — the chimney draft is continuous and passive

### Key Design Parameters

| Parameter | Value | Rationale |
|---|---|---|
| Height | 300–450mm (12–18") | Sweet spot for stack effect vs. structural limits |
| Width | 400–600mm | Window-fit dependent |
| Depth | 200–300mm | Encloses multi-stage stack |
| Stages | 6 | More stages = more contact time, but diminishing returns |
| Stage spacing | ~50mm | Airflow + water distribution balance |
| Overflow notch | 2–3mm width | Controls flow rate between levels |
| Fins per stage | TBD | Print orientation optimized for wicking |

### Stack Effect: When It Works and When It Doesn't

**Stack effect strength scales with height × temperature difference.**

| Scenario | Room Temp | Outside Temp | Airflow | Direction |
|---|---|---|---|---|
| Hot room, cool evening | 32°C | 24°C | ~60–130 CFM | Exhausts hot air, draws cool air in |
| Warm room, mild outside | 28°C | 28°C | ~0–20 CFM | Minimal draft |
| Cool room, hot outside | 24°C | 35°C | Reverses or stalls | Hot air wants to sink in |

**The honest framing:** The stack effect is not a universal backup. It is a **time-of-day dependent helper** that works best in the evening and night — exactly when the Venturi effect (wind) often dies down. It does not maintain a cool room against a hot afternoon. It cools down a hot room when the outside is cooler.

This is not a flaw. It is a **complementary mechanism** that covers the gap the Venturi leaves.

### Water System: Gravity-Fed Overflow Reservoirs

Water is poured into the top reservoir. When it reaches the overflow notch height, it spills to the next level down. This continues through all 6 stages. Gravity does the distribution. The stack effect does the airflow. No pumps, no electricity.

- **Top reservoir capacity:** ~200ml per stage
- **Total capacity:** ~1.2L for 6 stages
- **Overflow notches:** 2–3mm wide, at controlled height
- **Wicking:** FDM layer-line roughness holds water on fin surfaces

---

## FDM as a Feature, Not a Limitation

Traditional manufacturing treats surface roughness as a defect. AeroCool treats it as a functional element.

### The Layer-Line Strategy

| Surface | Layer Line Orientation | Purpose |
|---|---|---|
| **Wind channels** | Aligned with airflow | Smooth, low drag |
| **Evaporative fins** | Perpendicular to airflow | Rough, water-retaining |

This is only possible because the Flat and Tower use **separate printed parts** assembled together. A monolithic print cannot optimize both orientations. Modularity is not just repairable — it is **functionally necessary**.

### The "Seasoning" Effect

PETG is hydrophobic. Fresh prints do not hold water well. However, tap water contains dissolved minerals (calcium, magnesium, etc.) that deposit on the fin surfaces over time. These deposits:

- Increase surface energy (better wetting)
- Fill layer-line valleys (more capillary retention)
- Improve wicking efficiency over the first weeks of use

**Mineral buildup is anticipated and beneficial — up to a point.** Eventually, deposits may clog or flake. The modular design allows fin replacement without scrapping the entire unit. The "seasoning curve" is an emergent property, not a bug.

---

## Print Architecture: Why Modularity Is Mandatory

AeroCool cannot be a single printed piece because:

1. **Different surfaces need different layer-line orientations** (channels vs. fins)
2. **Different parts fail at different rates** (fins season, reservoirs may clog, frames may warp)
3. **Window sizes vary** — tiles must be assembled to fit
4. **Makers have different printer sizes** — a 600mm panel is not printable on a standard 220mm bed
5. **Replacement economics** — $15–30 part swap vs. $110 full unit replacement

**Every AeroCool unit is an assembly of modular, replaceable, 3D-printed parts.** This is the core design constraint that shapes everything else.

---

## Validation Strategy: From Vibe to Numbers

### Phase 1: Vibe Test (Flat Model)

- Print the throat test V2 — verify 4mm throat is clean and round
- Print one complete Flat tile V2
- Install in a window with the door closed and no AC running
- **Question:** Does the room feel different? Is there a noticeable draft? Does the air feel cooler?
- **No instruments needed.** Human perception is the first filter. If you can't feel it, the numbers won't save it.

### Phase 2: Instrumented Test (Flat Model)

- Thermocouple upstream (outside) and downstream (inside face)
- Log at different wind speeds and humidity levels
- Test dry mode (no water) vs. wet mode (filled chamber)
- **Target:** Measurable temperature drop (even 1°C counts as proof of concept)

### Phase 3: Omni Scoop Test (Flat Model)

- Attach omni scoop to outside face
- Test at variable wind angles
- **Target:** Works in at least 3 of 4 cardinal directions

### Phase 4: Tower Stack Effect Test (Tower Model)

- Print one tower stage with overflow reservoir and evaporative fins
- Stack 3 stages vertically
- Heat lamp below, thermocouple at each level
- **Target:** Measurable temperature drop from bottom to top, even with zero wind

### Phase 5: Integrated Test (Both Models)

- Full Flat panel (3–6 tiles) with omni scoop and wicking fins
- Full Tower (6 stages) with overflow system
- Side-by-side comparison across different weather conditions
- **Target:** Documented performance data for marketing and maker network specs

---

## What Changed and Why

| Original Assumption | New Understanding | Action |
|---|---|---|
| Venturi produces cumulative adiabatic cooling | Venturi produces temporary throat cooling + suction | Redesigned as atomization pump |
| 6-stage tower stacks 6 adiabatic drops | 6-stage tower provides 6 evaporation contact zones | Tower is evaporative chimney, not adiabatic cascade |
| 2.5mm throat for maximum velocity | 4mm throat for printability + flow | Changed throat diameter |
| 25mm tile thickness | 28mm (V1) then back to 25mm (V2) | 25mm fits 4mm throat at 24° angle |
| Chamber evaporation (passive surface) | Baffle cascade + fuzzy skin fins | Throat atomization validated but baffles are simpler and more printable |
| Mineral buildup = failure | Mineral buildup = progressive seasoning | Design for replaceable fin inserts |
| Tower stack effect = universal no-wind backup | Stack effect = evening/night helper only | Honest framing in marketing |
| Single print or simple assembly | Separate parts with optimized orientations | Modularity is mandatory |

---

## The Honest Value Proposition

> **AeroCool is not an air conditioner replacement. It is a zero-power supplemental cooling system that makes hot rooms survivable.**
>
> In dry climates with breeze: expect 10–15°F cooling.  
> In humid climates with light wind: expect 5–10°F cooling.  
> With no wind at all (Tower only): expect 5–10°F cooling from stack effect, but only when outside is cooler than inside.  
> It will not make your room cold. It will make your room livable.

---

## The Honest Risk Register

| Risk | Mitigation | Status |
|---|---|---|
| 4mm throat still not printable cleanly | Increase to 5mm; test with throat test V2 | Active |
| Baffles choke airflow or strip all water | Test smooth vs. fuzzy; reduce to 2 stages; increase spacing | Active |
| Fuzzy skin too fragile on thin fins | Increase fin thickness to 1.5mm; add support ribs | Design option |
| Soft water users never reach seasoning | Include "priming" instruction (hard water rinse) | Documentation |
| Atomization does not produce meaningful cooling | Baffle cascade is primary; atomization is Tower option | Planned |
| Stack effect insufficient at 300–450mm | Increase to 600mm; add solar chimney option | Contingency |
| Mineral buildup clogs fins | Design fin replacement as standard maintenance | Accepted |
| Algae growth in fuzzy texture | Add 1 drop bleach per liter; design fins for easy replacement | Accepted |
| Omni scoop too restrictive | Open up vanes; reduce to 3-directional scoop | Contingency |
| PETG warps in direct sun | Switch to ASA/ABS for hot climates; add heat shield | Contingency |
| Water consumption too high (Tower) | Reduce fin surface area; meter overflow notches | Design option |
| No wind + hot outside = zero cooling (Flat) | Accept as design constraint; Tower for still air | Accepted |

---

*This document is the current design source of truth. Earlier documents (01–08) contain outdated assumptions about multi-stage adiabatic cooling and 2.5mm throat geometry. They are retained for historical context but should not be treated as current specifications. Document 09 (Venturi Analysis), this document, and Document 12 (Flat Evaporative System) together constitute the current design framework.*

*Next: [Flat Evaporative System](12-flat-model-evaporative-system.md)*
