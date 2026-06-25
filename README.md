# AeroCool V1

> A 3D-printable, powerless air conditioning system that uses physics — not electricity — to cool your home.

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![Status: Prototype](https://img.shields.io/badge/Status-Prototype-orange.svg)]()

---

## What Is AeroCool?

AeroCool is a **passive cooling window insert** that drops indoor temperatures by 10–20°F (5–11°C) using zero electricity. It combines three proven cooling mechanisms:

1. **Venturi Effect** — Wind accelerates through constricted funnels, creating low-pressure suction that atomizes water into the airstream
2. **Evaporative Cooling** — Atomized water droplets evaporate in the expansion zone, absorbing latent heat and cooling the air
3. **Stack Effect** — Tower height creates natural chimney draft, providing gentle ventilation even when wind dies down

The design is **fully modular, 3D printable, and repairable**. Every part can be replaced for $15–30. The unit lasts indefinitely.

---

## Two Models

| Model | Form | Price | Best For |
|-------|------|-------|----------|
| **AeroCool Flat** | Thin panel (1"/25mm) | $45–55 | Sliding windows, budget users, any window type |
| **AeroCool Tower** | Box tower (12–18"/300–450mm) | $110 | Double-hung windows, maximum cooling, power outages |

---

## Free Files vs. Assembled Units

| Option | Cost | What You Get |
|--------|------|--------------|
| **Free STL Files** | $0 | Download and print everything yourself. ~$22 in filament. |
| **Assembled Unit** | $110 | Professionally printed, assembled, tested, and shipped by a certified maker. |
| **Replacement Parts** | $15–30 | Individual modules for repairs. Only for verified owners. |
| **Rebuild Kit** | $85 | Complete refresh of all 6 stages + water system. Registry-gated. |

---

## How It Works

```
OUTSIDE AIR (95°F / 35°C)
    ↓
[Wind Catch / Omni Scoop] → [Venturi Funnel] → [Throat Atomization] → [Expansion Chamber] → Room
    ↑                                    ↑
[Water Reservoir]                        [Water drawn by suction]
```

**Flat Model:** Pure Venturi atomization — wind drives the pump, water evaporates in the chamber. Requires wind. Works best in dry, breezy climates.

**Tower Model:** Stack-effect evaporative chimney — gravity-fed overflow reservoirs on each stage, continuous upward draft cools air in series. Works with or without wind, best when outside is cooler than inside.

---

## Quick Specs (Dual Units)

| Parameter | Metric | Imperial |
|-----------|--------|----------|
| Outside temperature | 35°C | 95°F |
| Target room temperature | 20°C | 68°F |
| Temperature drop (combined mode) | 8–15°C | 14–27°F |
| Wind speed required | 3–8 m/s | 7–18 mph |
| Tower height | 300–450mm | 12–18" |
| Tower width | 400–600mm | 16–24" |
| Tower depth | 200–300mm | 8–12" |
| Funnel inlet | 15mm | 9/16" |
| Funnel throat (Flat) | 4mm | 5/32" |
| Funnel outlet (Flat) | ~10mm | ~3/8" |
| Flat tile thickness | 25mm | 1" |
| Tower funnel throat | 4–5mm | 5/32"–3/16" |
| Material | PETG | PETG |
| Print time (full tower) | 8–12 hrs | 8–12 hrs |
| Print cost (full tower) | $15–22 | $15–22 |

---

## The Maker Network

AeroCool is built by a **distributed network of independent makers**. We pay makers **70% of every sale** to print, assemble, and ship units to customers.

**Why join?**
- Earn $77 per assembled unit ($110 × 70%)
- Earn $10–21 per replacement part ($15–30 × 70%)
- Work from home with your existing 3D printer
- No inventory risk — print on demand
- We handle customer service, insurance, and platform costs

**Apply:** [Maker Network Application](docs/05-maker-onboarding.md)

---

## Documentation

| Document | Description |
|----------|-------------|
| [Physics](docs/01-physics.md) | How Venturi + evaporative + stack effect cooling works |
| [Design Specs](docs/02-design-specs.md) | Complete technical specifications (metric + imperial) |
| [Assembly Guide](docs/03-assembly-guide.md) | Step-by-step build instructions |
| [Business Model](docs/04-business-model.md) | Revenue share, pricing, and sustainability |
| [Maker Onboarding](docs/05-maker-onboarding.md) | How to join the maker network |
| [Replacement Parts](docs/06-replacement-parts.md) | Part catalog, pricing, and ordering |
| [Anti-Clone Strategy](docs/07-anti-clone.md) | Registry, serialization, and IP protection |
| [12-Month Roadmap](docs/08-roadmap.md) | From prototype to launch |
| [Venturi Analysis](docs/09-venturi-analysis.md) | Reframing the Venturi as a zero-power atomization pump |
| [Vehicle Application](docs/10-vehicle-application.md) | High-velocity portable cooling for vehicles without AC |
| [Design Philosophy](docs/11-design-philosophy.md) | **Current design framework** — post-pivot architecture, specs, and validation plan |
| [Flat Evaporative System](docs/12-flat-model-evaporative-system.md) | **Engineering spec** — baffle cascade, fuzzy skin, layer-line orientation, seasoning |

---

## CAD Files

All STL files are in the `/cad` directory. Print profiles for Cura and PrusaSlicer are in `/configs`.

> **Note:** CAD files are released under CC BY-NC-SA 4.0. Commercial sale of printed units requires membership in the certified maker network.

---

## Performance Data

See [data/performance-metrics.csv](data/performance-metrics.csv) for temperature drop measurements across wind speeds, humidity levels, and tower heights.

---

## Status

**Current Phase:** Proof of Concept (Month 1 of 12)

**Next Milestone:** Print [throat test V2](cad/throat_test_v2.scad) and validate Venturi atomization — does the 4mm throat self-aspirate water when air flows? Measure temperature drop with thermocouple.

**Follow our progress:** [GitHub Issues](https://github.com/lightskinloki/aerocoolv1/issues)

---

## License

- **CAD Files & Documentation:** [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) — Free for personal use and modification. Commercial sale requires certified maker status.
- **Business Model & IP:** Patent pending. Trademark on "AeroCool."

---

## Contact

- **Maker Network:** makers@aerocool.io (coming soon)
- **Press:** press@aerocool.io (coming soon)
- **Support:** support@aerocool.io (coming soon)

---

*Built with physics. Powered by people. Cooled by nature.*
