module wristrest () {
  halfwidth=50;
  difference() {
    union() {
  hull() {
    translate([0,-20,0])cylinder(r=70,h=2);
    translate([-halfwidth,-pull,0])cylinder(r=40,h=2);
    translate([halfwidth,-pull,0])cylinder(r=40,h=2);

  }
  high=60;
  depth=5;
  pull=100;
    hull(){
      translate([halfwidth,-pull,0]) resize(newsize=[80,80,high]) sphere(r=40);
      translate([-20,-pull,0]) resize(newsize=[80-depth*2,80-depth*3,high-depth*3]) sphere(r=40-depth*3);
    }
    hull(){
      translate([-halfwidth,-pull,0]) resize(newsize=[80,80,high]) sphere(r=40);
      translate([20,-pull,0]) resize(newsize=[80-depth*2,80-depth*3,high-depth*3]) sphere(r=40-depth*3);
    }
    hull(){
      translate([-20,-pull,0]) resize(newsize=[80-depth*3,80-depth*3,high-depth]) sphere(r=40-depth*3);
      translate([20,-pull,0]) resize(newsize=[80-depth*3,80-depth*3,high-depth]) sphere(r=40-depth*3);
    }
    }
  translate([0,0,-50])cube([1000,1000,100],center=true);
      translate([0,0,5]) feet(45,180-120,5,true);
      translate([0,0,5]) feet(45,180+120,5,true);
  }
}
wristrest(); 