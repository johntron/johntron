include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/skin.scad>

/* [Prusa i3 settings] */
// Modified from Prusa's dxf to include all parts in one file aligned to origin on separate layers
frame_dxf = "MK3v8b - modified.dxf";
extrusion_length_short = 120;
extrusion_length_long = 205;
// The three metal plates
frame_thickness = 6;
// Additional space behind printer in mm (y-axis)
clearance_for_bed_and_heater_cable = 100;
// Additional space above printer in mm (z-axis)
clearance_for_extruder_and_filament = 50;
// Additional space on left side for Prusa's y-axis motor mount in mm (x-axis for this scad file)
clearance_for_y_axis = 50;

/* [Enclosure settings] */
// Minimum space to keep around extents of printer
enclosure_printer_offset = 10;
window_material_thickness = 6.35; // 1/4 in
// Width of plastic sheet in mm. After bending the material, this would be the height of the window
window_material_width = 350;
// Millimeters
window_inner_radius = 90;
enclosure_bottom_height = 100;
enclosure_top_height = 20;
// The piece you set the printer on
enclosure_floor_thickness = 40;

/* [Base settings] */
leg_height = 700;
// Dimensions of *square* cross-section at bottom of leg in mm
leg_bottom_xy_dimension = 50;
// Dimensions of *square* cross-section at top of leg in mm
leg_upper_xy_dimension = 70;
// Degrees
leg_taper = 3.5;

/* [PSU settings] */
psu_dimensions = [204, 100, 50]; // These are different (larger) than Meanwell SP-240-24 dimensions - measure!
clearance_for_psu_power_panic_module = 50;

/* [Filtration settings] */
fan_extents = [140, 140, 25];

printer_width = dxf_dim(file=frame_dxf, name="Center width", layer="Dim", origin=[0, 0], scale=1);
printer_height = dxf_dim(file=frame_dxf, name="Center height", layer="Dim", origin=[0, 0], scale=1);
printer_depth = (frame_thickness * 3) 
  + extrusion_length_long
  + extrusion_length_short;
printer_extents = [
  printer_width + clearance_for_y_axis,
  printer_depth + clearance_for_bed_and_heater_cable,
  printer_height + clearance_for_extruder_and_filament
];
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
    
    #cube(printer_extents);    
    right(clearance_for_y_axis + printer_width / 2) xrot(90) frame_components();
}

enclosure_window_height = printer_extents.z;
enclosure_underside_inset_height = enclosure_bottom_height - enclosure_floor_thickness;
enclosure_internal_extents = (printer_extents + [clearance_for_y_axis, 0, 0]) + ([1, 1, 1] * enclosure_printer_offset);
enclosure_extents = enclosure_internal_extents
  + ([2, 2, 0] * window_material_thickness)
  + [0, 0, enclosure_top_height + enclosure_window_height + enclosure_bottom_height];
module enclosure() {
    inner_path = round_corners(path=square(enclosure_internal_extents), curve="circle", measure="radius", size=window_inner_radius);
    outer_path = offset(inner_path, delta=window_material_thickness);
    echo("Minimum length of window material in mm", path_length(outer_path, closed=true));

    module top() {
      linear_extrude(enclosure_top_height) polygon(outer_path);
    }

    module window() {
        module cross_section() {
            difference() {
                polygon(outer_path);
                polygon(inner_path);
            }
        }
        linear_extrude(enclosure_window_height) cross_section();
    }

    module bottom() {
      module trim() {
        linear_extrude(enclosure_bottom_height) difference() {
          polygon(outer_path);
          polygon(inner_path);
        };
      }

      module floor() {
        linear_extrude(enclosure_floor_thickness) polygon(inner_path);
      }
      
      trim();
      up(enclosure_bottom_height - enclosure_floor_thickness) floor();
    }

    up(enclosure_window_height + enclosure_bottom_height) top();
    color(alpha=0.25) up(enclosure_bottom_height) window();
    bottom();
}

module base() {
  leg_upper_width = leg_bottom_xy_dimension + (sin(leg_taper) * leg_height);
  leg_upper_x_offset = sin(leg_taper) * leg_height;

  module leg() {
    function lower_square() = path3d(square(leg_bottom_xy_dimension));
    function upper_square_transform(sq) = right(leg_upper_x_offset, p=back(leg_upper_x_offset, p=sq));
    function upper_square() = path3d(upper_square_transform(square(leg_upper_xy_dimension)), leg_height);

    skin([
        lower_square(),
        upper_square(),
    ], method="distance");
  }

  leg();
  translate(vmul(enclosure_extents, [0, 1, 0])) zrot(-90) leg();
  translate(vmul(enclosure_extents, [1, 1, 0])) zrot(180) leg();
  translate(vmul(enclosure_extents, [1, 0, 0])) zrot(90) leg();
}

power_supply_extents = psu_dimensions + [clearance_for_psu_power_panic_module, 0, 0];
module power_supply() {
  cube(power_supply_extents);
}

module filtration() {
  cube(fan_extents);
}


origin_to_enclosure_underside_ceiling = [0, 0, leg_height - enclosure_underside_inset_height];
origin_to_printer = [window_material_thickness, window_material_thickness, leg_height + enclosure_floor_thickness];

//translate(origin_to_printer) printer();
#translate(origin_to_enclosure_underside_ceiling) enclosure();
filtration();
//base();
