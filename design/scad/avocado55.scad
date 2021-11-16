module feet(distance, angle, depth, remove) 
{
  if (remove) {
    rotate([0,0,angle]) translate([0,distance,-depth]) linear_extrude(height=2) circle(r=8);
  } else {
    rotate([0,0,angle]) translate([0,distance,-depth]) linear_extrude(height=4) circle(r=10);
  }

}

module keybody_cut (diameter,roundsize,thickness,lift,roundForBody,detail,miniballshift=70) {
  shiftm = diameter / 2 + 42.5;
  difference() {
    cube([1000,1000,1000],center=true);
    keybody_h_base(roundsize,roundForBody,detail,-roundsize+diameter/2+lift,diameter,miniballshift);
  }
}


module keyswitch_hole_base(){

  translate([0, 0, 17])cube([22.00, 22.00, 30.00], center = true);
  translate([0, 0, 1])cube([20.00, 20.00, 2.00], center = true);
  translate([0, 0, -2.5])cube([18.00, 18.00, 5.00], center = true);

}



module keybody_h_base (roundsize,roundForBody,detail,lift,diameter,miniballshift=70) {
  hull() {
    intersection() {
      translate([0,0,lift]) sphere(r=roundsize, $fn=detail);
      cylinder(r=roundForBody, h=1000, center=false, $fn=detail);
    }
    translate([0,miniballshift, 0]) difference() {
      sphere(r=diameter/2,$fn=detail);
      translate([0,0,-100]) cylinder(r=diameter/2, h=100,$fn=detail,center=false);
    }
    lrdistance=35;
    translate([cos(-30) * lrdistance,sin(-30) * lrdistance, 0]) difference() {
      sphere(r=diameter/2,$fn=detail);
      translate([0,0,-100]) cylinder(r=diameter/2, h=100,$fn=detail,center=false);
    }
    translate([cos(210) * lrdistance,sin(210) * lrdistance, 0]) difference() {
      sphere(r=diameter/2,$fn=detail);
      translate([0,0,-100]) cylinder(r=diameter/2, h=100,$fn=detail,center=false);
    }
  }
}


module keybody_h (diameter,roundsize,thickness,lift,roundForBody,detail,cupBaseYshift,miniballshift=70) {
  shiftm = diameter / 2 + 37.5;
  difference() {
    union() {
      difference () {
        keybody_h_base(roundsize,roundForBody,detail,-roundsize+diameter/2+lift,diameter,miniballshift);
        translate([0,0,-0.01]) keybody_h_base(roundsize,roundForBody-3,detail,-roundsize+diameter/2+lift-thickness,diameter-4,miniballshift);
      }
    }
    translate([0,cupBaseYshift,0]) cylinder(r=diameter/2-3, h=200, center=true);
  }
}

module keyswitch_hole(){

  translate([0, 0, 17-0.01])cube([19.00, 19.00, 30.02], center = true);
  translate([0, 0, 1-0.01])cube([16.00, 16.00, 2.02], center = true);
  translate([0, 0, -2.51])cube([14.00, 14.00, 5.02], center = true);
  translate([0, 0, -7.51])cube([19.00, 19.00, 5.02], center = true);
  //translate([0, 0, -9.5])cube([28.00, 28.00, 10.00], center = true);

  translate([0, 7, -1.9])rotate([45, 0, 0])cube([5, 0.4, 0.4], center = true);
  translate([0, -7, -1.9])rotate([45, 0, 0])cube([5, 0.4, 0.4], center = true);

}

module 55sKeyHole(index, angleStep, baseAngle, diameter, baseDistance, baseLift, baseIncline, hole) {
  angle = index * angleStep + baseAngle;
  tx =  (diameter+baseDistance)*cos(angle);
  ty = (diameter+baseDistance)*sin(angle) + ((sin(angle)>0) ? sin(angle)*2 :0);
  tz = diameter/2+baseLift + ((sin(angle)>0) ? sin(angle)*15 :0);
  incline = baseIncline - ((sin(angle)>0) ? sin(angle)*baseIncline :0) + ((sin(angle)<0) ? sin(angle)*baseIncline*0.7 :0);
  translate([tx,ty,tz]) rotate([0,incline,angle]) 
  {
    if (hole) {
        keyswitch_hole();
    } else {
        keyswitch_hole_base();
    }
  }
}

