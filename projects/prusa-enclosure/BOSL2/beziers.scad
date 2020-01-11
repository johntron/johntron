//////////////////////////////////////////////////////////////////////
// LibFile: beziers.scad
//   Bezier functions and modules.
//   To use, add the following lines to the beginning of your file:
//   ```
//   include <BOSL2/std.scad>
//   include <BOSL2/beziers.scad>
//   ```
//////////////////////////////////////////////////////////////////////


include <BOSL2/vnf.scad>


// Section: Terminology
//   **Polyline**: A series of points joined by straight line segements.
//   
//   **Bezier Curve**: A mathematical curve that joins two endpoints, following a curve determined by one or more control points.
//   
//   **Endpoint**: A point that is on the end of a bezier segment.  This point lies on the bezier curve.
//   
//   **Control Point**: A point that influences the shape of the curve that connects two endpoints.  This is often *NOT* on the bezier curve.
//   
//   **Degree**: The number of control points, plus one endpoint, needed to specify a bezier segment.  Most beziers are cubic (degree 3).
//   
//   **Bezier Segment**: A list consisting of an endpoint, one or more control points, and a final endpoint.  The number of control points is one less than the degree of the bezier.  A cubic (degree 3) bezier segment looks something like:
//       `[endpt1, cp1, cp2, endpt2]`
//   
//   **Bezier Path**: A list of bezier segments flattened out into a list of points, where each segment shares the endpoint of the previous segment as a start point. A cubic Bezier Path looks something like:
//       `[endpt1, cp1, cp2, endpt2, cp3, cp4, endpt3]`
//   **NOTE**: A bezier path is *NOT* a polyline.  It is only the points and controls used to define the curve.
//   
//   **Bezier Patch**: A surface defining grid of (N+1) by (N+1) bezier points.  If a Bezier Segment defines a curved line, a Bezier Patch defines a curved surface.
//   
//   **Bezier Surface**: A surface defined by a list of one or more bezier patches.
//   
//   **Spline Steps**: The number of straight-line segments to split a bezier segment into, to approximate the bezier curve.  The more spline steps, the closer the approximation will be to the curve, but the slower it will be to generate.  Usually defaults to 16.


// Section: Segment Functions

// Function: bez_point()
// Usage:
//   bez_point(curve, u)
// Description:
//   Formula to calculate points on a bezier curve.  The degree of
//   the curve, N, is one less than the number of points in `curve`.
// Arguments:
//   curve = The list of endpoints and control points for this bezier segment.
//   u = The proportion of the way along the curve to find the point of.  0<=`u`<=1
// Example(2D): Quadratic (Degree 2) Bezier.
//   bez = [[0,0], [30,30], [80,0]];
//   trace_bezier(bez, N=len(bez)-1);
//   translate(bez_point(bez, 0.3)) color("red") sphere(1);
// Example(2D): Cubic (Degree 3) Bezier
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   trace_bezier(bez, N=len(bez)-1);
//   translate(bez_point(bez, 0.4)) color("red") sphere(1);
// Example(2D): Degree 4 Bezier.
//   bez = [[0,0], [5,15], [40,20], [60,-15], [80,0]];
//   trace_bezier(bez, N=len(bez)-1);
//   translate(bez_point(bez, 0.8)) color("red") sphere(1);
function bez_point(curve,u)=
	(len(curve) <= 1) ?
		curve[0] :
		bez_point(
			[for(i=[0:1:len(curve)-2]) curve[i]*(1-u)+curve[i+1]*u],
			u
		);


// Function: bezier_curve()
// Usage:
//   bezier_curve(curve, n);
// Description:
//   Takes a list of bezier curve control points, and a count of path points to generate.  The points
//   returned will be along the curve, starting at the first control point, then about every `1/n`th
//   of the way along the curve, ending about `1/n`th of the way *before* the final control point.
//   The distance between the points will *not* be equidistant.  The degree of the curve, N, is one
//   less than the number of points in `curve`.
// Arguments:
//   curve = The list of endpoints and control points for this bezier segment.
//   n = The number of points to generate along the bezier curve.
// Example(2D): Quadratic (Degree 2) Bezier.
//   bez = [[0,0], [30,30], [80,0]];
//   place_copies(bezier_curve(bez, 16)) sphere(r=1);
//   trace_bezier(bez, N=len(bez)-1);
// Example(2D): Cubic (Degree 3) Bezier
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   place_copies(bezier_curve(bez, 16)) sphere(r=1);
//   trace_bezier(bez, N=len(bez)-1);
// Example(2D): Degree 4 Bezier.
//   bez = [[0,0], [5,15], [40,20], [60,-15], [80,0]];
//   place_copies(bezier_curve(bez, 16)) sphere(r=1);
//   trace_bezier(bez, N=len(bez)-1);
function bezier_curve(curve,n) = [for(i=[0:1:n-1]) bez_point(curve, i/(n-1))];


