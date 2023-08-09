lip = 2;
inset = 7;
width = 10;

module edge() {
  linear_extrude(lip * 2)
    translate([-lip, 0]) square([lip + width + inset, lip]);
  linear_extrude(lip)
    translate([-lip, -inset]) square([lip + width + inset, lip + inset]);
}

edge();
mirror([1, 1]) edge();
