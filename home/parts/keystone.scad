// all dimensions are in millimeters

// major dimension for keystone hole, width
keystone_width = 14.5;
// major dimension for keystone hole, height
keystone_height = 16;

// clearance around hole
boss_clearance = 0.25;
// margin aroudn keystone hole
boss_margin = 5;
boss_inner_width = keystone_width + boss_clearance;
boss_inner_height = keystone_height + boss_clearance;
boss_outer_width = keystone_width + boss_margin * 2;
boss_outer_height = keystone_height + boss_margin * 2;
// depth of the solid frame around the keystone hole
boss_depth = 9.8;

// major dimension of fixed tab as viewed from side of connector (square with a corner cut off)
fixed_tab_size = 1.5;
fixed_tab_depth_from_panel_face = 6.28;

module boss() {
    module basic_frame() {
        color([1, 1, 1])
            difference() {
                cube([boss_outer_width, boss_depth, boss_outer_height]);
                translate([boss_margin, 0, boss_margin])
                    cube([boss_inner_width, boss_depth, boss_inner_height]);
            }
    }

    module clearance_for_fixed_tab() {
        translate([boss_margin, fixed_tab_depth_from_panel_face, boss_margin])
        rotate([0, 90, 0])
        linear_extrude(height=boss_inner_width)
        // polygon drawn as viewed from side of keystone connector (triangular-ish face)
        polygon(points=[[0, 0], [0, fixed_tab_size], [fixed_tab_size, fixed_tab_size], [fixed_tab_size, fixed_tab_size / 2], [fixed_tab_size / 2, 0]]);
    }

    module clearances() {
        clearance_for_fixed_tab();
    }

    difference() {
        basic_frame();
        clearances();
    }
}

module keystone() {
    boss();
}

keystone();