// Function: bezier_segment_closest_point()
// Usage:
//   bezier_segment_closest_point(bezier,pt)
// Description:
//   Finds the closest part of the given bezier segment to point `pt`.
//   The degree of the curve, N, is one less than the number of points in `curve`.
//   Returns `u` for the shortest position on the bezier segment to the given point `pt`.
// Arguments:
//   curve = The list of endpoints and control points for this bezier segment.
//   pt = The point to find the closest curve point to.
//   max_err = The maximum allowed error when approximating the closest approach.
// Example(2D):
//   pt = [40,15];
//   bez = [[0,0], [20,40], [60,-25], [80,0]];
//   u = bezier_segment_closest_point(bez, pt);
//   trace_bezier(bez, N=len(bez)-1);
//   color("red") translate(pt) sphere(r=1);
//   color("blue") translate(bez_point(bez,u)) sphere(r=1);
function bezier_segment_closest_point(curve, pt, max_err=0.01, u=0, end_u=1) = 
	let(
		steps = len(curve)*3,
		path = [for (i=[0:1:steps]) let(v=(end_u-u)*(i/steps)+u) [v, bez_point(curve, v)]],
		bracketed = concat([path[0]], path, [path[len(path)-1]]),
		minima_ranges = [
			for (pts = triplet(bracketed)) let(
				d1=norm(pts.x.y-pt),
				d2=norm(pts.y.y-pt),
				d3=norm(pts.z.y-pt)
			) if(d2<=d1 && d2<=d3) [pts.x.x,pts.z.x]
		]
	) len(minima_ranges)>1? (
		let(
			min_us = [
				for (minima = minima_ranges)
					bezier_segment_closest_point(curve, pt, max_err=max_err, u=minima.x, end_u=minima.y)
			],
			dists = [for (v=min_us) norm(bez_point(curve,v)-pt)],
			min_i = min_index(dists)
		) min_us[min_i]
	) : let(
		minima = minima_ranges[0],
		p1 = bez_point(curve, minima.x),
		p2 = bez_point(curve, minima.y),
		err = norm(p2-p1)
	) err<max_err? mean(minima) :
	bezier_segment_closest_point(curve, pt, max_err=max_err, u=minima.x, end_u=minima.y);




// Function: bezier_segment_length()
// Usage:
//   bezier_segment_length(curve, [start_u], [end_u], [max_deflect]);
// Description:
//   Approximates the length of the bezier segment between start_u and end_u.
// Arguments:
//   curve = The list of endpoints and control points for this bezier segment.
//   start_u = The proportion of the way along the curve to start measuring from.  Between 0 and 1.
//   end_u = The proportion of the way along the curve to end measuring at.  Between 0 and 1.  Greater than start_u.
//   max_deflect = The largest amount of deflection from the true curve to allow for approximation.
// Example:
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   echo(bezier_segment_length(bez));
function bezier_segment_length(curve, start_u=0, end_u=1, max_deflect=0.01) =
	let(
		mid_u=lerp(start_u, end_u, 0.5),
		sp = bez_point(curve,start_u),
		bez_mp = bez_point(curve,mid_u),
		ep = bez_point(curve,end_u),
		lin_mp = lerp(sp,ep,0.5),
		defl = norm(bez_mp-lin_mp)
	)
	((end_u-start_u) >= 0.125 || defl > max_deflect)? (
		bezier_segment_length(curve, start_u, mid_u, max_deflect) +
		bezier_segment_length(curve, mid_u, end_u, max_deflect)
	) : norm(ep-sp);



// Function: fillet3pts()
// Usage:
//   fillet3pts(p0, p1, p2, r);
// Description:
//   Takes three points, defining two line segments, and works out the
//   cubic (degree 3) bezier segment (and surrounding control points)
//   needed to approximate a rounding of the corner with radius `r`.
//   If there isn't room for a radius `r` rounding, uses the largest
//   radius that will fit.  Returns [cp1, endpt1, cp2, cp3, endpt2, cp4]
// Arguments:
//   p0 = The starting point.
//   p1 = The middle point.
//   p2 = The ending point.
//   r = The radius of the fillet/rounding.
//   maxerr = Max amount bezier curve should diverge from actual radius curve.  Default: 0.1
// Example(2D):
//   p0 = [40, 0];
//   p1 = [0, 0];
//   p2 = [30, 30];
//   trace_polyline([p0,p1,p2], showpts=true, size=0.5, color="green");
//   fbez = fillet3pts(p0,p1,p2, 10);
//   trace_bezier(slice(fbez, 1, -2), size=1);
function fillet3pts(p0, p1, p2, r, maxerr=0.1, w=0.5, dw=0.25) = let(
		v0 = normalize(p0-p1),
		v1 = normalize(p2-p1),
		midv = normalize((v0+v1)/2),
		a = vector_angle(v0,v1),
		tanr = min(r/tan(a/2), norm(p0-p1)*0.99, norm(p2-p1)*0.99),
		tp0 = p1+v0*tanr,
		tp1 = p1+v1*tanr,
		cp = p1 + midv * tanr / cos(a/2),
		cp0 = lerp(tp0, p1, w),
		cp1 = lerp(tp1, p1, w),
		cpr = norm(cp-tp0),
		bp = bez_point([tp0, cp0, cp1, tp1], 0.5),
		tdist = norm(cp-bp)
	) (abs(tdist-cpr) <= maxerr)? [tp0, tp0, cp0, cp1, tp1, tp1] :
		(tdist<cpr)? fillet3pts(p0, p1, p2, r, maxerr=maxerr, w=w+dw, dw=dw/2) :
		fillet3pts(p0, p1, p2, r, maxerr=maxerr, w=w-dw, dw=dw/2);



// Section: Path Functions


// Function: bezier_path_point()
// Usage:
//   bezier_path_point(path, seg, u, [N])
// Description: Returns the coordinates of bezier path segment `seg` at position `u`.
// Arguments:
//   path = A bezier path to approximate.
//   seg = Segment number along the path.  Each segment is N points long.
//   u = The proportion of the way along the segment to find the point of.  0<=`u`<=1
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
function bezier_path_point(path, seg, u, N=3) = bez_point(select(path,seg*N,(seg+1)*N), u);



