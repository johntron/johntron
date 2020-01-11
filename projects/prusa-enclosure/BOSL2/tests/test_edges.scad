include <BOSL2/std.scad>


module test_is_edge_array() {
	assert(is_edge_array([[0,0,0,0],[0,0,0,0],[0,0,0,0]]));
	assert(is_edge_array([[1,1,1,1],[1,1,1,1],[1,1,1,1]]));
	assert(!is_edge_array([[1,1,1],[1,1,1],[1,1,1]]));
	assert(!is_edge_array([[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1]]));
	assert(!is_edge_array([[1,1,1,1],[1,1,1,1]]));
	assert(!is_edge_array([1,1,1,1]));
	assert(!is_edge_array("foo"));
	assert(!is_edge_array(42));
	assert(!is_edge_array(true));
	assert(is_edge_array(edges(["X","Y"])));
}
test_is_edge_array();


module test__edge_set() {
	// Edge set pass through
	assert(_edge_set([[1,1,1,1],[0,1,0,1],[0,0,0,0]]) == [[1,1,1,1],[0,1,0,1],[0,0,0,0]]);

	// Vectors towards corners
	assert(_edge_set([-1,-1,-1]) == [[1,0,0,0],[1,0,0,0],[1,0,0,0]]);
	assert(_edge_set([-1,-1, 1]) == [[0,0,1,0],[0,0,1,0],[1,0,0,0]]);
	assert(_edge_set([-1, 1,-1]) == [[0,1,0,0],[1,0,0,0],[0,0,1,0]]);
	assert(_edge_set([-1, 1, 1]) == [[0,0,0,1],[0,0,1,0],[0,0,1,0]]);
	assert(_edge_set([ 1,-1,-1]) == [[1,0,0,0],[0,1,0,0],[0,1,0,0]]);
	assert(_edge_set([ 1,-1, 1]) == [[0,0,1,0],[0,0,0,1],[0,1,0,0]]);
	assert(_edge_set([ 1, 1,-1]) == [[0,1,0,0],[0,1,0,0],[0,0,0,1]]);
	assert(_edge_set([ 1, 1, 1]) == [[0,0,0,1],[0,0,0,1],[0,0,0,1]]);

	// Vectors towards edges
	assert(_edge_set([ 0,-1,-1]) == [[1,0,0,0],[0,0,0,0],[0,0,0,0]]);
	assert(_edge_set([ 0, 1,-1]) == [[0,1,0,0],[0,0,0,0],[0,0,0,0]]);
	assert(_edge_set([ 0,-1, 1]) == [[0,0,1,0],[0,0,0,0],[0,0,0,0]]);
	assert(_edge_set([ 0, 1, 1]) == [[0,0,0,1],[0,0,0,0],[0,0,0,0]]);
	assert(_edge_set([-1, 0,-1]) == [[0,0,0,0],[1,0,0,0],[0,0,0,0]]);
	assert(_edge_set([ 1, 0,-1]) == [[0,0,0,0],[0,1,0,0],[0,0,0,0]]);
	assert(_edge_set([-1, 0, 1]) == [[0,0,0,0],[0,0,1,0],[0,0,0,0]]);
	assert(_edge_set([ 1, 0, 1]) == [[0,0,0,0],[0,0,0,1],[0,0,0,0]]);
	assert(_edge_set([-1,-1, 0]) == [[0,0,0,0],[0,0,0,0],[1,0,0,0]]);
	assert(_edge_set([ 1,-1, 0]) == [[0,0,0,0],[0,0,0,0],[0,1,0,0]]);
	assert(_edge_set([-1, 1, 0]) == [[0,0,0,0],[0,0,0,0],[0,0,1,0]]);
	assert(_edge_set([ 1, 1, 0]) == [[0,0,0,0],[0,0,0,0],[0,0,0,1]]);

