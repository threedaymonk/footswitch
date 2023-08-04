$fs = $preview ? 1 : 0.1;
$fa = $preview ? 3 : 2;
$e = 0.01;

// Outer plate
plate_size = [40, 20]; // size
plate_cr = 5; // corner radius
plate_th = 1.6; // thickness

// Mounting holes
mh_sep = 30; // separation
mh_dia = 3; // diameter
mh_dia_flare = 6;

// USB connector
usb_size = [12.2, 11]; // size of cutout
usb_cr = 0.5; // corner radius
usb_cr_flare = 2; // corner radius at bottom of flare

// Inset USB surround
inset_size = [15.4, 14.2]; // maximum dimensions
inset_dia = 17.4; // diameter of hole, for 11/16" stepper bit
inset_th = 4; // thickness

module rrect(size, r, center = false) {
	sx = (size[0] == undef) ? size : size[0];
	sy = (size[0] == undef) ? size : size[1];
	shift = (center == false) ? [r, r] : [r - sx / 2, r - sy / 2];

	translate(shift) minkowski() {
    square([sx - r*2, sy - r*2]);
    circle(r = r);
  }
}

module usb_cutout_3d() {
  sx = usb_size[0];
  sy = usb_size[1];
  sz = plate_th + inset_th;

	translate([usb_cr - sx / 2, usb_cr - sy / 2, -$e]) {
    minkowski() {
      cube([sx - usb_cr * 2, sy - usb_cr * 2, $e]);
      union() {
        cylinder(r = usb_cr, h = plate_th + inset_th + $e);
        cylinder(r1 = usb_cr_flare, r2 = 0, h = usb_cr_flare);
      }
    }
  }
}

module screw_holes() {
  for (k = [-1, 1]) scale([k, 1]) {
    translate([mh_sep / 2, 0, -$e]) {
      cylinder(d = mh_dia, h = plate_th + 2 * $e);
      cylinder(d1 = mh_dia_flare, d2 = 0, h = mh_dia_flare / 2);
    }
  }
}

module plate() {
  linear_extrude(plate_th) {
    rrect(plate_size, r = plate_cr, center = true);
  }
}

module inset() {
  linear_extrude(plate_th + inset_th) {
    intersection() {
      square(inset_size, center = true);
      circle(d = inset_dia);
    }
  }
}

difference() {
  union() {
    plate();
    inset();
  }
  usb_cutout_3d();
  screw_holes();
}
