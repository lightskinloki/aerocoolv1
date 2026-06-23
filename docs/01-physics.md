# 01 — Physics of AeroCool

## Three Cooling Mechanisms

### 1. Venturi Effect (Adiabatic Cooling)

When air is forced through a constriction, its velocity increases and its pressure drops. This pressure drop causes a temperature drop.

**Formula:**
```
T_drop = (v_throat² - v_inlet²) / (2 × cp)
```

Where:
- `v_throat` = air velocity at narrowest point (m/s)
- `v_inlet` = air velocity at inlet (m/s)
- `cp` = specific heat capacity of air (1005 J/kg·K)

**Real-world example:**
- Wind speed: 8 mph (3.58 m/s)
- Constriction ratio: 6:1 (inlet 15mm → throat 2.5mm)
- Throat velocity: 129 m/s (ideal) → 32 m/s (realistic, 25% efficiency)
- Temperature drop: ~2°C per stage (3.6°F)

### 2. Evaporative Cooling

Water evaporating into air absorbs latent heat, cooling the air. The maximum possible drop is the wet-bulb depression.

**Wet-bulb depression at 35°C (95°F):**
| Humidity | Wet Bulb | Max Drop | Realistic Drop |
|----------|----------|----------|----------------|
| 20% RH | 20°C (68°F) | 15°C (27°F) | 11°C (20°F) |
| 40% RH | 24°C (75°F) | 11°C (20°F) | 7°C (13°F) |
| 60% RH | 28°C (82°F) | 7°C (13°F) | 4°C (7°F) |

### 3. Stack Effect (Chimney Draft)

Hot air rises. A tall tower creates a pressure differential that pulls cooler air in from below.

**Formula:**
```
ΔP = ρ × g × h × (ΔT / T_avg)
```

**Draft velocities by height:**
| Height | Draft Velocity | Equivalent Wind |
|--------|----------------|-----------------|
| 12" (300mm) | 0.31 m/s | 0.7 mph |
| 18" (450mm) | 0.38 m/s | 0.9 mph |
| 24" (600mm) | 0.44 m/s | 1.0 mph |

This means AeroCool works **even with zero outside wind**.

---

## Multi-Stage Cooling

Each tower contains 6 stacked Venturi stages. Cooling is cumulative:

| Stage | Adiabatic Drop | Evaporative Drop | Running Total |
|-------|----------------|------------------|---------------|
| 1 | +2.0°C | +4.0°C | 6.0°C |
| 2 | +2.0°C | +3.5°C | 11.5°C |
| 3 | +2.0°C | +3.0°C | 15.0°C (capped) |
| 4 | +2.0°C | +2.5°C | 15.0°C (capped) |
| 5 | +2.0°C | +2.0°C | 15.0°C (capped) |
| 6 | +2.0°C | +1.5°C | 15.0°C (capped) |

**Wet-bulb limit:** Total cooling cannot exceed the wet-bulb depression. At 40% RH, this caps at ~11°C (20°F).

---

## Performance at Realistic Wind Speeds

**Outside: 35°C (95°F) | 40% RH**

| Wind Speed | Dry Mode | Combined Mode | Room Temp |
|------------|----------|---------------|-----------|
| 0 mph (stack only) | 2°C (4°F) | 8°C (14°F) | 81°F |
| 8 mph (average) | 2°C (4°F) | 11°C (20°F) | 75°F |
| 12 mph (fresh breeze) | 4°C (7°F) | 11°C (20°F) | 75°F |
| 16 mph (strong breeze) | 6°C (11°F) | 11°C (20°F) | 75°F |

---

## References

- Traditional windcatchers (badgirs): Proven for 3,000+ years in Middle Eastern architecture
- Brikoole (2024 James Dyson Award): 3D-printed passive cooling brick, 6°C average drop
- Virginia Tech clay columns: 3D-printed evaporative cooling, up to 10°F (5.6°C) drop
- Eastgate Centre (Zimbabwe): Termite-mound inspired ventilation, 90% less energy than conventional AC

---

*Next: [Design Specs](02-design-specs.md)*
