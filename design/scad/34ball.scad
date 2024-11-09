ballWithBase2();
ballsize = 34;
module ballWithBase2() {
  hull() {
translate([0,0,(ballsize + 0.5)/2+0.5])sphere(r=(ballsize + 0.5)/2,$fn=200);
translate([0,0,(ballsize-2)/2])sphere(r=(ballsize + -2)/2,$fn=200);

  }

for(i=[0:19]) {
  rotate([0,0,360/20*i]) translate([0,0,0]) cube([(ballsize/3)+(i==5?10:0),0.8,20+(i==5?5.2:0)+(i>4 && i < 10 ?10:0)]);
}
linear_extrude(height=0.5+ballsize + 0.5) square(8,center=true);
}