include <BOSL2/std.scad>


// List/Array Ops

module test_replist() {
	assert(replist(1, 4) == [1,1,1,1]);
	assert(replist(8, [2,3]) == [[8,8,8], [8,8,8]]);
	assert(replist(0, [2,2,3]) == [[[0,0,0],[0,0,0]], [[0,0,0],[0,0,0]]]);
	assert(replist([1,2,3],3) == [[1,2,3], [1,2,3], [1,2,3]]);
}
test_replist();


module test_in_list() {
	assert(in_list("bar", ["foo", "bar", "baz"]));
	assert(!in_list("bee", ["foo", "bar", "baz"]));
	assert(in_list("bar", [[2,"foo"], [4,"bar"], [3,"baz"]], idx=1));
}
test_in_list();


module test_slice() {
	assert(slice([3,4,5,6,7,8,9], 3, 5) == [6,7]);
	assert(slice([3,4,5,6,7,8,9], 2, -1) == [5,6,7,8,9]);
	assert(slice([3,4,5,6,7,8,9], 1, 1) == []);
	assert(slice([3,4,5,6,7,8,9], 6, -1) == [9]);
	assert(slice([3,4,5,6,7,8,9], 2, -2) == [5,6,7,8]);
}
test_slice();


module test_select() {
	l = [3,4,5,6,7,8,9];
	assert(select(l, 5, 6) == [8,9]);
	assert(select(l, 5, 8) == [8,9,3,4]);
	assert(select(l, 5, 2) == [8,9,3,4,5]);
	assert(select(l, -3, -1) == [7,8,9]);
	assert(select(l, 3, 3) == [6]);
	assert(select(l, 4) == 7);
	assert(select(l, -2) == 8);
	assert(select(l, [1:3]) == [4,5,6]);
	assert(select(l, [1,3]) == [4,6]);
}
test_select();


module test_list_range() {
	assert(list_range(4) == [0,1,2,3]);
	assert(list_range(n=4, step=2) == [0,2,4,6]);
	assert(list_range(n=4, s=3, step=3) == [3,6,9,12]);
	assert(list_range(e=3) == [0,1,2,3]);
	assert(list_range(e=6, step=2) == [0,2,4,6]);
	assert(list_range(s=3, e=5) == [3,4,5]);
	assert(list_range(s=3, e=8, step=2) == [3,5,7]);
	assert(list_range(s=4, e=8, step=2) == [4,6,8]);
	assert(list_range(e=4, n=3) == [0,2,4]);
	assert(list_range(n=4, s=[3,4], step=[2,3]) == [[3,4], [5,7], [7,10], [9,13]]);
}
test_list_range();


module test_reverse() {
	assert(reverse([3,4,5,6]) == [6,5,4,3]);
}
test_reverse();


module test_list_rotate() {
	assert(list_rotate([1,2,3,4,5],-2) == [4,5,1,2,3]);
	assert(list_rotate([1,2,3,4,5],-1) == [5,1,2,3,4]);
	assert(list_rotate([1,2,3,4,5],0) == [1,2,3,4,5]);
	assert(list_rotate([1,2,3,4,5],1) == [2,3,4,5,1]);
	assert(list_rotate([1,2,3,4,5],2) == [3,4,5,1,2]);
	assert(list_rotate([1,2,3,4,5],3) == [4,5,1,2,3]);
	assert(list_rotate([1,2,3,4,5],4) == [5,1,2,3,4]);
	assert(list_rotate([1,2,3,4,5],5) == [1,2,3,4,5]);
	assert(list_rotate([1,2,3,4,5],6) == [2,3,4,5,1]);
	assert(list_rotate([],3) == []);
}
test_list_rotate();


module test_deduplicate() {
	assert(deduplicate([8,3,4,4,4,8,2,3,3,8,8]) == [8,3,4,8,2,3,8]);
	assert(deduplicate(closed=true, [8,3,4,4,4,8,2,3,3,8,8]) == [8,3,4,8,2,3]);
	assert(deduplicate("Hello") == ["H","e","l","o"]);
	assert(deduplicate([[3,4],[7,1.99],[7,2],[1,4]],eps=0.1) == [[3,4],[7,2],[1,4]]);
}
test_deduplicate();


module test_list_set() {
	assert(list_set([2,3,4,5], 2, 21) == [2,3,21,5]);
	assert(list_set([2,3,4,5], [1,3], [81,47]) == [2,81,4,47]);
}
test_list_set();


module test_list_remove() {
	assert(list_remove([3,6,9,12],1) == [3,9,12]);
	assert(list_remove([3,6,9,12],[1,3]) == [3,9]);
}
test_list_remove();


