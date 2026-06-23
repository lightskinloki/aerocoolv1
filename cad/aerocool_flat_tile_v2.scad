// AeroCool Flat Tile V2 — Integrated Atomization Prototype
// Print: Outside face down, funnels vertical, no supports, PETG, 0.2mm layer, 15-20% infill
// Brim recommended for PETG adhesion
// Estimated print time: ~2.5 hrs, ~50g PETG
//
// V2 CHANGES from V1:
// - Throat increased from 2.5mm to 4mm (easier to print, 2.6x more airflow)
// - Tile thickness reduced from 28mm to 25mm (fits funnel geometry)
// - Chamber acts as water reservoir: fill with water, throat suction atomizes it
// - No separate water channels needed: funnels ARE the water channels
//
// HOW TO USE:
// 1. Print outside face down (inlets on bed, funnels vertical)
// 2. Fill chamber with water through the top fill port
// 3. Mount in window: outside face out, chamber (inside face) faces room
// 4. Wind pushes air through funnels → throat suction draws water from chamber
// 5. Water atomizes at throat → evaporates in chamber → cool air into room
// 6. Refill chamber as water evaporates

// ============================================================
// USER ADJUSTABLE PARAMETERS
// ============================================================

TILE_SIZE = 100;          // Hex point-to-point (mm)
TILE_THICKNESS = 25;      // Total thickness (mm) — fits 4mm throat geometry
CHAMBER_DEPTH = 5;        // Expansion chamber depth (mm) — also water reservoir
CHAMBER_SIZE = 80;        // Chamber point-to-point hex (mm)

INLET_D = 15;             // Inlet diameter (mm)
THROAT_D = 4;             // Throat diameter (mm) — V2: increased for printability & flow
THROAT_LEN = 0.5;         // Straight throat length (mm)
CONE_ANGLE = 24;          // Half-angle from axis (degrees)

FILL_PORT_D = 3;          // Fill port diameter (mm)

// ============================================================
// DERIVED PARAMETERS (do not modify)
// ============================================================

r_in = INLET_D / 2;
r_th = THROAT_D / 2;

// Available depth for funnel = tile thickness minus chamber depth
AVAIL_DEPTH = TILE_THICKNESS - CHAMBER_DEPTH;

converge_len = (r_in - r_th) / tan(CONE_ANGLE);
diverge_len = AVAIL_DEPTH - converge_len - THROAT_LEN;
r_out = r_th + diverge_len * tan(CONE_ANGLE);
OUTLET_D = 2 * r_out;

// ============================================================
// GEOMETRY VERIFICATION REPORT
// ============================================================

echo(str("=== AeroCool Flat Tile V2 Geometry ==="));
echo(str("Tile thickness: ", TILE_THICKNESS, " mm"));
echo(str("Chamber depth: ", CHAMBER_DEPTH, " mm"));
echo(str("Funnel depth: ", AVAIL_DEPTH, " mm"));
echo(str("Converging section: ", converge_len, " mm"));
echo(str("Throat section: ", THROAT_LEN, " mm"));
echo(str("Diverging section: ", diverge_len, " mm"));
echo(str("Outlet diameter: ", OUTLET_D, " mm"));
echo(str("Throat diameter: ", THROAT_D, " mm (", THROAT_D / 0.4, " nozzle widths)"));
echo(str("Funnel wall angle from horizontal: ", 90 - CONE_ANGLE, "°"));
echo(str("Inlet/throat area ratio: ", pow(INLET_D / THROAT_D, 2), ":1"));
echo(str("Mass flow vs V1 (2.5mm throat): ", pow(THROAT_D / 2.5, 2), "x"));

// ============================================================
// FUNNEL POSITIONS (7 funnels in hex pattern)
// ============================================================

RING_R = 20;  // Outer ring radius from center (mm)
FUNNELS = [
    [0, 0],                                    // center
    [RING_R, 0],                               // 0°
    [RING_R * cos(60), RING_R * sin(60)],      // 60°
    [RING_R * cos(120), RING_R * sin(120)],    // 120°
    [RING_R * cos(180), RING_R * sin(180)],    // 180°
    [RING_R * cos(240), RING_R * sin(240)],    // 240°
    [RING_R * cos(300), RING_R * sin(300)],    // 300°
];

// ============================================================
// MODULES
// ============================================================

module hex_prism(size, height) {
    r = size / 2;
    linear_extrude(height = height, center = false)
        polygon([
            for (a = [0 : 60 : 300]) [r * cos(a), r * sin(a)]
        ]);
}

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
    // Solid hexagonal tile base
    hex_prism(TILE_SIZE, TILE_THICKNESS);
    
    // 7 Venturi funnel through-holes (from outside face to chamber floor)
    for (i = [0 : len(FUNNELS) - 1]) {
        translate([FUNNELS[i][0], FUNNELS[i][1], -0.01])
            venturi_funnel();
    }
    
    // Expansion chamber / water reservoir (recessed cavity on inside face, open to room)
    // z = AVAIL_DEPTH is the chamber floor; z = TILE_THICKNESS is the inside face
    translate([0, 0, AVAIL_DEPTH - 0.01])
        hex_prism(CHAMBER_SIZE, CHAMBER_DEPTH + 0.02);
    
    // Fill port: vertical through-hole from top edge of tile to chamber
    // Positioned at center of top flat edge, slightly inset
    translate([0, CHAMBER_SIZE / 2 * cos(30) + 0.5, 0])
        cylinder(h = TILE_THICKNESS, d = FILL_PORT_D, $fn = 32);
}

// ============================================================
// PRINT NOTES
// ============================================================
// Material: PETG (UV-stable, 60°C tolerant, food-safe for evap mode)
// Nozzle: 0.4mm standard
// Layer height: 0.2mm
// Infill: 15-20% (structural ribs only — the funnels are hollow)
// Print orientation: Outside face DOWN on bed (funnels vertical)
// Supports: NONE — 24° wall angle is 66° from horizontal, self-supporting
// Bed adhesion: BRIM recommended (PETG warping)
// Print temperature: 230-250°C
// Bed temperature: 70-80°C
// 
// AFTER PRINTING:
// 1. Inspect all 7 funnel throats with a light — should be round and open
// 2. Inspect converging/diverging walls for stringing or blobs
// 3. Test dry mode: mount in window, measure ΔT with thermocouple
// 4. Test combined mode: fill chamber with water, measure ΔT
// 5. If throat is clogged or rough, increase THROAT_D to 5 in this file
//
// HOW ATOMIZATION WORKS:
// - Water fills the chamber (expansion zone) to the funnel outlet level
// - Wind pushes air through the funnels
// - Low pressure at the throat draws water up from the chamber
// - High-velocity air shears water into fine droplets at the throat
// - Droplets evaporate in the expansion chamber, cooling the air
// - Remaining water drains back into the chamber
// - This is a closed loop: water circulates, air flows, no power needed
// ============================================================