// Function: bezier_path_closest_point()
// Usage:
//   bezier_path_closest_point(bezier,pt)
// Description:
//   Finds the closest part of the given bezier path to point `pt`.
//   Returns [segnum, u] for the closest position on the bezier path to the given point `pt`.
// Arguments:
//   path = A bezier path to approximate.
//   pt = The point to find the closest curve point to.
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
//   max_err = The maximum allowed error when approximating the closest approach.
// Example(2D):
//   pt = [100,0];
//   bez = [[0,0], [20,40], [60,-25], [80,0], [100,25], [140,25], [160,0]];
//   pos = bezier_path_closest_point(bez, pt);
//   xy = bezier_path_point(bez,pos[0],pos[1]);
//   trace_bezier(bez, N=3);
//   color("red") translate(pt) sphere(r=1);
//   color("blue") translate(xy) sphere(r=1);
function bezier_path_closest_point(path, pt, N=3, max_err=0.01, seg=0, min_seg=undef, min_u=undef, min_dist=undef) =
	let(curve = select(path,seg*N,(seg+1)*N))
	(seg*N+1 >= len(path))? (
		let(curve = select(path, min_seg*N, (min_seg+1)*N))
		[min_seg, bezier_segment_closest_point(curve, pt, max_err=max_err)]
	) : (
		let(
			curve = select(path,seg*N,(seg+1)*N),
			u = bezier_segment_closest_point(curve, pt, max_err=0.05),
			dist = norm(bez_point(curve, u)-pt),
			mseg = (min_dist==undef || dist<min_dist)? seg : min_seg,
			mdist = (min_dist==undef || dist<min_dist)? dist : min_dist,
			mu = (min_dist==undef || dist<min_dist)? u : min_u
		)
		bezier_path_closest_point(path, pt, N, max_err, seg+1, mseg, mu, mdist)
	);



// Function: bezier_path_length()
// Usage:
//   bezier_path_length(path, [N], [max_deflect]);
// Description:
//   Approximates the length of the bezier path.
// Arguments:
//   path = A bezier path to approximate.
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
//   max_deflect = The largest amount of deflection from the true curve to allow for approximation.
function bezier_path_length(path, N=3, max_deflect=0.001) =
	sum([
		for (seg=[0:1:(len(path)-1)/N-1]) (
			bezier_segment_length(
				select(path, seg*N, (seg+1)*N),
				max_deflect=max_deflect
			)
		)
	]);



// Function: bezier_polyline()
// Usage:
//   bezier_polyline(bezier, [splinesteps], [N])
// Description:
//   Takes a bezier path and converts it into a polyline.
// Arguments:
//   bezier = A bezier path to approximate.
//   splinesteps = Number of straight lines to split each bezier segment into. default=16
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
// Example(2D):
//   bez = [
//       [0,0], [-5,30],
//       [20,60], [50,50], [110,30],
//       [60,25], [70,0], [80,-25],
//       [80,-50], [50,-50]
//   ];
//   trace_polyline(bez, size=1, N=3, showpts=true);
//   trace_polyline(bezier_polyline(bez, N=3), size=3);
function bezier_polyline(bezier, splinesteps=16, N=3) = let(
		segs = (len(bezier)-1)/N
	) concat(
		[for (seg = [0:1:segs-1], i = [0:1:splinesteps-1]) bezier_path_point(bezier, seg, i/splinesteps, N=N)],
		[bezier_path_point(bezier, segs-1, 1, N=N)]
	);



// Function: fillet_path()
// Usage:
//   fillet_path(pts, fillet, [maxerr]);
// Description:
//   Takes a 3D polyline path and fillets the corners, returning a 3d cubic (degree 3) bezier path.
// Arguments:
//   pts = 3D Polyline path to fillet.
//   fillet = The radius to fillet/round the polyline corners by.
//   maxerr = Max amount bezier curve should diverge from actual radius curve.  Default: 0.1
// Example(2D):
//   pline = [[40,0], [0,0], [35,35], [0,70], [-10,60], [-5,55], [0,60]];
//   bez = fillet_path(pline, 10);
//   trace_polyline(pline, showpts=true, size=0.5, color="green");
//   trace_bezier(bez, size=1);
function fillet_path(pts, fillet, maxerr=0.1) = concat(
	[pts[0], pts[0]],
	(len(pts) < 3)? [] : [
		for (p = [1:1:len(pts)-2]) let(
			p1 = pts[p],
			p0 = (pts[p-1]+p1)/2,
			p2 = (pts[p+1]+p1)/2
		) for (pt = fillet3pts(p0, p1, p2, fillet, maxerr=maxerr)) pt
	],
	[pts[len(pts)-1], pts[len(pts)-1]]
);


// Function: bezier_close_to_axis()
// Usage:
//   bezier_close_to_axis(bezier, [N], [axis]);
// Description:
//   Takes a 2D bezier path and closes it to the specified axis.
// Arguments:
//   bezier = The 2D bezier path to close to the axis.
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
//   axis = The axis to close to, "X", or "Y".  Default: "X"
// Example(2D):
//   bez = [[50,30], [40,10], [10,50], [0,30], [-10, 10], [-30,10], [-50,20]];
//   closed = bezier_close_to_axis(bez);
//   trace_bezier(closed, size=1);
// Example(2D):
//   bez = [[30,50], [10,40], [50,10], [30,0], [10, -10], [10,-30], [20,-50]];
//   closed = bezier_close_to_axis(bez, axis="Y");
//   trace_bezier(closed, size=1);
function bezier_close_to_axis(bezier, N=3, axis="X") =
	let(
		bezend = len(bezier)-1,
		sp = bezier[0],
		ep = bezier[bezend]
	) (axis=="X")? concat(
		[for (i=[0:1:N-1]) lerp([sp.x,0], sp, i/N)],
		bezier,
		[for (i=[1:1:N]) lerp(ep, [ep.x,0], i/N)],
		[for (i=[1:1:N]) lerp([ep.x,0], [sp.x,0], i/N)]
	) : (axis=="Y")? concat(
		[for (i=[0:1:N-1]) lerp([0,sp.y], sp, i/N)],
		bezier,
		[for (i=[1:1:N]) lerp(ep, [0,ep.y], i/N)],
		[for (i=[1:1:N]) lerp([0,ep.y], [0,sp.y], i/N)]
	) : (
		assert(in_list(axis, ["X","Y"]))
	);


