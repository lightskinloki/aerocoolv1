// AeroCool Throat Test — Quick Print Funnel Verification
// Print: Flat on bed, funnel vertical, no supports, PETG, 0.2mm layer
// Estimated print time: ~25-30 min, ~8g PETG
// 
// PURPOSE: Verify the 2.5mm throat is printable with your nozzle and PETG
// before committing to the full 2.5-hour tile print. Inspect with a light.

// ============================================================
// PARAMETERS (same as main tile funnel)
// ============================================================

INLET_D = 15;             // Inlet diameter (mm)
THROAT_D = 2.5;           // Throat diameter (mm)
OUTLET_D_TARGET = 12;     // Target outlet diameter (mm)
THROAT_LEN = 0.5;         // Straight throat length (mm)
CONE_ANGLE = 24;          // Half-angle from axis (degrees)

// Same thickness as the full tile funnel
TILE_THICKNESS = 28;
CHAMBER_DEPTH = 5;
AVAIL_DEPTH = TILE_THICKNESS - CHAMBER_DEPTH;

r_in = INLET_D / 2;
r_th = THROAT_D / 2;

converge_len = (r_in - r_th) / tan(CONE_ANGLE);
diverge_len = AVAIL_DEPTH - converge_len - THROAT_LEN;
r_out = r_th + diverge_len * tan(CONE_ANGLE);
OUTLET_D = 2 * r_out;

// ============================================================
// GEOMETRY REPORT
// ============================================================

echo(str("=== Throat Test Geometry ==="));
echo(str("Throat diameter: ", THROAT_D, " mm"));
echo(str("Throat diameter in nozzle widths: ", THROAT_D / 0.4, " (0.4mm nozzle)"));
echo(str("Converging section: ", converge_len, " mm"));
echo(str("Diverging section: ", diverge_len, " mm"));
echo(str("Total funnel depth: ", converge_len + THROAT_LEN + diverge_len, " mm"));
echo(str("Outlet diameter: ", OUTLET_D, " mm"));

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
// MAIN — small block with single funnel through it
// ============================================================

BLOCK_SIZE = 30;  // mm square

difference() {
    // Solid block
    translate([-BLOCK_SIZE/2, -BLOCK_SIZE/2, 0])
        cube([BLOCK_SIZE, BLOCK_SIZE, AVAIL_DEPTH]);
    
    // Single funnel through the center
    translate([0, 0, -0.01])
        venturi_funnel();
    
    // Small expansion chamber on top face
    translate([0, 0, AVAIL_DEPTH - 0.01])
        cylinder(h = 3, d = 20, $fn = 32);
}

// ============================================================
// PASS / FAIL CRITERIA
// ============================================================
// PASS: Light shines cleanly through the 2.5mm throat. Walls are smooth.
//       No blobs or stringing block more than 10% of the throat.
// 
// MARGINAL: Throat is oval or slightly rough, but light passes.
//           You may see reduced performance but the full tile is still worth trying.
// 
// FAIL: Throat is clogged, severely oval, or <50% open. 
//       Increase THROAT_D to 3.0 or 3.5 in the main tile before printing.
// ============================================================
