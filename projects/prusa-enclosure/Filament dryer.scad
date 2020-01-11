include <BOSL2/std.scad>
include <BOSL2/skin.scad>
include <NopSCADlib/lib.scad>

filament_diameter = 1.75;
heat_block_thickness = 10;
tec_module_dimensions = [3.9, 40, 40];
heatsink_profile_dxf = "./Heatsink profile.dxf";
heatsink_height = dxf_dim(file=heatsink_profile_dxf, layer="Dimensions", name="Height");
fan_type = fan40x11;
fan_width = fan_width(fan_type);
fan_depth = fan_depth(fan_type);

// part origins are front, bottom, left - the [-x,-y,-z] direction

module heat_block() {
    dimensions = [heat_block_thickness, tec_module_dimensions.y, tec_module_dimensions.z];
    
    module channel() {
        cylinder(d=filament_diameter, h=tec_module_dimensions.z);
    }
    
    module block() {
        cube(dimensions);
    }
    
    function channel_offset() = vmul(dimensions / 2, [1, 1, 0]);
    
    difference() {
        block();
        translate(channel_offset()) channel();
    }
}

module tec() {
    cube(tec_module_dimensions);
}

module condensing_heatsink() {
    linear_extrude(tec_module_dimensions.z) import(heatsink_profile_dxf);
}

module circulator() {
    offset_xy = [0.5, 0.5, 0] * fan_width;
    offset_z = [0, 0, 0.5] * fan_depth;
    translate(offset_xy + offset_z) fan(fan_type);
}

module duct() {
    module channel() {
        skin([
            for (ang = [0:10:90])
                rot([0, ang, 0], p=path3d(square(tec_module_dimensions.y)))
        ]);
    }
    module part() {
        difference() {
            minkowski() {
                cube(1, center=true);
                channel();
            };
            channel();
        }
    }
    
    right(tec_module_dimensions.y) 
    yrot(180) 
    part();            
}


function heat_block_offset() = vmul(tec_module_dimensions, [1, 0, 0]);
function heatsink_orientation() = [0, 0, 90];
function circulator_transform() = right(tec_module_dimensions.x + heat_block_thickness) * up(tec_module_dimensions.z + fan_width) * yrot(90);

function duct_offset() = left(heatsink_height) * up(tec_module_dimensions.z);

tec();
translate(heat_block_offset()) heat_block();
rotate(heatsink_orientation()) condensing_heatsink();
multmatrix(circulator_transform()) circulator();
multmatrix(duct_offset())
duct();