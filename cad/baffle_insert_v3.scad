// Baffle Insert V3
// Print: Flat on bed, enable FUZZY SKIN, PETG
// Estimated: ~20-30 min, ~10g PETG

INSERT_SIZE = 79;
INSERT_THICKNESS = 2;
FIN_HEIGHT = 3;
FIN_LENGTH = 55;
FIN_THICKNESS = 1.5;
FIN_ANGLE = 20;
FIN_OFFSETS = [-12, 0, 12];
FILL_PORT_D = 3;

module hex_prism(size, height) {
    r = size / 2;
    linear_extrude(height = height, center = false)
        polygon([for (a = [0 : 60 : 300]) [r * cos(a), r * sin(a)]]);
}

difference() {
    hex_prism(INSERT_SIZE, INSERT_THICKNESS);
    translate([0, INSERT_SIZE/2 * cos(30) + 0.5, -0.01])
        cylinder(h = INSERT_THICKNESS + 0.02, d = FILL_PORT_D, $fn = 32);
}

for (offset = FIN_OFFSETS) {
    translate([0, offset, INSERT_THICKNESS])
        rotate([0, 0, FIN_ANGLE])
            translate([-FIN_LENGTH/2, -FIN_THICKNESS/2, 0])
                cube([FIN_LENGTH, FIN_THICKNESS, FIN_HEIGHT]);
}
