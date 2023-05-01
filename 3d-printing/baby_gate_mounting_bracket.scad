clearance = 0.254;

extruder_diameter = 0.8;

bracket_thickness = 10;
gate_head_slot_thickness = 2;
gate_head_thickness = 3.5;
gate_head_diameter = 20.2;
gate_socket_outer_slope_degrees = 45;
gate_socket_outer_diameter_gate_side = 30;

module gate_socket() {
gate_socket_outer_height = gate_head_slot_thickness + gate_head_thickness;
gate_socket_outer_diameter_mounting_side = gate_socket_outer_diameter_gate_side + (2 * gate_socket_outer_height * cos(gate_socket_outer_slope_degrees));

    module outer_shell() {
        boss_outer_diameter_gate_side = 30;
        cylinder(
            h=gate_socket_outer_height,
            r1=gate_socket_outer_diameter_gate_side / 2,
            r2=gate_socket_outer_diameter_mounting_side / 2
        );
    }

    module top_cut() {
        translate([-gate_socket_outer_diameter_mounting_side / 2, 0 ,0])
        cube(gate_socket_outer_diameter_mounting_side);
    }

    module inner_cut() {
        module gate_head_slot_cut() {
            // the smallest cylindrical cut near outermost surface
        };
        cylinder(h=1, r=1);
        cylinder(h=1, r=1);
    }

    difference() {
        outer_shell();
        top_cut();
        inner_cut();
    };
}

gate_socket();