module 55sKeyHoles(angleStep, baseAngle, diameter, baseDistance, baseLift, baseIncline, hole) {
  for(i=[0:11]) {
    if (i==11 || i==7) {
      55sKeyHole(i,angleStep,baseAngle,diameter,baseDistance-7,baseLift+5,baseIncline-30,hole);
      55sKeyHole(i,angleStep,baseAngle,diameter,baseDistance+12,baseLift-3,baseIncline,hole);
    } else if (i==3){
    } else if (i==0 || i==6){
      55sKeyHole(i,angleStep,baseAngle,diameter,baseDistance,baseLift,baseIncline-30,hole);
    } else if (i==1 || i==5){
      55sKeyHole(i,angleStep,baseAngle,diameter,baseDistance+1,baseLift-2,baseIncline,hole);
    } else {
      55sKeyHole(i,angleStep,baseAngle,diameter,baseDistance,baseLift,baseIncline,hole);
    }
  }
}


module leg (diameter,far=5,height=9,isBottom,column=false,lift=12) {
  translate([diameter/2+far,0,-diameter/2-lift]) {
    if(!isBottom) {
      colwidth = (diameter > 40) ? 6:4;
      difference(){
        cylinder(h=diameter/4+height,r=colwidth);
        cylinder(h=10, r=1.25);
      }  
    } else {
      if (diameter == 34) {
        columnHeight = 5;
        columnLift = -5;
        if (column){
          translate([0,0,columnLift]) cylinder(h=columnHeight,r1=4, r2=4);
        }else{
          translate([0,0,columnLift]) cylinder(h=columnHeight-2,r1=3, r2=3);
          translate([0,0,columnLift]) cylinder(h=columnHeight,r1=1.5, r2=1.5);
        }
      } else {
        columnHeight = 2;
        columnLift = -2;
        if (column){
          translate([0,0,columnLift]) cylinder(h=columnHeight,r1=4, r2=4);
        }else{
          translate([0,0,columnLift]) cylinder(h=columnHeight,r1=3, r2=1.5);
        }
      }
    }
  }
}


module sensor () {
  hull() {              
    translate([2.75,1.75,-4])cylinder(h=2,r=8.25);
    translate([2.75,-1.75,-4])cylinder(h=2,r=8.25);
    translate([-2.75,1.75,-4])cylinder(h=2,r=8.25);
    translate([-2.75,-1.75,-4])cylinder(h=2,r=8.25);
  }
  hull() {
    translate([2.75,1.75,-19.0])cylinder(h=15,r=10);
    translate([2.75,-1.75,-19.0])cylinder(h=15,r=10);
    translate([-2.75,1.75,-19.0])cylinder(h=15,r=10);
    translate([-2.75,-1.75,-19.0])cylinder(h=15,r=10);
    translate([0,0,-19.0])cube([30,23,30],center=true);
  }
    translate([12.5,0,-12]) cylinder(r=1.25,h=10);
    translate([-12.5,0,-12]) cylinder(r=1.25,h=10);
  hull() {
    translate([-0.5,0,-2.5])cylinder(h=2.5,r1=3.5,r2=2.5);
    translate([2,0,-2.5])linear_extrude(height = 2.5, scale = 0.66) square([6.5,6.5], center=true); 
  }
}


module bearing (diameter, is_ball = false) {
if (is_ball) {
  translate([0,0,-diameter/2-4.25]) sphere(r=4,$fn=30);
}else{
  bearingVersion = 2;
  depth = (bearingVersion==1) ? -4.25 : -3;
  height = (bearingVersion==1) ? 6.25 : 7.5;

  translate([0,0,-diameter/2-1]) {
    translate([0,0,depth]) cylinder(h=7, r=7.90);
    translate([0,0,-10]) cylinder(h=height, r=6.5);
  }
}
}

module bearings (diameter, shift=0) {
  rotate([65,0,0+shift]) bearing(diameter);
  rotate([65,0,120+shift]) bearing(diameter);
  rotate([65,0,240+shift]) bearing(diameter);
}

