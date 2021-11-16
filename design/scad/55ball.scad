ballWithBase2();
module ballWithBase2() {
  hull() {
translate([0,0,55.5/2+0.5])sphere(r=55.5/2,$fn=200);
translate([0,0,53/2])sphere(r=53/2,$fn=200);

  }

for(i=[0:19]) {
  rotate([0,0,360/20*i]) translate([0,0,0]) cube([18+(i==5?10:0),0.8,20+(i==5?26.2:0)+(i>4 && i < 10 ?10:0)]);
}
linear_extrude(height=0.5+55.5) square(8,center=true);
}