module test_list_remove_values() {
	animals = ["bat", "cat", "rat", "dog", "bat", "rat"];
	assert(list_remove_values(animals, "rat") == ["bat","cat","dog","bat","rat"]);
	assert(list_remove_values(animals, "bat", all=true) == ["cat","rat","dog","rat"]);
	assert(list_remove_values(animals, ["bat","rat"]) == ["cat","dog","bat","rat"]);
	assert(list_remove_values(animals, ["bat","rat"], all=true) == ["cat","dog"]);
	assert(list_remove_values(animals, ["tucan","rat"], all=true) == ["bat","cat","dog","bat"]);
}
test_list_remove_values();


module test_list_insert() {
	assert(list_insert([3,6,9,12],1,5) == [3,5,6,9,12]);
	assert(list_insert([3,6,9,12],[1,3],[5,11]) == [3,5,6,9,11,12]);
}
test_list_insert();


module test_bselect() {
	assert(bselect([3,4,5,6,7], [false,false,false,false,false]) == []);
	assert(bselect([3,4,5,6,7], [false,true,true,false,true]) == [4,5,7]);
	assert(bselect([3,4,5,6,7], [true,true,true,true,true]) == [3,4,5,6,7]);
}
test_bselect();


module test_list_bset() {
	assert(list_bset([false,true,false,true,false], [3,4]) == [0,3,0,4,0]);
	assert(list_bset([false,true,false,true,false], [3,4], dflt=1) == [1,3,1,4,1]);
}
test_list_bset();


module test_list_increasing() {
	assert(list_increasing([1,2,3,4]) == true);
	assert(list_increasing([1,3,2,4]) == false);
	assert(list_increasing([4,3,2,1]) == false);
}
test_list_increasing();


module test_list_decreasing() {
	assert(list_decreasing([1,2,3,4]) == false);
	assert(list_decreasing([4,2,3,1]) == false);
	assert(list_decreasing([4,3,2,1]) == true);
}
test_list_decreasing();


module test_list_shortest() {
	assert(list_shortest(["foobar", "bazquxx", "abcd"]) == 4);
}
test_list_shortest();


module test_list_longest() {
	assert(list_longest(["foobar", "bazquxx", "abcd"]) == 7);
}
test_list_longest();


module test_list_pad() {
	assert(list_pad([4,5,6], 5, 8) == [4,5,6,8,8]);
	assert(list_pad([4,5,6,7,8], 5, 8) == [4,5,6,7,8]);
	assert(list_pad([4,5,6,7,8,9], 5, 8) == [4,5,6,7,8,9]);
}
test_list_pad();


module test_list_trim() {
	assert(list_trim([4,5,6], 5) == [4,5,6]);
	assert(list_trim([4,5,6,7,8], 5) == [4,5,6,7,8]);
	assert(list_trim([3,4,5,6,7,8,9], 5) == [3,4,5,6,7]);
}
test_list_trim();


module test_list_fit() {
	assert(list_fit([4,5,6], 5, 8) == [4,5,6,8,8]);
	assert(list_fit([4,5,6,7,8], 5, 8) == [4,5,6,7,8]);
	assert(list_fit([3,4,5,6,7,8,9], 5, 8) == [3,4,5,6,7]);
}
test_list_fit();


module test_idx() {
	colors = ["red", "green", "blue", "cyan"];
	assert([for (i=idx(colors)) i] == [0,1,2,3]);
	assert([for (i=idx(colors,end=-2)) i] == [0,1,2]);
	assert([for (i=idx(colors,start=1)) i] == [1,2,3]);
	assert([for (i=idx(colors,start=1,end=-2)) i] == [1,2]);
}
test_idx();


module test_enumerate() {
	assert(enumerate(["a","b","c"]) == [[0,"a"], [1,"b"], [2,"c"]]);
	assert(enumerate([[88,"a"],[76,"b"],[21,"c"]], idx=1) == [[0,"a"], [1,"b"], [2,"c"]]);
	assert(enumerate([["cat","a",12],["dog","b",10],["log","c",14]], idx=[1:2]) == [[0,"a",12], [1,"b",10], [2,"c",14]]);
}
test_enumerate();


module test_shuffle() {
	nums1 = [for (i=list_range(100)) i];
	nums2 = shuffle(nums1);
	nums3 = shuffle(nums2);
	assert(len(nums2)==len(nums1));
	assert(len(nums3)==len(nums2));
	assert(nums1!=nums2);
	assert(nums2!=nums3);
	assert(nums1!=nums3);
}
test_shuffle();


module test_sort() {
	assert(sort([7,3,9,4,3,1,8]) == [1,3,3,4,7,8,9]);
	assert(sort(["cat", "oat", "sat", "bat", "vat", "rat", "pat", "mat", "fat", "hat", "eat"]) == ["bat", "cat", "eat", "fat", "hat", "mat", "oat", "pat", "rat", "sat", "vat"]);
	assert(sort(enumerate([[2,3,4],[1,2,3],[2,4,3]]),idx=1)==[[1,[1,2,3]], [0,[2,3,4]], [2,[2,4,3]]]);
}
test_sort();


