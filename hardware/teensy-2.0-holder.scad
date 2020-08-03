board_l = 31.1;
board_w = 18.3;
board_h = 4;
margin = 2;
plug_l = 20;
plug_w = 10;
slot_l = 4;
slot_w = 2;

total_w = board_w + 2 * margin;
total_h = margin + board_h;

$e = 0.001;

difference() {
  translate([0, -total_w / 2, 0])
    cube([ board_l + plug_l + margin, total_w, total_h ]);
  translate([ plug_l, - board_w / 2, margin ]) cube([ board_l, board_w, board_h + $e ]);
  translate([plug_l / 2 - slot_l / 2, -plug_w / 2 - slot_w, -$e]) {
    cube([slot_l, slot_w, total_h + 2 * $e]);
    cube([slot_l, slot_w * 2 + plug_w, slot_w + $e]);
  }
  translate([plug_l / 2 - slot_l / 2, plug_w / 2, -$e])
    cube([slot_l, slot_w, total_h + 2 * $e]);
}
