$fs = $preview ? 1 : 0.1;
$fa = $preview ? 3 : 2;

$nozzle = 0.4;

inner_dia = 12.5;
height = 3.4;
width = 4 * $nozzle;
outer_dia = inner_dia + 2 * width;

linear_extrude(height) {
  intersection() {
    difference() {
      circle(d = outer_dia);
      circle(d = inner_dia);
    }
    translate([-outer_dia / 2, -outer_dia / 2]) square([outer_dia / 2, outer_dia]);
  }
  for (k = [-1, 1]) scale([1, k]) {
    translate([0, (outer_dia + inner_dia) / 4]) {
      hull() {
        circle(d = width);
        translate([inner_dia / 4, 0]) circle(d = width);
      }
    }
  }
  hull() {
    translate([-(outer_dia + inner_dia) / 4, 0]) circle(d = width);
    translate([-outer_dia, 0]) circle(d = width);
  }
}
