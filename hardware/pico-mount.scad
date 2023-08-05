$fs = $preview ? 1 : 0.1;
$fa = $preview ? 3 : 2;

$nozzle = 0.4;

// Switches
sw_dia = 12;
sw_sep = [80, 70];
sw_th = 2;

// Microcontroller
uc_screws = [47, 11.4];
uc_screw_dia = 1.8;
uc_th = 5;

module frame() {
  outer_dia = sw_dia + 8 * $nozzle;
  centers = [for(k = [-1, 1]) [k * sw_sep[0] / 2, k * sw_sep[1] / 2]];

  for(ky = [-1, 1]) scale([1, ky]) {
    for(xy = centers) translate(xy) {
      difference() {
        circle(d = outer_dia);
        circle(d = sw_dia);
      }
    }

    difference() {
      hull() for(i = [0, 1]) translate(centers[i]) circle(d = outer_dia);
      hull() for(i = [0, 1]) translate(centers[i]) circle(d = sw_dia);
    }
  }
}

module uc_mount() {
  uc_post_dia = uc_screw_dia + 6 * $nozzle;

  for(ky = [-1, 1]) scale([1, ky]) {
    difference () {
      hull() for(kx = [-1, 1])
        translate([kx * uc_screws[0] / 2, uc_screws[1] / 2])
          circle(d = uc_post_dia);
      for(kx = [-1, 1])
        translate([kx * uc_screws[0] / 2, uc_screws[1] / 2])
          circle(d = uc_screw_dia);
    }
  }
}

linear_extrude(sw_th) frame();
linear_extrude(uc_th) uc_mount();
