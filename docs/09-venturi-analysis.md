# 09 — Venturi Analysis: Making It Do Real Work

> **Status:** Planning / Pre-Prototype Analysis  
> **Date:** 2026-06-23  
> **Author:** AeroCool Engineering

---

## The Key Insight

The Venturi effect in AeroCool should not be thought of as a cooling engine. **It is a cooling facilitator — a zero-power pump.**

The adiabatic temperature drop at the Venturi throat is real, but it is **recovered** when air decelerates in the expansion zone. In an ideal Venturi, outlet temperature equals inlet temperature. In a real (friction-bearing) Venturi, the outlet can actually be *slightly warmer*. Cascading multiple Venturi stages does not produce cumulative adiabatic cooling — each stage's temperature drop undoes itself.

**However**, the low pressure at the throat creates suction — enough to draw water from a reservoir and atomize it into the airstream with zero moving parts and zero electricity. This transforms the Venturi from a marginal direct cooler into the engine that powers highly effective evaporative cooling.

This is proven technology. It is the same principle used in carburetors, Venturi scrubbers, medical nebulizers, and garden fertilizer sprayers.

---

## The Math

### Adiabatic Cooling (Why It Doesn't Carry the Load)

Temperature drop at the Venturi throat:

```
ΔT = (v_throat² - v_inlet²) / (2 × cp)
```

At 8 mph wind (3.58 m/s) with 6:1 diameter ratio (36:1 area ratio):

| Efficiency | Throat Velocity | ΔT at Throat | ΔT at Outlet |
|-----------|----------------|-------------|-------------|
| 25% | 32 m/s | 0.5°C | ~0°C (recovered) |
| 50% | 64 m/s | 2.0°C | ~0°C (recovered) |
| 100% (ideal) | 129 m/s | 8.3°C | 0°C (fully recovered) |

The air exits the Venturi at approximately the same temperature it entered. The throat cooling is temporary.

### Venturi as Pump (Why This Changes Everything)

Pressure drop at the throat (available suction):

```
ΔP = 0.5 × ρ × v_throat²
```

| Throat Velocity | Pressure Drop | Water Draw Height |
|----------------|---------------|-------------------|
| 32 m/s (25% eff) | 614 Pa | 63mm (2.5") |
| 64 m/s (50% eff) | 2,458 Pa | 250mm (10") |
| 129 m/s (ideal) | 9,970 Pa | 1,016mm (40") |

Even at 25% efficiency, the Venturi draws water **63mm** — more than double the tile thickness (28mm). There is more than enough suction to self-aspirate water from a reservoir through a channel to the throat.

### Why Atomization Beats Surface Evaporation

Current design: air flows over a wet surface in the expansion chamber.  
Proposed design: water is atomized into fine droplets suspended *in* the airstream.

Atomized water droplets have orders of magnitude more surface area than a wet surface. Evaporation rate scales with surface area. Expected improvement in evaporative effectiveness: **3–5×**.

---

## Revised Cooling Architecture

### Current Design

```
Air → [Converge] → [Throat] → [Expand] → Room
Water sits in expansion chamber (passive surface evaporation)
```

### Proposed Design

```
Air → [Converge] → [Throat + Water Injection] → [Expand + Evaporate] → Room
                        ↑
                  Water channel from reservoir
                  (drawn by Venturi suction, zero power)
```

The Venturi is the pump. Evaporation is the cooler. No electricity. No moving parts.

---

## Design Changes Required

### 1. Water Injection Channels

Add a 1–2mm bore from the water reservoir to each funnel throat. The low pressure at the throat draws water in; the high-velocity air shears it into fine droplets.

### 2. Throat Diameter Optimization

Consider increasing throat diameter from 2.5mm to 4–5mm:
- 4× more airflow per funnel
- Still sufficient velocity for atomization
- Much easier to print reliably (10–12.5 nozzle widths vs 6.25)
- Relative surface roughness drops from 7.3% to 3.7% (at 5mm)

### 3. Expansion Zone as Evaporation Chamber

The diverging section downstream of the throat gives atomized droplets time and space to evaporate. The expansion zone is now doing active cooling work, not just pressure recovery.

---

## Mass Flow Analysis

Current design: 42 funnels × 2.5mm throat = 206 mm² total throat area (equivalent to a 16mm hole).

| Configuration | Throat Area | Mass Flow (at 32 m/s) | Notes |
|--------------|------------|----------------------|-------|
| 42 × 2.5mm | 206 mm² | 0.0079 kg/s | Current — hard to print |
| 42 × 4mm | 528 mm² | 0.0203 kg/s | 2.6× more air |
| 42 × 5mm | 825 mm² | 0.0317 kg/s | 4× more air |
| 21 × 5mm (half funnels) | 412 mm² | 0.0158 kg/s | 2× air, easier layout |

More air through the device = more water atomized = more cooling power, even if the per-unit temperature drop is similar.

---

## Wind Concentration (Future Enhancement)

The Venturi effect scales with v². A wind scoop at the inlet multiplies effectiveness:

| Scoop Ratio | Effective Wind at 8 mph | Effect Multiplier |
|------------|------------------------|-------------------|
| 1:1 (none) | 8 mph | 1× |
| 2:1 | 16 mph | 4× |
| 3:1 | 24 mph | 9× |

The tower design (Model B) partially achieves this through height-driven stack effect. The inlet face geometry could be further optimized to concentrate lateral wind.

---

## Updated Performance Expectations

**Outside: 35°C (95°F) | 40% RH | 8 mph wind | Atomizing mode**

| Mode | Expected Drop | Room Temp | Confidence |
|------|--------------|-----------|------------|
| Dry (Venturi only) | 0–1°C (0–2°F) | 93–95°F | High — physics is clear |
| Surface evap (current) | 7–11°C (13–20°F) | 75–82°F | Medium — needs testing |
| Atomizing evap (proposed) | 9–14°C (16–25°F) | 70–79°F | Low — needs prototype |

Atomizing mode estimates are based on 3–5× surface area improvement over passive surface evaporation, capped at wet-bulb depression.

---

## Validation Plan

### Throat Test v2

Design a modified throat test block that includes:
1. Single Venturi funnel (same geometry as v1)
2. Water injection port: 1–2mm bore intersecting the throat
3. Small water reservoir (syringe or cup above the bore)

**Test protocol:**
1. Hold in front of a fan at 8 mph
2. Observe: does water level drop? (Venturi suction confirmed)
3. Feel outlet air: is it moist? (Atomization confirmed)
4. Measure outlet temperature with thermocouple (cooling confirmed)

If water self-aspirates at fan speeds, the core concept is validated.

---

## Implications

If Venturi atomization works as expected:
- The Venturi is no longer a marginal contributor — it is **the mechanism** that makes zero-power evaporative cooling work
- Multi-stage designs should focus on maximizing atomization and evaporation time, not cascading adiabatic drops
- The expansion zone geometry matters more than the throat geometry for cooling (it's where evaporation happens)
- Water consumption will increase (more atomization = more evaporation = more refills)
- This architecture has applications beyond window units (see: [10 — Vehicle Application](10-vehicle-application.md))

---

*Previous: [Roadmap](08-roadmap.md) | Next: [Vehicle Application](10-vehicle-application.md)*
