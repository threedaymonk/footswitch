d_outer = 17.5;
d_inner = 12;
height = 1.5;

$fs = 0.5;
$fa = 0.5;
$e = 0.001;

difference() {
  cylinder(r = d_outer / 2, h = height);
  translate([ 0, 0, -$e ]) cylinder(r = d_inner / 2, h = height + 2 * $e);
}
