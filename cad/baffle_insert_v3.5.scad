// Baffle Insert V3.5 — Rectangular Testing Variant
// For AeroCool Flat Tile V3.5 (rectangular test build)
// Drops into the expansion chamber of the rectangular base tile V3.5
// Print: Flat on bed, with FUZZY SKIN enabled, PETG, 0.2mm layer, 15-20% infill
// Estimated print time: ~25-35 min, ~12g PETG
//
// IMPORTANT: Enable FUZZY SKIN in your slicer for water retention!
// Cura: Experimental > Fuzzy Skin (thickness 0.3-0.5mm, density 1.0-2.0)
// PrusaSlicer: Layers and perimeters > Fuzzy skin
// This creates microscopic pockets that trap water on hydrophobic PETG.

// ============================================================
// PARAMETERS (must match base tile V3.5)
// ============================================================

INSERT_WIDTH = 89;        // Chamber inner width - 1mm tolerance (100 - 10 - 1 = 89)
INSERT_LENGTH = 139;      // Chamber inner length - 1mm tolerance (150 - 10 - 1 = 139)
INSERT_THICKNESS = 2;     // Base plate thickness (mm)
FIN_HEIGHT = 3;           // Fin height above plate (mm)
FIN_LENGTH = 125;         // Fin length (mm) — spans most of the insert length
FIN_THICKNESS = 1.5;      // Fin thickness (mm)
FIN_ANGLE = 20;           // Angle to airflow (degrees)
FIN_OFFSETS = [-18, 0, 18]; // X offsets for each fin (mm, spaced across width)
FILL_PORT_D = 3;          // Fill port diameter (mm)

// ============================================================
// MODULES
// ============================================================

module rect_prism(width, length, height) {
    translate([-width/2, -length/2, 0])
        cube([width, length, height]);
}

// ============================================================
// MAIN
// ============================================================

difference() {
    // Base plate
    rect_prism(INSERT_WIDTH, INSERT_LENGTH, INSERT_THICKNESS);
    
    // Fill port hole — aligns with base tile fill port
    translate([0, INSERT_LENGTH/2 - 2, -0.01])
        cylinder(h = INSERT_THICKNESS + 0.02, d = FILL_PORT_D, $fn = 32);
}

// Fins on top of plate — angled to intercept water droplets in airflow
// Fins span the LENGTH direction (along the sliding door gap / window opening)
// Airflow is along the LENGTH direction (left to right or right to left)
// Fins are angled across the flow to catch droplets
for (offset = FIN_OFFSETS) {
    translate([offset, 0, INSERT_THICKNESS])
        rotate([0, 0, FIN_ANGLE])
            translate([-FIN_THICKNESS/2, -FIN_LENGTH/2, 0])
                cube([FIN_THICKNESS, FIN_LENGTH, FIN_HEIGHT]);
}

// ============================================================
// HOW IT WORKS
// ============================================================
// 1. Drop this insert into the chamber of the rectangular base tile V3.5
// 2. The 3 fins divide the chamber into airflow channels along the length
// 3. Wet the fins with water (spray or pour through fill port)
// 4. Air flows through the Venturi funnels and into the chamber
// 5. Water droplets on the fins evaporate, cooling the air
// 6. Fuzzy skin texture holds water on the hydrophobic PETG
// 7. Mineral deposits from tap water gradually improve wicking over time
// 8. After 6-12 months, replace the insert ($5-8 cost)
//
// LAYER LINE ORIENTATION:
// This insert is printed FLAT on the bed, so layer lines are horizontal.
// When installed, airflow is along the LENGTH (horizontal, perpendicular to layer lines).
// This creates cross-flow roughness that traps water effectively.
// ============================================================
//
// DESIGN NOTE: This is a rectangular testing variant only.
// The hexagonal V3 baffle insert remains the general design.
// This rectangle is for rapid testing in standard window frames
// and sliding door gaps.
// ============================================================

// ============================================================
// SLICER SETTINGS
// ============================================================
// Material: PETG
// Nozzle: 0.4mm standard
// Layer height: 0.2mm
// Infill: 15-20%
// Fuzzy skin: ENABLED (thickness 0.3-0.5mm, density 1.0-2.0)
// Print orientation: Flat on bed (layer lines horizontal = cross-flow)
// Supports: NONE
// Bed adhesion: Brim recommended
// ============================================================
