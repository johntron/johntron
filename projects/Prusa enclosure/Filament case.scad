include <BOSL2/std.scad>

angle = 15;
extrusion_length_short = 120;
extrusion_length_long = 205;
frame_thickness = 6;
offset_distance = 10;
enclosure_printer_offset = ([2, 2, 2] * offset_distance);
spool_count = 5;
spool_radius = 102;
spool_height = 74;
//spool_ramp_length = printer_dimensions.y - spool_radius * 2;
//spool_ramp_angle = 15;
frame_dxf = "Original-Prusa-i3-MK3S/Frame/MK3v8b - modified.dxf";

module printer() {
    width = dxf_dim(file=frame_dxf, name="Center width", layer="Dim", origin=[0, 0], scale=1);
    height = dxf_dim(file=frame_dxf, name="Center height", layer="Dim", origin=[0, 0], scale=1);
    depth = (frame_thickness * 3) + extrusion_length_long + extrusion_length_short;

    module extents() {
      cube([width, depth, height]);
    }
    
    module front_plate() {
      linear_extrude(frame_thickness) import(frame_dxf, layer="Front");
    }
    
    module center_plate() {
      linear_extrude(frame_thickness) import(frame_dxf, layer="Center");
    }
    
    module rear_plate() {
      linear_extrude(frame_thickness) import(frame_dxf, layer="Rear");
    }

    module frame_components() {
      down(frame_thickness) front_plate();
      down(frame_thickness + extrusion_length_long + frame_thickness) center_plate();
      down(frame_thickness + extrusion_length_long + frame_thickness + extrusion_length_short + frame_thickness) rear_plate();
    }
    
    #extents();
    right(width / 2) xrot(90) frame_components();
}

module spool_arrays() {
    module spool() {
        zcyl(h=spool_height, r=spool_radius, anchor=BOTTOM);
    }

    module spool_array_front() {
        zspread(spacing=offset_distance + spool_height, n=3, sp=[0, 0, 0]) {
            spool();
            spool();
            spool();
        }
    }

    module spool_array_back() {
        zspread(spacing=offset_distance + spool_height, n=2, sp=[0, 0, 0]) {
            spool();
            spool();
        }
    }

    //    function spool_ramp_y() = cos(spool_ramp_angle) * spool_ramp_length;
    //    function spool_ramp_z() = sin(spool_ramp_angle) * spool_ramp_length;
    //    function spool_max_offset() = [0, spool_ramp_y(), spool_ramp_z()];
    //    function spool_array_dimensions() = [
    //        (spool_height * spool_count) + (offset_distance * spool_count - 1), spool_radius * 2 + spool_ramp_y(),
    //        spool_radius * 2 + spool_ramp_z()
    //    ];
    //
    //    module spool_array_bounding_box() {
    //        hull() {
    //            children();
    //            translate(spool_max_offset()) children();
    //        }
    //    }

    module position_spool_array_front_to_printer() {
        trans = affine3d_translate([printer_dimensions.x / 2, -printer_dimensions.y / 2, printer_dimensions.z - spool_radius]);
        rot = affine3d_xrot(-90);
        multmatrix(trans * rot) children();
    }

    module position_spool_array_back_to_printer() {
        trans = affine3d_translate([printer_dimensions.x / 2, offset_distance + printer_dimensions.y / 2, printer_dimensions.z - spool_radius]);
        rot = affine3d_xrot(-90);
        multmatrix(trans * rot) children();
    }
    
    position_spool_array_front_to_printer() spool_array_front();
    position_spool_array_back_to_printer()  spool_array_back();
}

module enclosure() {
    cube(printer_dimensions + enclosure_printer_offset);
}

color("magenta", 1) spool_arrays();
color("cyan", 0.5) printer();
//color("yellow", 0.25) enclosure();
