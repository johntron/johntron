use <keystone.scad>;

number_of_keystones = 1;
space_between_keystones = 23;

module panel() {
    for (i = [0 : number_of_keystones - 1]) {
        translate([0, i * space_between_keystones, 0])
            keystone();
    }
}

module frame() {
    difference() {
        difference() {
            translate([0, 0, - 50])
                cube([30.5, 24.91671 * number_of_keystones, 50]);
            translate([2.5, 2.5, - 50])
                cube([25, (24.91671 * number_of_keystones) - 4, 50]);
        }
        translate([-10, 2.5, -40])
            cube([25, 295, 40]);
    }
}

panel();
//frame();