// Function: bezier_offset()
// Usage:
//   bezier_offset(offset, bezier, [N]);
// Description:
//   Takes a 2D bezier path and closes it with a matching reversed path that is offset by the given `offset` [X,Y] distance.
// Arguments:
//   offset = Amount to offset second path by.
//   bezier = The 2D bezier path.
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
// Example(2D):
//   bez = [[50,30], [40,10], [10,50], [0,30], [-10, 10], [-30,10], [-50,20]];
//   closed = bezier_offset([0,-5], bez);
//   trace_bezier(closed, size=1);
// Example(2D):
//   bez = [[30,50], [10,40], [50,10], [30,0], [10, -10], [10,-30], [20,-50]];
//   closed = bezier_offset([-5,0], bez);
//   trace_bezier(closed, size=1);
function bezier_offset(offset, bezier, N=3) =
	let(
		backbez = reverse([ for (pt = bezier) pt+offset ]),
		bezend = len(bezier)-1
	) concat(
		bezier,
		[for (i=[1:1:N-1]) lerp(bezier[bezend], backbez[0], i/N)],
		backbez,
		[for (i=[1:1:N]) lerp(backbez[bezend], bezier[0], i/N)]
	);



// Section: Path Modules


// Module: bezier_polygon()
// Usage:
//   bezier_polygon(bezier, [splinesteps], [N]) {
// Description:
//   Takes a closed 2D bezier path, and creates a 2D polygon from it.
// Arguments:
//   bezier = The closed bezier path to make into a polygon.
//   splinesteps = Number of straight lines to split each bezier segment into. default=16
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
// Example(2D):
//   bez = [
//       [0,0], [-5,30],
//       [20,60], [50,50], [110,30],
//       [60,25], [70,0], [80,-25],
//       [80,-50], [50,-50], [30,-50],
//       [5,-30], [0,0]
//   ];
//   trace_bezier(bez, N=3, size=3);
//   linear_extrude(height=0.1) bezier_polygon(bez, N=3);
module bezier_polygon(bezier, splinesteps=16, N=3) {
	polypoints=bezier_polyline(bezier, splinesteps, N);
	polygon(points=slice(polypoints, 0, -1));
}


// Module: linear_sweep_bezier()
// Usage:
//   linear_sweep_bezier(bezier, height, [splinesteps], [N], [center], [convexity], [twist], [slices], [scale]);
// Description:
//   Takes a closed 2D bezier path, centered on the XY plane, and
//   extrudes it linearly upwards, forming a solid.
// Arguments:
//   bezier = Array of 2D points of a bezier path, to be extruded.
//   splinesteps = Number of steps to divide each bezier segment into. default=16
//   N = The degree of the bezier curves.  Cubic beziers have N=3.  Default: 3
//   convexity = max number of walls a line could pass through, for preview.  default=10
//   twist = Angle in degrees to twist over the length of extrusion.  default=0
//   scale = Relative size of top of extrusion to the bottom.  default=1.0
//   slices = Number of vertical slices to use for twisted extrusion.  default=20
//   center = If true, the extruded solid is centered vertically at z=0.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `BOTTOM`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example:
//   bez = [
//       [-10,   0],  [-15,  -5],
//       [ -5, -10],  [  0, -10],  [ 5, -10],
//       [ 10,  -5],  [ 15,   0],  [10,   5],
//       [  5,  10],  [  0,  10],  [-5,  10],
//       [ 25, -15],  [-10,   0]
//   ];
//   linear_sweep_bezier(bez, height=20, splinesteps=32);
module linear_sweep_bezier(bezier, height=100, splinesteps=16, N=3, center=undef, convexity=undef, twist=undef, slices=undef, scale=undef, anchor=BOTTOM, spin=0, orient=UP) {
	maxx = max([for (pt = bezier) abs(pt[0])]);
	maxy = max([for (pt = bezier) abs(pt[1])]);
	orient_and_anchor([maxx*2,maxy*2,height], orient, anchor, spin=spin, center=center, chain=true) {
		linear_extrude(height=height, center=true, convexity=convexity, twist=twist, slices=slices, scale=scale) {
			bezier_polygon(bezier, splinesteps=splinesteps, N=N);
		}
		children();
	}
}


// Module: rotate_sweep_bezier()
// Usage:
//   rotate_sweep_bezier(bezier, [splinesteps], [N], [convexity], [angle])
// Description:
//   Takes a closed 2D bezier and rotates it around the Z axis, forming a solid.
//   Behaves like rotate_extrude(), except for beziers instead of shapes.
// Arguments:
//   bezier = array of 2D points for the bezier path to rotate.
//   splinesteps = number of segments to divide each bezier segment into. default=16
//   N = number of points in each bezier segment.  default=3 (cubic)
//   convexity = max number of walls a line could pass through, for preview.  default=2
//   angle = Degrees of sweep to make.  Default: 360
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#spin).  Default: `0`
//   orient = Vector to rotate top towards, after spin.  See [orient](attachments.scad#orient).  Default: `UP`
// Example(Spin):
//   path = [
//     [  0, 10], [ 50,  0], [ 50, 40],
//     [ 95, 40], [100, 40], [100, 45],
//     [ 95, 45], [ 66, 45], [  0, 20],
//     [  0, 12], [  0, 12], [  0, 10],
//     [  0, 10]
//   ];
//   rotate_sweep_bezier(path, splinesteps=32, $fn=180);
module rotate_sweep_bezier(bezier, splinesteps=16, N=3, convexity=undef, angle=360, anchor=CENTER, spin=0, orient=UP)
{
	maxx = max([for (pt = bezier) abs(pt[0])]);
	maxy = max([for (pt = bezier) abs(pt[1])]);
	orient_and_anchor([maxx*2,maxx*2,0], orient, anchor, spin=spin, geometry="cylinder", chain=true) {
		rotate_extrude(convexity=convexity, angle=angle) {
			bezier_polygon(bezier, splinesteps, N);
		}
	}
}


