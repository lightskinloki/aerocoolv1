# 10 — Vehicle Application

> **Status:** Planning / Pre-Prototype Analysis  
> **Date:** 2026-06-23  
> **Author:** AeroCool Engineering

---

## The Concept

A slim, portable AeroCool panel designed to clip into a partially rolled-down vehicle window. It uses the vehicle's forward motion to drive the Venturi atomization process, providing directed, powerless evaporative cooling to the occupants.

## Why Vehicles Are the Perfect Use Case

The physics of the Venturi effect (and the resulting atomization suction) scale with the **square of the inlet velocity** ($v^2$).

- **Home window at 8 mph wind:** Inlet velocity = 3.58 m/s
- **Vehicle at 30 mph (city):** Inlet velocity = 13.4 m/s (3.7× home velocity, **14× the Venturi effect**)
- **Vehicle at 60 mph (highway):** Inlet velocity = 26.8 m/s (7.5× home velocity, **56× the Venturi effect**)

Because vehicles generate their own high-speed wind, the available kinetic energy for atomizing water is massive.

### Water Draw (Suction) Potential

At a conservative 2:1 diameter constriction (4:1 area ratio):

| Speed | Inlet Velocity | Throat Velocity | Pressure Drop | Suction Potential |
|-------|----------------|-----------------|---------------|-------------------|
| 15 mph | 6.7 m/s | 26.8 m/s | ~430 Pa | ~44 mm (1.7 in) |
| 30 mph | 13.4 m/s | 53.6 m/s | ~1,720 Pa | ~175 mm (6.9 in) |
| 60 mph | 26.8 m/s | 107.2 m/s | ~6,900 Pa | ~700 mm (27.5 in) |

There is more than enough suction to atomize water at any typical driving speed.

## Cooling Performance vs. Car Cabin

A vehicle cabin requires significant energy to cool completely (typically 1,000–3,000W of mechanical AC). However, **personal cooling** requires much less (50–200W).

Because the AeroCool panel sits in the window directly next to the driver/passenger, the cooled air is directed straight at the occupant.

- **Mass flow at 30 mph** (with 7 funnels, 20mm inlet / 10mm throat): ~0.035 kg/s
- **Cooling power** (assuming 10°C evaporative drop at 40% RH): ~350W

350W of directed, chilled air blowing straight on the driver is highly noticeable and provides significant thermal relief, even if the rest of the cabin remains warm.

## Comparison: AeroCool vs. "Window Down"

Driving with the window down at 60 mph provides wind chill, but has severe drawbacks. The AeroCool panel solves many of them:

| Feature | Window Down | AeroCool Panel |
|---------|-------------|----------------|
| **Air Temp** | Ambient (e.g., 95°F) | Ambient minus 10–20°F (e.g., 75°F) |
| **Noise** | Extremely loud (85+ dB) | Significantly quieter (window mostly closed) |
| **Protection** | None | Blocks bugs, rain, and debris |
| **Aero Drag** | High (reduces fuel economy) | Lower (controlled airflow path) |

## The Droplet Carryover Problem (Mist Elimination)

A critical safety and comfort issue with the vehicle application is **droplet carryover**. If water is violently atomized at 30–60 mph, there is a risk that unevaporated water droplets will spray directly into the driver's face. 

To prevent the device from becoming an annoying "mister," we must engineer a way to deliver *humidified, cooled air* without liquid droplets. There are three primary engineering solutions to this:

### 1. Mist Eliminator Baffles (The "Labyrinth" Approach) - **Chosen Path**
Instead of a straight shot from the Venturi to the driver, the expansion chamber includes a series of 3D-printed louvers or chevron baffles. 
- Air and fine vapor can navigate the sharp turns.
- Heavier liquid droplets cannot make the turns due to momentum; they hit the baffle walls, condense, and drain back into the reservoir.
- **Why this is the only viable option:** This approach relies purely on geometry. It can be printed on any standard $200 3D printer using basic PETG filament. 

*(Note: Other methods, such as Wicking Matrices, were discarded because 60 mph winds would shear the droplets off the lattice. Indirect Evaporative Cooling was discarded because it requires expensive, specialized thermally conductive filaments, which violates the core mission of enabling anyone to manufacture this at home.)*

---

## Target Markets

This is potentially a larger and more urgent market than the home unit:

1. **Used cars with broken AC:** A $500–$2,000 repair avoided for $50.
2. **Delivery drivers:** Constant entering/exiting defeats standard AC; personal directed cooling is more efficient.
3. **Developing nations:** Millions of vehicles on the road lack AC entirely.
4. **Classic & vintage cars:** No factory AC, and owners don't want to modify the engine.
5. **Work trucks & farm equipment:** Cabs get dangerously hot in direct sun.
6. **Rideshare drivers:** Reducing mechanical AC usage saves fuel/range.

## Form Factor Considerations

- **Mounting:** Panel slots into the window track. Roll the window up to pinch it in place.
- **Reservoir:** Integrated ~500ml or 1L water tank.
- **Air Intake:** Funnels face forward to capture ram-air pressure.
- **Air Exhaust:** Adjustable louvers to direct the chilled air at the driver's face/torso.
- **Portability:** No wiring, no installation. Move from car to car in seconds.

---

*Previous: [Venturi Analysis](09-venturi-analysis.md)*
