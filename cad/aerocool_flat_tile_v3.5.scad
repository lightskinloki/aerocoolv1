// AeroCool Flat Tile V3.5 — Rectangular Testing Variant
// For testing in windows and sliding door gaps
// NOT the final product — the hexagonal V3 remains the design for general use
// This is a developer/test build only

// Print: Outside face DOWN on bed, funnels vertical, no supports, PETG, 0.2mm layer, 15-20% infill
// Brim recommended for PETG adhesion
// Estimated print time: ~3 hrs, ~60g PETG

// ============================================================
// USER ADJUSTABLE PARAMETERS
// ============================================================

TILE_WIDTH = 100;         // Short dimension (mm) — fits sliding door gap
TILE_LENGTH = 150;      // Long dimension (mm) — spans the opening
TILE_THICKNESS = 25;    // Total thickness (mm)
CHAMBER_DEPTH = 5;      // Expansion chamber depth (mm)
CHAMBER_MARGIN = 5;     // Margin from tile edge to chamber (mm each side)

INLET_D = 15;           // Inlet diameter (mm)
THROAT_D = 4;           // Throat diameter (mm)
THROAT_LEN = 0.5;       // Straight throat length (mm)
CONE_ANGLE = 24;        // Half-angle from axis (degrees)

FILL_PORT_D = 3;        // Fill port diameter (mm)

// Funnel grid arrangement (7 funnels in rectangular pattern)
FUNNEL_SPACING_X = 30;  // Horizontal spacing (mm)
FUNNEL_SPACING_Y = 35;  // Vertical spacing (mm)
FUNNEL_OFFSET_X = 0;    // Horizontal offset of top row (mm, 0 = centered)

// ============================================================
// DERIVED PARAMETERS (do not modify)
// ============================================================

r_in = INLET_D / 2;
r_th = THROAT_D / 2;

AVAIL_DEPTH = TILE_THICKNESS - CHAMBER_DEPTH;

converge_len = (r_in - r_th) / tan(CONE_ANGLE);
diverge_len = AVAIL_DEPTH - converge_len - THROAT_LEN;
r_out = r_th + diverge_len * tan(CONE_ANGLE);
OUTLET_D = 2 * r_out;

CHAMBER_WIDTH = TILE_WIDTH - 2 * CHAMBER_MARGIN;
CHAMBER_LENGTH = TILE_LENGTH - 2 * CHAMBER_MARGIN;
CHAMBER_INNER_WIDTH = CHAMBER_WIDTH - 1;  // 1mm tolerance for insert
CHAMBER_INNER_LENGTH = CHAMBER_LENGTH - 1;

// ============================================================
// GEOMETRY VERIFICATION REPORT
// ============================================================

echo(str("=== AeroCool Flat Tile V3.5 (Rectangular Test) ==="));
echo(str("Tile size: ", TILE_WIDTH, " x ", TILE_LENGTH, " mm"));
echo(str("Tile thickness: ", TILE_THICKNESS, " mm"));
echo(str("Chamber depth: ", CHAMBER_DEPTH, " mm"));
echo(str("Chamber inner: ", CHAMBER_INNER_WIDTH, " x ", CHAMBER_INNER_LENGTH, " mm"));
echo(str("Funnel depth: ", AVAIL_DEPTH, " mm"));
echo(str("Outlet diameter: ", OUTLET_D, " mm"));
echo(str("Throat diameter: ", THROAT_D, " mm"));
echo(str("Inlet/throat area ratio: ", pow(INLET_D / THROAT_D, 2), ":1"));

// ============================================================
// FUNNEL POSITIONS (7 funnels in rectangular grid)
// Row 1: 3 funnels (top)
// Row 2: 4 funnels (bottom, staggered)
// ============================================================

FUNNELS = [
    // Top row: 3 funnels
    [-FUNNEL_SPACING_X, FUNNEL_SPACING_Y / 2],
    [0, FUNNEL_SPACING_Y / 2],
    [FUNNEL_SPACING_X, FUNNEL_SPACING_Y / 2],
    // Bottom row: 4 funnels (staggered)
    [-FUNNEL_SPACING_X * 1.5, -FUNNEL_SPACING_Y / 2],
    [-FUNNEL_SPACING_X * 0.5, -FUNNEL_SPACING_Y / 2],
    [FUNNEL_SPACING_X * 0.5, -FUNNEL_SPACING_Y / 2],
    [FUNNEL_SPACING_X * 1.5, -FUNNEL_SPACING_Y / 2],
];

// ============================================================
// MODULES
// ============================================================

module rect_prism(width, length, height) {
    translate([-width/2, -length/2, 0])
        cube([width, length, height]);
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
    // Solid rectangular tile base
    rect_prism(TILE_WIDTH, TILE_LENGTH, TILE_THICKNESS);
    
    // 7 Venturi funnel through-holes (from outside face to chamber floor)
    for (i = [0 : len(FUNNELS) - 1]) {
        translate([FUNNELS[i][0], FUNNELS[i][1], -0.01])
            venturi_funnel();
    }
    
    // Expansion chamber (recessed cavity on inside face, open to room)
    // Sized for baffle insert V3.5 to drop in
    translate([0, 0, AVAIL_DEPTH - 0.01])
        rect_prism(CHAMBER_INNER_WIDTH, CHAMBER_INNER_LENGTH, CHAMBER_DEPTH + 0.02);
    
    // Fill port: vertical through-hole from top edge of tile to chamber
    // Positioned at center of top edge
    translate([0, CHAMBER_LENGTH / 2 + CHAMBER_MARGIN - 2, 0])
        cylinder(h = TILE_THICKNESS, d = FILL_PORT_D, $fn = 32);
}

// ============================================================
// PRINT NOTES
// ============================================================
// Material: PETG (UV-stable, 60°C tolerant, food-safe for evap mode)
// Nozzle: 0.4mm standard
// Layer height: 0.2mm
// Infill: 15-20% (structural ribs only — funnels are hollow)
// Print orientation: Outside face DOWN on bed (funnels vertical)
// Supports: NONE — 24° wall angle is 66° from horizontal, self-supporting
// Bed adhesion: BRIM recommended (PETG warping)
// Print temperature: 230-250°C
// Bed temperature: 70-80°C
// 
// AFTER PRINTING:
// 1. Inspect all 7 funnel throats with a light — should be round and open
// 2. The baffle insert V3.5 drops into the chamber — check fit
// 3. Tile edge-to-edge: no gaps when butted against another tile
// 4. Test dry mode: mount in window, measure ΔT with thermocouple
// 5. Test wet mode: insert baffle fins, wet them, measure ΔT
// ============================================================
//
// DESIGN NOTE: This is a rectangular testing variant only.
// The hexagonal V3 tile remains the general design for modularity
// and scalability to any window size. This rectangle is for rapid
// testing in standard window frames and sliding door gaps.
// ============================================================