// Module: bezier_path_extrude()
// Usage:
//   bezier_path_extrude(bezier, [splinesteps], [N], [convexity], [clipsize]) ...
// Description:
//   Extrudes 2D shape children along a bezier path.
// Arguments:
//   bezier = array of points for the bezier path to extrude along.
//   splinesteps = number of segments to divide each bezier segment into. default=16
//   N = The degree of the bezier path to extrude.
//   convexity = max number of walls a line could pass through, for preview.  default=2
//   clipsize = Size of cube to use for clipping beveled ends with.
// Example(FR):
//   path = [ [0, 0, 0], [33, 33, 33], [66, -33, -33], [100, 0, 0] ];
//   bezier_path_extrude(path) difference(){
//       circle(r=10);
//       fwd(10/2) circle(r=8);
//   }
module bezier_path_extrude(bezier, splinesteps=16, N=3, convexity=undef, clipsize=1000) {
	path = slice(bezier_polyline(bezier, splinesteps, N), 0, -1);
	path_extrude(path, convexity=convexity, clipsize=clipsize) children();
}


// Module: bezier_sweep_bezier()
// Usage:
//   bezier_sweep_bezier(bezier, path, [pathsteps], [bezsteps], [bezN], [pathN]);
// Description:
//   Takes a closed 2D bezier path, centered on the XY plane, and
//   extrudes it perpendicularly along a 3D bezier path, forming a solid.
// Arguments:
//   bezier = Array of 2D points of a bezier path, to be extruded.
//   path = Array of 3D points of a bezier path, to extrude along.
//   pathsteps = number of steps to divide each path segment into.
//   bezsteps = number of steps to divide each bezier segment into.
//   bezN = number of points in each extruded bezier segment.  default=3 (cubic)
//   pathN = number of points in each path bezier segment.  default=3 (cubic)
// Example(FlatSpin):
//   bez = [
//       [-10,   0],  [-15,  -5],
//       [ -5, -10],  [  0, -10],  [ 5, -10],
//       [ 10,  -5],  [ 15,   0],  [10,   5],
//       [  5,  10],  [  0,  10],  [-5,  10],
//       [ 25, -15],  [-10,   0]
//   ];
//   path = [ [0, 0, 0], [33, 33, 33], [90, 33, -33], [100, 0, 0] ];
//   bezier_sweep_bezier(bez, path, pathsteps=32, bezsteps=16);
module bezier_sweep_bezier(bezier, path, pathsteps=16, bezsteps=16, bezN=3, pathN=3) {
	bez_points = simplify2d_path(bezier_polyline(bezier, bezsteps, bezN));
	path_points = simplify3d_path(path3d(bezier_polyline(path, pathsteps, pathN)));
	path_sweep(bez_points, path_points);
}


// Module: trace_bezier()
// Description:
//   Renders 2D or 3D bezier paths and their associated control points.
//   Useful for debugging bezier paths.
// Arguments:
//   bez = the array of points in the bezier.
//   N = Mark the first and every Nth vertex after in a different color and shape.
//   size = diameter of the lines drawn.
// Example(2D):
//   bez = [
//       [-10,   0],  [-15,  -5],
//       [ -5, -10],  [  0, -10],  [ 5, -10],
//       [ 14,  -5],  [ 15,   0],  [16,   5],
//       [  5,  10],  [  0,  10]
//   ];
//   trace_bezier(bez, N=3, size=0.5);
module trace_bezier(bez, N=3, size=1) {
	trace_polyline(bez, N=N, showpts=true, size=size/2, color="green");
	trace_polyline(bezier_polyline(bez, N=N), size=size, color="cyan");
}



// Section: Patch Functions


// Function: bezier_patch_point()
// Usage:
//   bezier_patch_point(patch, u, v)
// Description:
//   Given a square 2-dimensional array of (N+1) by (N+1) points size,
//   that represents a Bezier Patch of degree N, returns a point on that
//   surface, at positions `u`, and `v`.  A cubic bezier patch will be 4x4
//   points in size.  If given a non-square array, each direction will have
//   its own degree.
// Arguments:
//   patch = The 2D array of endpoints and control points for this bezier patch.
//   u = The proportion of the way along the first dimension of the patch to find the point of.  0<=`u`<=1
//   v = The proportion of the way along the second dimension of the patch to find the point of.  0<=`v`<=1
// Example(3D):
//   patch = [
//       [[-50, 50,  0], [-16, 50,  20], [ 16, 50,  20], [50, 50,  0]],
//       [[-50, 16, 20], [-16, 16,  40], [ 16, 16,  40], [50, 16, 20]],
//       [[-50,-16, 20], [-16,-16,  40], [ 16,-16,  40], [50,-16, 20]],
//       [[-50,-50,  0], [-16,-50,  20], [ 16,-50,  20], [50,-50,  0]]
//   ];
//   trace_bezier_patches(patches=[patch], size=1, showcps=true);
//   pt = bezier_patch_point(patch, 0.6, 0.75);
//   translate(pt) color("magenta") sphere(d=3, $fn=12);
function bezier_patch_point(patch, u, v) = bez_point([for (bez = patch) bez_point(bez, u)], v);


