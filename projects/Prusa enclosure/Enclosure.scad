include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/skin.scad>

extrusion_length_short = 120;
extrusion_length_long = 205;
frame_thickness = 6;
offset_distance = 10;
clearance_for_bed_and_heater_cable = 100;
clearance_for_extruder_and_filament = 100;
clearance_for_y_axis = 50;
enclosure_printer_offset = ([2, 2, 2] * offset_distance);
window_material_width = 406.4; // 16in
window_material_thickness = 4.7625; // 3/16 in
window_inner_radius = 40;
top_thickness = 20;
bottom_thickness = 40;
frame_dxf = "Original-Prusa-i3-MK3S/Frame/MK3v8b - modified.dxf";
leg_height = 700;
leg_bottom_xy_dimension = 50;
leg_upper_xy_dimension = 75;
leg_taper = 3.5;
power_supply_dimensions = [100, 204, 50]; // These are different (larger) than Meanwell SP-240-24 dimensions - measure!
clearance_for_psu_power_panic_module = 50;

function printer_width() = dxf_dim(file=frame_dxf, name="Center width", layer="Dim", origin=[0, 0], scale=1);
function printer_height() = dxf_dim(file=frame_dxf, name="Center height", layer="Dim", origin=[0, 0], scale=1);
function printer_depth() = (frame_thickness * 3) 
  + extrusion_length_long
  + extrusion_length_short;
function printer_extents() = [
  printer_width() + clearance_for_y_axis,
  printer_depth() + clearance_for_bed_and_heater_cable,
  printer_height() + clearance_for_extruder_and_filament
];
bottom_lip_depth = printer_extents().z - window_material_width;
min_xy_extents = vmul(printer_extents() + enclosure_printer_offset, [1, 1, 0]);

module printer() {
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
    
    module power_supply() {
        cube(power_supply_dimensions);
    }
    
  //  #cube(printer_extents());    
//    right(clearance_for_y_axis + printer_width() / 2) xrot(90) frame_components();
    power_supply();
}

module enclosure() {
    inner_path = round_corners(path=square(min_xy_extents + [clearance_for_y_axis, 0, 0]), curve="circle", measure="radius", size=window_inner_radius);

    module top() {
      linear_extrude(top_thickness) offset(window_material_thickness) polygon(inner_path);
    }

    module window() {
        module cross_section() {
            difference() {
                offset(window_material_thickness) polygon(inner_path);
                polygon(inner_path);
            }
        }
        linear_extrude(window_material_width) cross_section();
    }

    module lip() {
      linear_extrude(bottom_lip_depth) difference() {
        offset(window_material_thickness) polygon(inner_path);
        polygon(inner_path);
      };
    }
    
    module bottom() {
      up(bottom_thickness) lip();
      linear_extrude(bottom_thickness) offset(window_material_thickness) polygon(inner_path);
    }

    module base() {
      lip();
    }

    up(printer_extents().z + bottom_thickness + bottom_lip_depth) top();
    color(alpha=0.25) up(bottom_thickness + bottom_lip_depth + bottom_lip_depth) window();
    up(bottom_lip_depth) bottom();
    base();
}

base_extents = min_xy_extents + [clearance_for_y_axis, 0, 0];
module legs() {
  leg_upper_width = leg_bottom_xy_dimension + (sin(leg_taper) * leg_height);
  leg_upper_x_offset = sin(leg_taper) * leg_height;

  module leg() {
    function lower_square() = path3d(square(leg_bottom_xy_dimension));
    function upper_square_transform(sq) = back(leg_upper_x_offset, p=right(leg_upper_x_offset, p=sq));
    function upper_square() = path3d(upper_square_transform(square(leg_upper_xy_dimension)), leg_height);

    skin([
        lower_square(),
        upper_square(),
    ], method="distance");
  }

  leg();
  translate(base_extents) zrot(180) leg();
  translate(vmul(base_extents, [0, 1, 0])) zrot(-90) leg();
  translate(vmul(base_extents, [1, 0, 0])) zrot(90) leg();
}

function origin_to_enclosure_bottom() = leg_height - bottom_lip_depth;
function origin_to_printer_bottom() = leg_height + bottom_thickness;

up(origin_to_printer_bottom()) color("cyan") translate(enclosure_printer_offset / 2) printer();
//up(origin_to_enclosure_bottom()) enclosure();
//legs();
