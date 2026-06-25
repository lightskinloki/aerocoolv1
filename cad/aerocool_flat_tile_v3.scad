// AeroCool Flat Tile V3
// Print: Outside face DOWN, funnels vertical, no supports, PETG
// Estimated: ~2.5 hrs, ~50g PETG

TILE_SIZE = 100;
TILE_THICKNESS = 25;
CHAMBER_DEPTH = 5;
CHAMBER_SIZE = 80;
INSERT_TOLERANCE = 1;

INLET_D = 15;
THROAT_D = 4;
THROAT_LEN = 0.5;
CONE_ANGLE = 24;
FILL_PORT_D = 3;

r_in = INLET_D / 2;
r_th = THROAT_D / 2;
AVAIL_DEPTH = TILE_THICKNESS - CHAMBER_DEPTH;
converge_len = (r_in - r_th) / tan(CONE_ANGLE);
diverge_len = AVAIL_DEPTH - converge_len - THROAT_LEN;
r_out = r_th + diverge_len * tan(CONE_ANGLE);
OUTLET_D = 2 * r_out;
CHAMBER_INNER_SIZE = CHAMBER_SIZE - INSERT_TOLERANCE;

RING_R = 20;
FUNNELS = [
    [0, 0],
    [RING_R, 0],
    [RING_R * cos(60), RING_R * sin(60)],
    [RING_R * cos(120), RING_R * sin(120)],
    [RING_R * cos(180), RING_R * sin(180)],
    [RING_R * cos(240), RING_R * sin(240)],
    [RING_R * cos(300), RING_R * sin(300)],
];

module hex_prism(size, height) {
    r = size / 2;
    linear_extrude(height = height, center = false)
        polygon([for (a = [0 : 60 : 300]) [r * cos(a), r * sin(a)]]);
}

module venturi_funnel() {
    cylinder(h = converge_len, r1 = r_in, r2 = r_th, $fn = 64);
    translate([0, 0, converge_len])
        cylinder(h = THROAT_LEN, r = r_th, $fn = 64);
    translate([0, 0, converge_len + THROAT_LEN])
        cylinder(h = diverge_len, r1 = r_th, r2 = r_out, $fn = 64);
}

difference() {
    hex_prism(TILE_SIZE, TILE_THICKNESS);
    for (i = [0 : len(FUNNELS) - 1]) {
        translate([FUNNELS[i][0], FUNNELS[i][1], -0.01])
            venturi_funnel();
    }
    translate([0, 0, AVAIL_DEPTH - 0.01])
        hex_prism(CHAMBER_INNER_SIZE, CHAMBER_DEPTH + 0.02);
    translate([0, CHAMBER_INNER_SIZE / 2 * cos(30) + 0.5, 0])
        cylinder(h = TILE_THICKNESS, d = FILL_PORT_D, $fn = 32);
}