// Function: bezier_triangle_point()
// Usage:
//   bezier_triangle_point(tri, u, v)
// Description:
//   Given a triangular 2-dimensional array of N+1 by (for the first row) N+1 points,
//   that represents a Bezier triangular patch of degree N, returns a point on
//   that surface, at positions `u`, and `v`.  A cubic bezier triangular patch
//   will have a list of 4 points in the first row, 3 in the second, 2 in the
//   third, and 1 in the last row.
// Arguments:
//   tri = Triangular bezier patch to get point on.
//   u = The proportion of the way along the first dimension of the triangular patch to find the point of.  0<=`u`<=1
//   v = The proportion of the way along the second dimension of the triangular patch to find the point of.  0<=`v`<=(1-`u`)
// Example(3D):
//   tri = [
//       [[-50,-33,0], [-25,16,40], [20,66,20]],
//       [[0,-33,30], [25,16,30]],
//       [[50,-33,0]]
//   ];
//   trace_bezier_patches(patches=[tri], size=1, showcps=true);
//   pt = bezier_triangle_point(tri, 0.5, 0.2);
//   translate(pt) color("magenta") sphere(d=3, $fn=12);
function bezier_triangle_point(tri, u, v) =
	len(tri) == 1 ? tri[0][0] :
	let(
		n = len(tri)-1,
		Pu = [for(i=[0:1:n-1]) [for (j=[1:1:len(tri[i])-1]) tri[i][j]]],
		Pv = [for(i=[0:1:n-1]) [for (j=[0:1:len(tri[i])-2]) tri[i][j]]],
		Pw = [for(i=[1:1:len(tri)-1]) tri[i]]
	)
	bezier_triangle_point(u*Pu + v*Pv + (1-u-v)*Pw, u, v);


// Function: is_tripatch()
// Description:
//   Returns true if the given item is a triangular bezier patch.
function is_tripatch(x) = is_list(x) && is_list(x[0]) && is_vector(x[0][0]) && len(x[0])>1 && len(x[len(x)-1])==1;


// Function: is_rectpatch()
// Description:
//   Returns true if the given item is a rectangular bezier patch.
function is_rectpatch(x) = is_list(x) && is_list(x[0]) && is_vector(x[0][0]) && len(x[0]) == len(x[len(x)-1]);


// Function: is_patch()
// Description:
//   Returns true if the given item is a bezier patch.
function is_patch(x) = is_tripatch(x) || is_rectpatch(x);


// Function: bezier_patch()
// Usage:
//   bezier_patch(patch, [splinesteps], [vnf]);
// Description:
//   Calculate vertices and faces for forming a partial polyhedron from the given bezier rectangular
//   or triangular patch.  Returns a [VNF structure](vnf.scad): a list containing two elements.  The first is the
//   list of unique vertices.  The second is the list of faces, where each face is a list of indices into the
//   list of vertices.  You can chain calls to this, to add more vertices and faces for multiple bezier
//   patches, to stitch them together into a complete polyhedron.
// Arguments:
//   patch = The rectangular or triangular array of endpoints and control points for this bezier patch.
//   splinesteps = Number of steps to divide each bezier segment into.  For rectangular patches you can specify [XSTEPS,YSTEPS].  Default: 16
//   vnf = Vertices'n'Faces [VNF structure](vnf.scad) to add new vertices and faces to.  Default: empty VNF
// Example(3D):
//   patch = [
//       [[-50, 50,  0], [-16, 50, -20], [ 16, 50,  20], [50, 50,  0]],
//       [[-50, 16, 20], [-16, 16, -20], [ 16, 16,  20], [50, 16, 20]],
//       [[-50,-16, 20], [-16,-16,  20], [ 16,-16, -20], [50,-16, 20]],
//       [[-50,-50,  0], [-16,-50,  20], [ 16,-50, -20], [50,-50,  0]]
//   ];
//   vnf = bezier_patch(patch, splinesteps=16);
//   vnf_polyhedron(vnf);
// Example(3D):
//   tri = [
//       [[-50,-33,0], [-25,16,50], [0,66,0]],
//       [[0,-33,50], [25,16,50]],
//       [[50,-33,0]]
//   ];
//   vnf = bezier_patch(tri, splinesteps=16);
//   vnf_polyhedron(vnf);
// Example(3DFlatSpin): Chaining Patches
//   patch = [
//   	[[0,  0,0], [33,  0,  0], [67,  0,  0], [100,  0,0]],
//   	[[0, 33,0], [33, 33, 33], [67, 33, 33], [100, 33,0]],
//   	[[0, 67,0], [33, 67, 33], [67, 67, 33], [100, 67,0]],
//   	[[0,100,0], [33,100,  0], [67,100,  0], [100,100,0]],
//   ];
//   vnf1 = bezier_patch(translate(p=patch,[-50,-50,50]));
//   vnf2 = bezier_patch(vnf=vnf1, rot(a=[90,0,0],p=translate(p=patch,[-50,-50,50])));
//   vnf3 = bezier_patch(vnf=vnf2, rot(a=[-90,0,0],p=translate(p=patch,[-50,-50,50])));
//   vnf4 = bezier_patch(vnf=vnf3, rot(a=[180,0,0],p=translate(p=patch,[-50,-50,50])));
//   vnf5 = bezier_patch(vnf=vnf4, rot(a=[0,90,0],p=translate(p=patch,[-50,-50,50])));
//   vnf6 = bezier_patch(vnf=vnf5, rot(a=[0,-90,0],p=translate(p=patch,[-50,-50,50])));
//   vnf_polyhedron(vnf6);
// Example(3D): Chaining Patches with Assymmetric Splinesteps
//   steps = 8;
//   edge_patch = [
//       [[-60, 0,-40], [0, 0,-40], [60, 0,-40]],
//       [[-60, 0,  0], [0, 0,  0], [60, 0,  0]],
//       [[-60,40,  0], [0,40,  0], [60,40,  0]],
//   ];
//   corner_patch = [
//       [[40,  0,-40], [ 0,  0,-40], [ 0, 40,-40]],
//       [[40,  0,  0], [ 0,  0,  0], [ 0, 40,  0]],
//       [[40, 40,  0], [40, 40,  0], [40, 40,  0]]
//   ];
//   face_patch = bezier_patch_flat([120,120],N=1,orient=LEFT);
//   edges = [
//       for (axrot=[[0,0,0],[0,90,0],[0,0,90]], xang=[-90:90:180])
//       bezier_patch(
//           splinesteps=[1,steps],
//           rot(a=axrot,
//               p=rot(a=[xang,0,0],
//                   p=translate(v=[0,-100,100],p=edge_patch)
//               )
//           )
//       )
//   ];
//   corners = [
//       for (zang=[0,180], xang=[-90:90:180])
//       bezier_patch(
//           splinesteps=steps,
//           rot(a=[xang,0,zang],
//               p=translate(v=[-100,-100,100],p=corner_patch)
//           )
//       )
//   ];
//   faces = [
//       for (axrot=[[0,0,0],[0,90,0],[0,0,90]], zang=[0,180])
//       bezier_patch(
//           splinesteps=1,
//           rot(a=axrot,
//               p=rot(a=[0,0,zang],
//                   p=translate(v=[-100,0,0], p=face_patch)
//               )
//           )
//       )
//   ];
//   vnf_polyhedron(concat(edges,corners,faces));
function bezier_patch(patch, splinesteps=16, vnf=[[],[]]) =
	assert(is_num(splinesteps)||is_list(splinesteps))
	is_tripatch(patch)? _bezier_triangle(patch, splinesteps=splinesteps, vnf=vnf) :
	let(
		splinesteps = is_list(splinesteps)? splinesteps : [splinesteps, splinesteps],
		pts = [for (v=[0:1:splinesteps.y], u=[0:1:splinesteps.x]) bezier_patch_point(patch, u/splinesteps.x, v/splinesteps.y)],
		faces = [
			for (
				v=[0:1:splinesteps.y-1],
				u=[0:1:splinesteps.x-1]
			) let (
				v1 = u+v*(splinesteps.x+1),
				v2 = v1 + 1,
				v3 = v1 + splinesteps.x + 1,
				v4 = v3 + 1
			) each [[v1,v3,v2], [v2,v3,v4]]
		]
	) vnf_merge([vnf, [pts, faces]]);


