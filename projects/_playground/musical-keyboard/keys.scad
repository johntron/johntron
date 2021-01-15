include <BOSL2/std.scad>

key_length_y = 50;
black_key_width = 5;
white_key_width = 10;
space_between_keys = 0.5;

function y_offset_for_key(steps, sharp=false, flat=false) = 
  (steps * (white_key_width + space_between_keys))
  + (sharp ? white_key_width - (black_key_width / 2) : 0)
  - (flat ? black_key_width / 2 : 0);


module black_key() {
  dimensions = [black_key_width, key_length_y * 2 / 3, 10];
  color("black")
  back(key_length_y / 3) cube(dimensions);
}

module white_key() {
  dimensions = [white_key_width, key_length_y, 5];
  color("white")
  cube(dimensions);
}

module inset_left_key() {
  difference() {
    white_key();
    minkowski() {
      right(y_offset_for_key(0, flat=true)) black_key();
      left(space_between_keys) back(-space_between_keys) cube(space_between_keys);
    };
  };
}

module inset_right_key() {
  difference() {
    white_key();
    minkowski() {
      right(y_offset_for_key(0, sharp=true)) black_key();
      left(space_between_keys) back(-space_between_keys) cube(space_between_keys);
    }
  };
}

module inset_both_key() {
  difference() {
    white_key();
    minkowski() {
      right(y_offset_for_key(0, flat=true)) black_key();
      left(space_between_keys) back(-space_between_keys) cube(space_between_keys);
    };
    minkowski() {
      right(y_offset_for_key(0, sharp=true)) black_key();
      left(space_between_keys) back(-space_between_keys) cube(space_between_keys);
    };
  };
}

module key_set3() {
  right(y_offset_for_key(0)) inset_right_key();
  right(y_offset_for_key(0, sharp=true)) black_key();
  right(y_offset_for_key(1)) inset_both_key();
  right(y_offset_for_key(1, sharp=true)) black_key();
  right(y_offset_for_key(2)) inset_left_key();
}

module key_set4() {
  right(y_offset_for_key(0)) inset_right_key();
  right(y_offset_for_key(0, sharp=true)) black_key();
  right(y_offset_for_key(1)) inset_both_key();
  right(y_offset_for_key(1, sharp=true)) black_key();
  right(y_offset_for_key(2)) inset_both_key();
  right(y_offset_for_key(2, sharp=true)) black_key();
  right(y_offset_for_key(3)) inset_left_key();
}

key_set3();
right(y_offset_for_key(3)) key_set4();
right(y_offset_for_key(7)) key_set4();
