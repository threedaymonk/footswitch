$fs = $preview ? 1 : 0.1;
$fa = $preview ? 3 : 2;

// Mounting holes
mh_sep = 30; // separation
mh_dia = 3; // diameter

lip = 2;
distance_from_edge = 20;
margin = 6;
thickness = 5;

width = mh_sep + margin * 2;

module lip() {
  translate([-width / 2, distance_from_edge])
    square([width, lip]);
}

module mounting_holes(r) {
  circle(r = r);
  for (k = [-1, 1])
    scale([k, 1])
      translate([mh_sep / 2, 0])
        circle(r = r);
}

module alignment() {
  for (y = [distance_from_edge + lip, -margin])
    translate([0, y])
      circle(r = 0.5, $fn = 4);
}

linear_extrude(thickness) {
  difference() {
    hull() {
      mounting_holes(r = margin);
      lip();
    }
    mounting_holes(r = mh_dia / 2);
    alignment();
  }
}

linear_extrude(thickness + lip) {
  difference() {
    lip();
    alignment();
  }
}