	// Vectors towards faces
	assert(_edge_set([ 0, 0,-1]) == [[1,1,0,0],[1,1,0,0],[0,0,0,0]]);
	assert(_edge_set([ 0, 0, 1]) == [[0,0,1,1],[0,0,1,1],[0,0,0,0]]);
	assert(_edge_set([ 0,-1, 0]) == [[1,0,1,0],[0,0,0,0],[1,1,0,0]]);
	assert(_edge_set([ 0, 1, 0]) == [[0,1,0,1],[0,0,0,0],[0,0,1,1]]);
	assert(_edge_set([-1, 0, 0]) == [[0,0,0,0],[1,0,1,0],[1,0,1,0]]);
	assert(_edge_set([ 1, 0, 0]) == [[0,0,0,0],[0,1,0,1],[0,1,0,1]]);

	// Named edge sets
	assert(_edge_set("X") == [[1,1,1,1],[0,0,0,0],[0,0,0,0]]);
	assert(_edge_set("Y") == [[0,0,0,0],[1,1,1,1],[0,0,0,0]]);
	assert(_edge_set("Z") == [[0,0,0,0],[0,0,0,0],[1,1,1,1]]);
	assert(_edge_set("NONE") == [[0,0,0,0],[0,0,0,0],[0,0,0,0]]);
	assert(_edge_set("ALL") == [[1,1,1,1],[1,1,1,1],[1,1,1,1]]);
}
test__edge_set();


module test_normalize_edges() {
	assert(normalize_edges([[-2,-2,-2,-2],[-2,-2,-2,-2],[-2,-2,-2,-2]]) == [[0,0,0,0],[0,0,0,0],[0,0,0,0]]);
	assert(normalize_edges([[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]) == [[0,0,0,0],[0,0,0,0],[0,0,0,0]]);
	assert(normalize_edges([[0,0,0,0],[0,0,0,0],[0,0,0,0]]) == [[0,0,0,0],[0,0,0,0],[0,0,0,0]]);
	assert(normalize_edges([[1,1,1,1],[1,1,1,1],[1,1,1,1]]) == [[1,1,1,1],[1,1,1,1],[1,1,1,1]]);
	assert(normalize_edges([[2,2,2,2],[2,2,2,2],[2,2,2,2]]) == [[1,1,1,1],[1,1,1,1],[1,1,1,1]]);
}
test_normalize_edges();


module test_edges() {
	assert(edges("X")==[[1,1,1,1],[0,0,0,0],[0,0,0,0]]);
	assert(edges("Y")==[[0,0,0,0],[1,1,1,1],[0,0,0,0]]);
	assert(edges("Z")==[[0,0,0,0],[0,0,0,0],[1,1,1,1]]);
	assert(edges(["X"])==[[1,1,1,1],[0,0,0,0],[0,0,0,0]]);
	assert(edges(["Y"])==[[0,0,0,0],[1,1,1,1],[0,0,0,0]]);
	assert(edges(["Z"])==[[0,0,0,0],[0,0,0,0],[1,1,1,1]]);
	assert(edges(["X","Y"])==[[1,1,1,1],[1,1,1,1],[0,0,0,0]]);
	assert(edges(["X","Z"])==[[1,1,1,1],[0,0,0,0],[1,1,1,1]]);
	assert(edges(["Y","Z"])==[[0,0,0,0],[1,1,1,1],[1,1,1,1]]);
	assert(edges("ALL",except="X")==[[0,0,0,0],[1,1,1,1],[1,1,1,1]]);
	assert(edges("ALL",except="Y")==[[1,1,1,1],[0,0,0,0],[1,1,1,1]]);
	assert(edges("ALL",except="Z")==[[1,1,1,1],[1,1,1,1],[0,0,0,0]]);
	assert(edges(["Y","Z"],except=[FRONT+RIGHT,FRONT+LEFT])==[[0,0,0,0],[1,1,1,1],[0,0,1,1]]);
}
test_edges();


module test_corner_edge_count() {
	edges = edges([TOP,FRONT+RIGHT]);
	assert(corner_edge_count(edges,TOP+FRONT+RIGHT) == 3);
	assert(corner_edge_count(edges,TOP+FRONT+LEFT) == 2);
	assert(corner_edge_count(edges,BOTTOM+FRONT+RIGHT) == 1);
	assert(corner_edge_count(edges,BOTTOM+FRONT+LEFT) == 0);
}
test_corner_edge_count();



// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
