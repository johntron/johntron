width = 105;
depth = 100;
height = 10;
//svg = "nested-output.svg";
svg = "/home/johntron/Downloads/Page 1 (2).svg";

difference() {
    //linear_extrude(height)
    //    square([width, depth]);
    //translate([10, 300, 0])
    linear_extrude(height+20, center = true)
        import(svg);
}