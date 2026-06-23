// AeroCool Flat Tile V1.0 — Single Complete Prototype
// Print: Outside face down, funnels vertical, no supports, PETG, 0.2mm layer, 15-20% infill
// Brim recommended for PETG adhesion
// Estimated print time: ~2.5 hrs, ~50g PETG

// ============================================================
// USER ADJUSTABLE PARAMETERS
// ============================================================

// Tile geometry
TILE_SIZE = 100;          // Hex point-to-point (mm)
TILE_THICKNESS = 28;      // Total thickness (mm) — increased from 25 to fit 24° funnel
CHAMBER_DEPTH = 5;        // Expansion chamber depth on inside face (mm)
CHAMBER_SIZE = 80;        // Chamber point-to-point hex (mm)

// Funnel geometry
INLET_D = 15;             // Inlet diameter (mm)
THROAT_D = 2.5;           // Throat diameter (mm)
OUTLET_D_TARGET = 12;     // Target outlet diameter (mm)
THROAT_LEN = 0.5;         // Straight throat length (mm)
CONE_ANGLE = 24;          // Half-angle from axis (degrees)

// Water system
FILL_PORT_D = 3;          // Fill port diameter (mm)

// ============================================================
// DERIVED PARAMETERS (do not modify)
// ============================================================

r_in = INLET_D / 2;
r_th = THROAT_D / 2;
r_out_target = OUTLET_D_TARGET / 2;

AVAIL_DEPTH = TILE_THICKNESS - CHAMBER_DEPTH;

converge_len = (r_in - r_th) / tan(CONE_ANGLE);
diverge_len = AVAIL_DEPTH - converge_len - THROAT_LEN;
r_out = r_th + diverge_len * tan(CONE_ANGLE);
OUTLET_D = 2 * r_out;

// ============================================================
// GEOMETRY VERIFICATION REPORT
// ============================================================

echo(str("=== AeroCool Flat Tile V1.0 Geometry ==="));
echo(str("Tile thickness: ", TILE_THICKNESS, " mm"));
echo(str("Chamber depth: ", CHAMBER_DEPTH, " mm"));
echo(str("Available funnel depth: ", AVAIL_DEPTH, " mm"));
echo(str("Converging section: ", converge_len, " mm"));
echo(str("Throat section: ", THROAT_LEN, " mm"));
echo(str("Diverging section: ", diverge_len, " mm"));
echo(str("Total funnel length: ", converge_len + THROAT_LEN + diverge_len, " mm"));
echo(str("Outlet diameter: ", OUTLET_D, " mm (target was ", OUTLET_D_TARGET, " mm)"));
echo(str("Funnel wall angle from vertical: ", CONE_ANGLE, "°"));
echo(str("Print overhang from horizontal: ", 90 - CONE_ANGLE, "° (self-supporting if > 45°)"));
echo(str("Inlet/throat area ratio: ", pow(INLET_D / THROAT_D, 2), ":1"));
echo(str("Outlet/throat area ratio: ", pow(OUTLET_D / THROAT_D, 2), ":1"));

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

// Regular hexagon prism, point-to-point horizontal
// Vertices at 0°, 60°, 120°, etc. (point-to-point = size)
module hex_prism(size, height) {
    r = size / 2;
    linear_extrude(height = height, center = false)
        polygon([
            for (a = [0 : 60 : 300]) [r * cos(a), r * sin(a)]
        ]);
}

// Single Venturi funnel (Z-axis aligned, from z=0 to z=AVAIL_DEPTH)
// Converging at bottom (outside), diverging at top (into chamber)
module venturi_funnel() {
    // Converging section: inlet (large) at z=0, throat at top
    cylinder(h = converge_len, r1 = r_in, r2 = r_th, $fn = 64);
    
    // Throat section
    translate([0, 0, converge_len])
        cylinder(h = THROAT_LEN, r = r_th, $fn = 64);
    
    // Diverging section: throat at bottom, outlet (large) at top
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
    
    // Expansion chamber (recessed cavity on inside face, open to room)
    // z = AVAIL_DEPTH is the chamber floor; z = TILE_THICKNESS is the inside face
    translate([0, 0, AVAIL_DEPTH - 0.01])
        hex_prism(CHAMBER_SIZE, CHAMBER_DEPTH + 0.02);
    
    // Fill port: vertical channel from top edge of tile down to chamber
    // Positioned at center of top flat edge, slightly inset
    // Chamber top flat edge is at y = CHAMBER_SIZE/2 * cos(30°) = 34.64mm
    // Tile top flat edge is at y = TILE_SIZE/2 * cos(30°) = 43.30mm
    // Fill port placed between them, overlapping chamber wall
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
// 3. If throat is clogged or rough, increase THROAT_D to 3.0 or 3.5
// 4. Test dry mode first: mount in window, measure ΔT with thermocouple
// 5. Test combined mode: add water to chamber via fill port, measure ΔT
// ============================================================
