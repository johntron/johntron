include <BOSL2/std.scad>

box = [315, 280, 70];
item = [245, 245, box.z];
spacer_overhang = 15;

min_extents = (box - item) / 2;
max_extents = add_scalar(min_extents, spacer_overhang);

chamfer_size = min(min_extents.x, min_extents.y);

echo(min_extents);
echo(max_extents);

module spacer_polygon() {
    polygon(points = [
        // counterclockwise from outside corner
            [chamfer_size, 0], // origin - outside corner
            [max_extents.x, 0], // outside
            [max_extents.x, min_extents.y], // inside, end of spacer
            [min_extents.x, min_extents.y], // inner corner
            [min_extents.x, max_extents.y], // inside, end of spacer
            [0, max_extents.y], // outside
            [0, chamfer_size]
        ]);
}

module spacer() {
    linear_extrude(height = box.z)
        spacer_polygon();
}

module spacer_bottom_left() {
    spacer();
}

module spacer_bottom_right() {
    xflip(x=box.x / 2)
    spacer();
}

module spacer_top_left() {
    yflip(y=box.y / 2)
    spacer();
}

module spacer_top_right() {
    yflip(y=box.y / 2)
    xflip(x=box.x / 2)
    spacer();
}

module all_spacers() {
    spacer_bottom_left();
//    spacer_bottom_right();
//    spacer_top_left();
//    spacer_top_right();
}

all_spacers();