function _tri_count(n) = (n*(1+n))/2;


function _bezier_triangle(tri, splinesteps=16, vnf=[[],[]]) =
	assert(is_num(splinesteps))
	let(
		pts = [
			for (
				u=[0:1:splinesteps],
				v=[0:1:splinesteps-u]
			) bezier_triangle_point(tri, u/splinesteps, v/splinesteps)
		],
		tricnt = _tri_count(splinesteps+1),
		faces = [
			for (
				u=[0:1:splinesteps-1],
				v=[0:1:splinesteps-u-1]
			) let (
				v1 = v + (tricnt - _tri_count(splinesteps+1-u)),
				v2 = v1 + 1,
				v3 = v + (tricnt - _tri_count(splinesteps-u)),
				v4 = v3 + 1,
				allfaces = concat(
					[[v1,v2,v3]],
					((u<splinesteps-1 && v<splinesteps-u-1)? [[v2,v4,v3]] : [])
				)
			)  for (face=allfaces) face
		]
	) vnf_merge([vnf,[pts, faces]]);



// Function: bezier_patch_flat()
// Usage:
//   bezier_patch_flat(size, [N], [spin], [orient], [trans]);
// Description:
//   Returns a flat rectangular bezier patch of degree `N`, centered on the XY plane.
// Arguments:
//   size = 2D XY size of the patch.
//   N = Degree of the patch to generate.  Since this is flat, a degree of 1 should usually be sufficient.
//   orient = The orientation to rotate the edge patch into.  Given as an [X,Y,Z] rotation angle list.
//   trans = Amount to translate patch, after rotating to `orient`.
// Example(3D):
//   patch = bezier_patch_flat(size=[100,100], N=3);
//   trace_bezier_patches([patch], size=1, showcps=true);
function bezier_patch_flat(size=[100,100], N=4, spin=0, orient=UP, trans=[0,0,0]) =
	let(
		patch = [for (x=[0:1:N]) [for (y=[0:1:N]) vmul(point3d(size),[x/N-0.5, 0.5-y/N, 0])]]
	) [for (row=patch)
		translate_points(v=trans,
			rotate_points3d(a=spin, from=UP, to=orient, row)
		)
	];



// Function: patch_reverse()
// Usage:
//   patch_reverse(patch)
// Description:
//   Reverses the patch, so that the faces generated from it are flipped back to front.
// Arguments:
//   patch = The patch to reverse.
function patch_reverse(patch) = [for (row=patch) reverse(row)];