module cup (diameter, dispBall = false,alsoInside = false,epoxy=false) {
topLift = diameter==34 ? 2 : 8;
height = diameter==34 ? 13.1 : 22;
apeature = (diameter==34 ? 3 : 0)+ (epoxy ? 1 : 0) ;
  if (dispBall) {
    color("red") sphere (r=diameter/2, $fn=50);
  }
color("gray") difference() {
  sphere (r=diameter/2 + 8.5, $fn=50);
  if (!alsoInside) {
    if (true) {
      sphere (r=diameter/2 + 1.00+ (epoxy ? 1 : 0), $fn=50);
        translate([0,0, 0]) linear_extrude(50) circle(r=diameter/2+0.5+ (epoxy ? 1 : 0), $fn=100);
        translate([0,0, topLift]) linear_extrude(50) circle(r=diameter/2 + 10);
        translate([0,0,-diameter/2-10]) difference() { 
          cylinder(h=diameter/2+height, r=diameter/2+10);
          cylinder(h=diameter/2+height, r1=diameter/2+20,r2=diameter/2+ apeature);
        }
    } else {
      sphere (r=diameter/2 + 0.5, $fn=100);
        translate([0,0, 0]) linear_extrude(50) circle(r=diameter/2+0.25, $fn=100);
        translate([0,0, topLift]) linear_extrude(50) circle(r=diameter/2 + 10);
        translate([0,0,-diameter/2-10]) difference() { 
          cylinder(h=diameter/2+height, r=diameter/2+10);
          cylinder(h=diameter/2+height, r1=diameter/2+20,r2=diameter/2+ apeature);
        }
      }
    }
}
}


module cupBase (diameter,bottomHight, isBottom=false, alsoInside = false,column=false, lift=12, small=false,no_bearing = false,only_bearing=false,bearing_shift=0,epoxy=false,dispSensor=true) {
  translate([0,0,diameter/2+lift]){
    if (only_bearing) {
      bearings(diameter,bearing_shift);
    }else{
      if (!isBottom) {
        difference() {
          union () {
          cup (diameter,alsoInside=alsoInside,epoxy=epoxy,dispBall=false);
            if (no_bearing) {
              // rotate([65,0,0]) bearing(diameter,true);
              // rotate([65,0,120]) bearing(diameter,true);
              // rotate([65,0,240]) bearing(diameter,true);
              // rotate([30,0,60]) bearing(diameter,true);
              // rotate([30,0,180]) bearing(diameter,true);
              // rotate([30,0,300]) bearing(diameter,true);
              // rotate([85,0,60]) bearing(diameter,true);
              // rotate([85,0,180]) bearing(diameter,true);
              // rotate([85,0,300]) bearing(diameter,true);
            }
          }
          if (!alsoInside) {
            if (!no_bearing) {
              bearings(diameter,bearing_shift);
            }
            if (dispSensor) {
              translate([0,0,-diameter/2-10]) cylinder(h=bottomHight, r=diameter);
              translate([0,0,-diameter/2]) sensor();
            }
          }
        }
      }
      if (diameter==34) {
        rotate([0,0,270]) leg(diameter,5,16,isBottom,column=column);
        rotate([0,0,60]) leg(diameter,10,16,isBottom,column=column);
        rotate([0,0,120]) leg(diameter,10,16,isBottom,column=column);
      }
      if (diameter==55) {
        if (small == true) {
          difference () {
            union () {
              rotate([0,0,5]) leg(diameter,-3,lift+8,isBottom,column=column,lift=lift);
              rotate([0,0,175]) leg(diameter,-3,lift+8,isBottom,column=column,lift=lift);
              rotate([0,0,90]) leg(diameter,0,lift+8,isBottom,column=column,lift=lift);
            }
            sphere (r=diameter/2 + 1.25, $fn=50);
            bearings(diameter,bearing_shift);
          }
        } else {
          rotate([0,0,270]) leg(diameter,7,lift+8,isBottom,column=column,lift=lift);
          rotate([0,0,60]) leg(diameter,7,lift+8,isBottom,column=column,lift=lift);
          rotate([0,0,120]) leg(diameter,7,lift+8,isBottom,column=column,lift=lift);
        }
      }
      if (diameter==60 || diameter == 59) {
        if (small == true) {
          difference () {
            union () {
              rotate([0,0,5]) leg(diameter,-3,lift+8,isBottom,column=column,lift=lift);
              rotate([0,0,175]) leg(diameter,-3,lift+8,isBottom,column=column,lift=lift);
              rotate([0,0,90]) leg(diameter,0,lift+8,isBottom,column=column,lift=lift);
            }
            sphere (r=diameter/2 + 1.25+ (epoxy ? 1 : 0), $fn=50);
            bearings(diameter,bearing_shift);
          }
        } else {
          rotate([0,0,270]) leg(diameter,7,lift+8,isBottom,column=column,lift=lift);
          rotate([0,0,60]) leg(diameter,7,lift+8,isBottom,column=column,lift=lift);
          rotate([0,0,120]) leg(diameter,7,lift+8,isBottom,column=column,lift=lift);
        }
      }
    }
  }
}

