// AeroCool Throat Test V2 — Venturi Atomization Verification
// Print: Funnel vertical, no supports, PETG, 0.2mm layer, 15-20% infill
// Estimated print time: ~30 min, ~10g PETG
//
// PURPOSE: Validate that the 4mm throat self-aspirates water and atomizes it
// when air flows through the Venturi. If this test works, the atomization concept
// is validated.

// ============================================================
// USER ADJUSTABLE PARAMETERS
// ============================================================

BLOCK_SIZE = 30;          // mm square
BLOCK_HEIGHT = 26;        // mm total height

INLET_D = 15;             // Inlet diameter (mm)
THROAT_D = 4;             // Throat diameter (mm) — increased from 2.5mm
THROAT_LEN = 0.5;         // Straight throat length (mm)
CONE_ANGLE = 24;          // Half-angle from axis (degrees)

CHAMBER_R = 10;           // Expansion chamber radius (mm)
CHAMBER_DEPTH = 3;        // Expansion chamber depth (mm)

WATER_CHANNEL_D = 1.5;    // Water channel bore diameter (mm)
WATER_CHANNEL_OFFSET = 0; // Y offset for water channel (mm, 0 = center)

// ============================================================
// DERIVED PARAMETERS (do not modify)
// ============================================================

r_in = INLET_D / 2;
r_th = THROAT_D / 2;

// Calculate converging and diverging lengths from angle
converge_len = (r_in - r_th) / tan(CONE_ANGLE);

// The funnel must fit in the block. The diverging section determines the outlet size.
// We set the funnel depth to reach the chamber floor.
funnel_depth = BLOCK_HEIGHT - CHAMBER_DEPTH;

// Calculate outlet radius from available diverging length
diverge_len = funnel_depth - converge_len - THROAT_LEN;
r_out = r_th + diverge_len * tan(CONE_ANGLE);
OUTLET_D = 2 * r_out;

chamber_z = funnel_depth;           // Chamber starts at funnel outlet
throat_z = converge_len + THROAT_LEN / 2;  // Center of throat
water_channel_len = BLOCK_SIZE / 2 + r_th + 0.5; // From side wall through throat

// ============================================================
// GEOMETRY VERIFICATION REPORT
// ============================================================

echo(str("=== Throat Test V2 Geometry ==="));
echo(str("Block size: ", BLOCK_SIZE, " x ", BLOCK_SIZE, " x ", BLOCK_HEIGHT, " mm"));
echo(str("Funnel depth: ", funnel_depth, " mm"));
echo(str("Converging section: ", converge_len, " mm"));
echo(str("Throat section: ", THROAT_LEN, " mm"));
echo(str("Diverging section: ", diverge_len, " mm"));
echo(str("Outlet diameter: ", OUTLET_D, " mm"));
echo(str("Throat diameter: ", THROAT_D, " mm (", THROAT_D / 0.4, " nozzle widths for 0.4mm nozzle)"));
echo(str("Throat center Z: ", throat_z, " mm"));
echo(str("Chamber starts at Z: ", chamber_z, " mm"));
echo(str("Inlet/throat area ratio: ", pow(INLET_D / THROAT_D, 2), ":1"));
echo(str("Outlet/throat area ratio: ", pow(OUTLET_D / THROAT_D, 2), ":1"));
echo(str("Water channel: ", WATER_CHANNEL_D, " mm from side wall, through throat"));

// ============================================================
// MODULES
// ============================================================

module venturi_funnel() {
    cylinder(h = converge_len, r1 = r_in, r2 = r_th, $fn = 64);
    translate([0, 0, converge_len])
        cylinder(h = THROAT_LEN, r = r_th, $fn = 64);
    translate([0, 0, converge_len + THROAT_LEN])
        cylinder(h = diverge_len, r1 = r_th, r2 = r_out, $fn = 64);
}

// ============================================================
// MAIN ASSEMBLY
// ============================================================

difference() {
    // Solid block
    translate([-BLOCK_SIZE/2, -BLOCK_SIZE/2, 0])
        cube([BLOCK_SIZE, BLOCK_SIZE, BLOCK_HEIGHT]);
    
    // Venturi funnel through-hole
    translate([0, 0, -0.01])
        venturi_funnel();
    
    // Expansion chamber on top (outlet side)
    translate([0, 0, chamber_z - 0.01])
        cylinder(h = CHAMBER_DEPTH + 0.02, r = CHAMBER_R, $fn = 64);
    
    // Water injection channel: horizontal bore from side wall into throat
    // Enter from +X side, go through throat center
    translate([BLOCK_SIZE/2, WATER_CHANNEL_OFFSET, throat_z])
        rotate([0, 90, 0])
            cylinder(h = water_channel_len + 0.02, d = WATER_CHANNEL_D, $fn = 32);
}

// ============================================================
// TEST PROTOCOL
// ============================================================
// 1. Print with PETG, 0.2mm layer, no supports, brim recommended
// 2. Inspect throat with a light: should be round and open
// 3. Hold a small syringe or cup of water against the side channel inlet
// 4. Blow air through the funnel (or use a fan / compressed air)
// 5. Observe: does water level drop? (suction confirmed)
// 6. Feel outlet air: is it moist? (atomization confirmed)
// 7. Optional: measure outlet temperature with thermocouple (cooling confirmed)
//
// PASS CRITERIA:
// - Water level drops when air flows (suction works)
// - Outlet air feels moist (atomization works)
// - Temperature drop > 5°C with water (cooling works)
//
// FAIL CRITERIA:
// - Throat clogged or severely rough (increase THROAT_D to 5)
// - No water aspiration (check channel alignment, increase channel diameter)
// ============================================================
