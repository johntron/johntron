//N = 16;  // Number of rollers
//Rr = 6.5;  // Radius of the roller
//R = 4.5;   // Radius of the rollers PCD (Pitch Circle Diameter)
//E = 1.5;   // Eccentricity - offset from input shaft to a cycloidal disk
//function x(t) = 
//    (R*cos(t)) - 
//    (Rr*cos(t + atan(sin((1-N)*t) / ((R/(E*N)) - cos((1-N)*t))))) - 
//    (E*cos(N*t));
//
//function y(t) = 
//    (-R*sin(t)) + 
//    (Rr*sin(t + atan(sin((1-N)*t) / ((R/(E*N)) - cos((1-N)*t))))) + 
//    (E*sin(N*t));


/* [Epitrochoid (cycloid)] */
// Radius of large circle
R = 11;

// Radius of small circle
r = 1;

// Offset from small circle's center on which the cycloid is traced
d = 0.5;


function x(t) = (R + r) * cos(t) - d * cos( t * (R + r) / r );
function y(t) = (R + r) * sin(t) - d * sin( t * (R + r) / r );

points = [ for (t = [ 0 : 3 : 359 ])  [x(t), y(t)] ];

//echo(points);

linear_extrude(height=1) {
    offset(r=-1)
    polygon(points);
}