module test_sortidx() {
	lst1 = ["d","b","e","c"];
	assert(sortidx(lst1) == [1,3,0,2]);
	lst2 = [
		["foo", 88, [0,0,1], false],
		["bar", 90, [0,1,0], true],
		["baz", 89, [1,0,0], false],
		["qux", 23, [1,1,1], true]
	];
	assert(sortidx(lst2, idx=1) == [3,0,2,1]);
	assert(sortidx(lst2, idx=0) == [1,2,0,3]);
	assert(sortidx(lst2, idx=[1,3]) == [3,0,2,1]);
	lst3 = [[-4, 0, 0], [0, 0, -4], [0, -4, 0], [-4, 0, 0], [0, -4, 0], [0, 0, 4], [0, 0, -4], [0, 4, 0], [4, 0, 0], [0, 0, 4], [0, 4, 0], [4, 0, 0]];
	assert(sortidx(lst3)==[0,3,2,4,1,6,5,9,7,10,8,11]);
}
test_sortidx();


module test_unique() {
	assert(unique([]) == []);
	assert(unique([8]) == [8]);
	assert(unique([7,3,9,4,3,1,8]) == [1,3,4,7,8,9]);
}
test_unique();


// Arrays


module test_subindex() {
	v = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]];
	assert(subindex(v,2) == [3, 7, 11, 15]);
	assert(subindex(v,[2,1]) == [[3, 2], [7, 6], [11, 10], [15, 14]]);
	assert(subindex(v,[1:3]) == [[2, 3, 4], [6, 7, 8], [10, 11, 12], [14, 15, 16]]);
}
test_subindex();


module test_pair() {
	assert(pair([3,4,5,6]) == [[3,4], [4,5], [5,6]]);
	assert(pair("ABCD") == [["A","B"], ["B","C"], ["C","D"]]);
}
test_pair();


module test_pair_wrap() {
	assert(pair_wrap([3,4,5,6]) == [[3,4], [4,5], [5,6], [6,3]]);
	assert(pair_wrap("ABCD") == [["A","B"], ["B","C"], ["C","D"], ["D","A"]]);
}
test_pair_wrap();


module test_triplet() {
	assert(triplet([3,4,5,6,7]) == [[3,4,5], [4,5,6], [5,6,7]]);
	assert(triplet("ABCDE") == [["A","B","C"], ["B","C","D"], ["C","D","E"]]);
}
test_triplet();


module test_triplet_wrap() {
	assert(triplet_wrap([3,4,5,6]) == [[3,4,5], [4,5,6], [5,6,3], [6,3,4]]);
	assert(triplet_wrap("ABCD") == [["A","B","C"], ["B","C","D"], ["C","D","A"], ["D","A","B"]]);
}
test_triplet_wrap();


module test_zip() {
	v1 = [1,2,3,4];
	v2 = [5,6,7];
	v3 = [8,9,10,11];
	assert(zip(v1,v3) == [[1,8],[2,9],[3,10],[4,11]]);
	assert(zip([v1,v3]) == [[1,8],[2,9],[3,10],[4,11]]);
	assert(zip([v1,v2],fit="short") == [[1,5],[2,6],[3,7]]);
	assert(zip([v1,v2],fit="long") == [[1,5],[2,6],[3,7],[4,undef]]);
	assert(zip([v1,v2],fit="long", fill=0) == [[1,5],[2,6],[3,7],[4,0]]);
	assert(zip([v1,v2,v3],fit="long") == [[1,5,8],[2,6,9],[3,7,10],[4,undef,11]]);
}
test_zip();


module test_array_group() {
	v = [1,2,3,4,5,6];
	assert(array_group(v,2) == [[1,2], [3,4], [5,6]]);
	assert(array_group(v,3) == [[1,2,3], [4,5,6]]);
	assert(array_group(v,4,0) == [[1,2,3,4], [5,6,0,0]]);
}
test_array_group();


module test_flatten() {
	assert(flatten([[1,2,3], [4,5,[6,7,8]]]) == [1,2,3,4,5,[6,7,8]]);
}
test_flatten();


module test_array_dim() {
	assert(array_dim([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]]) == [2,2,3]);
	assert(array_dim([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]], 0) == 2);
	assert(array_dim([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]], 2) == 3);
	assert(array_dim([[[1,2,3],[4,5,6]],[[7,8,9]]]) == [2,undef,3]);
}
test_array_dim();


module test_transpose() {
	assert(transpose([[1,2,3],[4,5,6],[7,8,9]]) == [[1,4,7],[2,5,8],[3,6,9]]);
	assert(transpose([[1,2,3],[4,5,6]]) == [[1,4],[2,5],[3,6]]);
	assert(transpose([3,4,5]) == [3,4,5]);
}
test_transpose();


cube();


// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