// Function: bezier_surface()
// Usage:
//   bezier_surface(patches, [splinesteps], [vnf]);
// Description:
//   Calculate vertices and faces for forming a (possibly partial) polyhedron from the given
//   rectangular and/or triangular bezier patches.  Returns a [VNF structure](vnf.scad): a list
//   containing two elements.  The first is the the list of unique vertices.  The second is the list
//   of faces, where each face is a list of indices into the list of vertices.  You can chain calls to
//   this, to add more vertices and faces for multiple bezier patches, to stitch them together into a
//   complete polyhedron.
// Arguments:
//   patches = A list of triangular and/or rectangular bezier patches.
//   splinesteps = Number of steps to divide each bezier segment into.  Default: 16
//   vnf = Vertices'n'Faces [VNF structure](vnf.scad) to add new vertices and faces to.  Default: empty VNF
// Example(3D):
//   patch1 = [
//   	[[18,18,0], [33,  0,  0], [ 67,  0,  0], [ 82, 18,0]],
//   	[[ 0,40,0], [ 0,  0,100], [100,  0, 20], [100, 40,0]],
//   	[[ 0,60,0], [ 0,100,100], [100,100, 20], [100, 60,0]],
//   	[[18,82,0], [33,100,  0], [ 67,100,  0], [ 82, 82,0]],
//   ];
//   patch2 = [
//   	[[18,18,0], [33,  0,  0], [ 67,  0,  0], [ 82, 18,0]],
//   	[[ 0,40,0], [ 0,  0,-50], [100,  0,-50], [100, 40,0]],
//   	[[ 0,60,0], [ 0,100,-50], [100,100,-50], [100, 60,0]],
//   	[[18,82,0], [33,100,  0], [ 67,100,  0], [ 82, 82,0]],
//   ];
//   vnf = bezier_surface(patches=[patch1, patch2], splinesteps=16);
//   polyhedron(points=vnf[0], faces=vnf[1]);
function bezier_surface(patches=[], splinesteps=16, i=0, vnf=[[],[]]) =
	let(
		vnf = (i >= len(patches))? vnf :
			bezier_patch(patches[i], splinesteps=splinesteps, vnf=vnf)
	) (i >= len(patches))? vnf :
	bezier_surface(patches=patches, splinesteps=splinesteps, i=i+1, vnf=vnf);



// Section: Bezier Surface Modules


// Module: bezier_polyhedron()
// Useage:
//   bezier_polyhedron(patches, [splinesteps], [vnf])
// Description:
//   Takes a list of two or more bezier patches and attempts to make a complete polyhedron from them.
// Arguments:
//   patches = A list of triangular and/or rectangular bezier patches.
//   splinesteps = Number of steps to divide each bezier segment into. Default: 16
//   vnf = Vertices'n'Faces [VNF structure](vnf.scad) to add extra vertices and faces to.  Default: empty VNF
// Example:
//   patch1 = [
//   	[[18,18,0], [33,  0,  0], [ 67,  0,  0], [ 82, 18,0]],
//   	[[ 0,40,0], [ 0,  0, 20], [100,  0, 20], [100, 40,0]],
//   	[[ 0,60,0], [ 0,100, 20], [100,100,100], [100, 60,0]],
//   	[[18,82,0], [33,100,  0], [ 67,100,  0], [ 82, 82,0]],
//   ];
//   patch2 = [
//   	[[18,18,0], [33,  0,  0], [ 67,  0,  0], [ 82, 18,0]],
//   	[[ 0,40,0], [ 0,  0,-50], [100,  0,-50], [100, 40,0]],
//   	[[ 0,60,0], [ 0,100,-50], [100,100,-50], [100, 60,0]],
//   	[[18,82,0], [33,100,  0], [ 67,100,  0], [ 82, 82,0]],
//   ];
//   bezier_polyhedron([patch1, patch2], splinesteps=8);
module bezier_polyhedron(patches=[], splinesteps=16, vnf=[[],[]])
{
	vnf_polyhedron(
		bezier_surface(patches=patches, splinesteps=splinesteps, vnf=vnf)
	);
}



// Module: trace_bezier_patches()
// Usage:
//   trace_bezier_patches(patches, [size], [showcps], [splinesteps]);
// Description:
//   Shows the surface, and optionally, control points of a list of bezier patches.
// Arguments:
//   patches = A list of rectangular bezier patches.
//   splinesteps = Number of steps to divide each bezier segment into. default=16
//   showcps = If true, show the controlpoints as well as the surface.
//   size = Size to show control points and lines.
// Example:
//   patch1 = [
//   	[[15,15,0], [33,  0,  0], [ 67,  0,  0], [ 85, 15,0]],
//   	[[ 0,33,0], [33, 33, 50], [ 67, 33, 50], [100, 33,0]],
//   	[[ 0,67,0], [33, 67, 50], [ 67, 67, 50], [100, 67,0]],
//   	[[15,85,0], [33,100,  0], [ 67,100,  0], [ 85, 85,0]],
//   ];
//   patch2 = [
//   	[[15,15,0], [33,  0,  0], [ 67,  0,  0], [ 85, 15,0]],
//   	[[ 0,33,0], [33, 33,-50], [ 67, 33,-50], [100, 33,0]],
//   	[[ 0,67,0], [33, 67,-50], [ 67, 67,-50], [100, 67,0]],
//   	[[15,85,0], [33,100,  0], [ 67,100,  0], [ 85, 85,0]],
//   ];
//   trace_bezier_patches(patches=[patch1, patch2], splinesteps=8, showcps=true);
module trace_bezier_patches(patches=[], size=1, showcps=false, splinesteps=16)
{
	if (showcps) {
		for (patch = patches) {
			place_copies(flatten(patch)) color("red") sphere(d=size*2);
			color("cyan")
			if (is_tripatch(patch)) {
				for (i=[0:1:len(patch)-2], j=[0:1:len(patch[i])-2]) {
					extrude_from_to(patch[i][j], patch[i+1][j]) circle(d=size);
					extrude_from_to(patch[i][j], patch[i][j+1]) circle(d=size);
					extrude_from_to(patch[i+1][j], patch[i][j+1]) circle(d=size);
				}
			} else {
				for (i=[0:1:len(patch)-1], j=[0:1:len(patch[i])-1]) {
					if (i<len(patch)-1) extrude_from_to(patch[i][j], patch[i+1][j]) circle(d=size);
					if (j<len(patch[i])-1) extrude_from_to(patch[i][j], patch[i][j+1]) circle(d=size);
				}
			}
			vnf = bezier_patch(patch, splinesteps=splinesteps);
			color("blue") place_copies(vnf[0]) sphere(d=size);
		}
	}
	bezier_polyhedron(patches=patches, splinesteps=splinesteps);
}



// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