module trackball55s(isBottom=false, promicrohouse=true){
  diameter = 55;
  bottomHight = 4; 
  firstLift=-13;
  firstDistance =-10;
  angleStep = 30;
  angle1=0;
  roundForBody = 69;
  roundSize = 69;
  cupBaseYshift = 0;
  liftAmount = 11;
  bodylift = 17;
  splitAngle = 50;
  incline = 40;
  miniballshift=65;
  if (!isBottom){
    difference() {
      translate([0,cupBaseYshift,0]) cupBase(diameter,bottomHight,isBottom,lift=liftAmount,small=true,bearing_shift=60);
        55sKeyHoles(angleStep,angle1,diameter,firstDistance,firstLift,incline,true);
    }
  }
  color("gray") difference() {
    union(){
      if (!isBottom) {
        keybody_h(diameter+10,roundSize,3,bodylift,roundForBody=roundForBody,detail=detail,cupBaseYshift=cupBaseYshift,miniballshift=miniballshift);
        55sKeyHoles(angleStep,angle1,diameter,firstDistance,firstLift,incline,false);
        if (promicrohouse) {
          translate([-8,92,5]) rotate([0,0,90]) promicro(diameter=diameter);
          translate([0,92,5]) rotate([0,0,90]) translate([0,0,27]) cube([110,20,30],center=true);
        } else {
          translate([0,92,5]) rotate([0,0,90]) translate([0,0,27]) cube([110,20,30],center=true);
          translate([0,122,5]) rotate([0,0,90]) translate([0,0,27]) cube([110,50,30],center=true);
          difference() {
            translate([0,41,5]) rotate([0,0,90]) translate([0,0,27]) cube([10,10,50],center=true);
            translate([0,41,5]) rotate([0,0,90]) translate([0,0,2-0.001]) cylinder(h=10,r=1.8);
          }
          difference() {
            translate([16,84,5]) rotate([0,0,90]) translate([0,0,27]) cube([10,10,50],center=true);
            translate([16,84,5]) rotate([0,0,90]) translate([0,0,2-0.001]) cylinder(h=10,r=1.2);
          }
          difference() {
            translate([-16,84,5]) rotate([0,0,90]) translate([0,0,27]) cube([10,10,50],center=true);
            translate([-16,84,5]) rotate([0,0,90]) translate([0,0,2-0.001]) cylinder(h=10,r=1.2);
          }
        }
      } else {
        difference() {
          translate([0,0,-2]) keybody_h_base((roundSize+2.5),roundForBody+2.5,detail,-(roundSize+2.5)+(diameter+14)/2+bodylift,(diameter+14),miniballshift);
          translate([0,0,0]) keybody_h_base((roundSize+1),roundForBody+1,detail,-(roundSize+1)+(diameter+11)/2+bodylift,(diameter+11),miniballshift);
          translate([-500,-500,2]) cube([1000,1000,1000]);
          translate([0,cupBaseYshift,0]) cupBase(diameter,bottomHight,isBottom,alsoInside=true,small=true);
          if (promicrohouse) {
            translate([-8,92,5]) rotate([0,0,90]) promicro(isBottom);
          } else {
          translate([0,50,5]) rotate([0,0,90]) cylinder(h=100,r=4, center=true);
          }
        }
      translate([0,0,3]) feet(85,0,5,false);
      translate([0,0,3]) feet(51,180-45,5,false);
      translate([0,0,3]) feet(51,180+45,5,false);
      translate([0,0,3]) feet(53,180-120,5,false);
      translate([0,0,3]) feet(53,180+120,5,false);
      }
    }
    if (!isBottom) {
      union(){
        55sKeyHoles(angleStep,angle1,diameter,firstDistance,firstLift,incline,true);
        keybody_cut(diameter+10,roundSize,3,bodylift,roundForBody=roundForBody,detail=detail,miniballshift=miniballshift);
        translate([0,cupBaseYshift,0]) cupBase(diameter,bottomHight,isBottom,only_bearing=true,bearing_shift=60);
        if (promicrohouse) {
          translate([0,93,5]) rotate([0,0,90]) translate([0,0,7]) cube([70,20,13],center=true);
        } else {
          translate([0,93,5]) rotate([0,0,90]) translate([0,0,7]) cube([70,15,9],center=true);
        }
      }
    } else {
      translate([0,roundForBody+1,5]) {
        cube([20,7,10],center=true);
      }
      translate([0,0,3]) feet(85,0,5,true);
      translate([0,0,3]) feet(51,180-45,5,true);
      translate([0,0,3]) feet(51,180+45,5,true);
      translate([0,0,3]) feet(53,180-120,5,true);
      translate([0,0,3]) feet(53,180+120,5,true);
    }
  }
}

detail=100;
