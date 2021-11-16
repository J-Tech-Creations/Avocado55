module cherry_stem(stem_height, stemType=1) {
    if (stemType==1) {
        stem_outer_size = 6.0;
        stem_cross_length = stem_outer_size - 1.4;
        stem_cross_h = 1.3;
        stem_cross_v = 1.3;
        stem_inside_height = 4.5;
        stem_taper_thickness = (stem_height - 6 > 5) ? 5 : (stem_height - 6);
        translate([0,0,1]) {
            difference() {
                intersection(){
                    cylinder(d = stem_outer_size, h = stem_height);
                    cube([stem_outer_size-0.2,stem_outer_size-0.4,100 ],center=true);
                }

                translate([- stem_cross_h / 2, - stem_cross_length / 2, -0.01]) {
                    cube([stem_cross_h, stem_cross_length, stem_inside_height]);
                }
                translate([- stem_cross_length / 2, - stem_cross_v / 2, -0.01]) {
                    cube([stem_cross_length, stem_cross_v, stem_inside_height]);
                }
            }
            rotate_extrude (angle=360, convexity = 10) {
                polygon(points=[[stem_outer_size / 2 , stem_inside_height],[stem_outer_size / 2,stem_height],[stem_outer_size / 2 + stem_taper_thickness ,stem_height]]);
            }
        }
    } 

    if (stemType==2) {
        stem_outer_size = 5.7;
        stem_cross_length = stem_outer_size - 1.4;
        stem_cross_h = 1.3;
        stem_cross_v = 1.3;
        stem_inside_height = 4.5;
        stem_taper_thickness = (stem_height - 6 > 5) ? 5 : (stem_height - 6);
        translate([0,0,1]) {
            difference() {
                intersection(){
                    cylinder(d = stem_outer_size, h = stem_height);
                    cube([stem_outer_size-0.2,stem_outer_size-0.4,100 ],center=true);
                }

                translate([- stem_cross_h / 2, - stem_cross_length / 2, -0.01]) {
                    cube([stem_cross_h, stem_cross_length, stem_inside_height]);
                }
                translate([- stem_cross_length / 2, - stem_cross_v / 2, -0.01]) {
                    cube([stem_cross_length, stem_cross_v, stem_inside_height]);
                }
            }
            rotate_extrude (angle=360, convexity = 10) {
                polygon(points=[[stem_outer_size / 2 , stem_inside_height],[stem_outer_size / 2,stem_height],[stem_outer_size / 2 + stem_taper_thickness ,stem_height]]);
            }
        }
    } 
}

module TrackballKey(key_bottom_size, key_top_height, wide1=3, wide2=3,pull_z_minus = 3,shiftx=0,down_wing=0) {
    key_inner_height = key_top_height - 1.2;
    thickness = 1.2;
    letterHeight = key_top_height - 0.4;

    // stem
    intersection() {
        cherry_stem(key_inner_height);
        TrackballKey_outside(key_bottom_size,key_top_height,wide1,wide2,pull_z_minus=pull_z_minus,inside=false,shiftx=shiftx,down_wing=down_wing,fill=true);
    }
    difference(){
        TrackballKey_outside(key_bottom_size,key_top_height,wide1,wide2,pull_z_minus=pull_z_minus,inside=false,shiftx=shiftx,down_wing=down_wing);
        translate([0,0,-0.01])TrackballKey_outside(key_bottom_size-2,key_top_height-2.5,wide1,wide2,pull_z_minus=pull_z_minus,down_wing=down_wing);
    }
}
module TrackballKey_outside (key_bottom_size, key_top_height,wide1=0,wide2=3,pull_z_minus = 3, inside=true, shiftx = 0, down_wing=0,fill=false) {

    bottom_round = 3;
    bottom_round_top = 1.5;
    bottom_move = (key_bottom_size/2-bottom_round);
    bottom_wide_1 = (key_bottom_size/2-bottom_round+wide1);
    bottom_wide_2 = (key_bottom_size/2-bottom_round+wide2);
    spherer = 59 - pull_z_minus * 3;
    if (inside){
        intersection() {
            translate([0,8,-spherer+key_top_height]) sphere(r=spherer);
            hull() {
                translate([bottom_move,bottom_move,0]) cylinder(key_top_height+10,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([bottom_move,-bottom_move,0]) cylinder(key_top_height+10,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([-bottom_move,bottom_move,0]) cylinder(key_top_height+10,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([-bottom_move,-bottom_move,0]) cylinder(key_top_height+10,bottom_round,bottom_round-bottom_round_top,$fn=20);
            }
        }
    } else {
        intersection() {
            translate([0,8,-spherer+key_top_height]) sphere(r=spherer);
            hull() {
                translate([bottom_move,bottom_move,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([bottom_move,-bottom_move,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([-bottom_move,bottom_move,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([-bottom_move,-bottom_move,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
            }
        }
    }
    if (!inside) {
        intersection() {
            difference(){
                translate([0,8,-spherer+key_top_height]) sphere(r=spherer);
                if (!fill){
                    translate([0,8,-spherer+key_top_height-2.5]) sphere(r=spherer);
                }
            }
            hull() {
                translate([bottom_wide_1+shiftx,bottom_move,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([bottom_wide_2+shiftx,-bottom_move-down_wing,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([-bottom_wide_1+shiftx,bottom_move,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
                translate([-bottom_wide_2+shiftx,-bottom_move-down_wing,0]) cylinder(key_top_height,bottom_round,bottom_round-bottom_round_top,$fn=20);
            }
        }
    }
}
$fs = 0.1;
$fa = 2;
PI = 3.1415926;

key_bottom_size = 18;
key_top_size = 16;
key_top_height = 7;

    translate ([0,-30,0])    TrackballKey(key_bottom_size-0.5, 10,wide1 = 0,wide2=0,pull_z_minus = 12,down_wing=0); // 7-1, 11-1
    translate ([30,-30,0])    TrackballKey(key_bottom_size-0.5, 16,wide1 = 0,wide2=0,pull_z_minus = 13.5,down_wing=0); // 7-2, 11-2
    translate ([0,0,0])    TrackballKey(key_bottom_size-0.5, 10,wide1 = 0,wide2=0,pull_z_minus = 12,down_wing=0); // 7-1, 11-1
    translate ([30,0,0])    TrackballKey(key_bottom_size-0.5, 16,wide1 = 0,wide2=0,pull_z_minus = 13.5,down_wing=0); // 7-2, 11-2
    translate ([60,0,0])    TrackballKey(key_bottom_size-0.5, 19,wide1 = 0,wide2=0,pull_z_minus = 13.8,down_wing=0); // 0, 6
    translate ([0,30,0])    TrackballKey(key_bottom_size-0.5, 17.5,wide1 = 0,wide2=0,pull_z_minus = 13.6,down_wing=0); // 8, 10
    translate ([60,30,0])    TrackballKey(key_bottom_size-0.5, 19,wide1 = 0,wide2=0,pull_z_minus = 13.8,down_wing=0); // 0, 6
    translate ([60,60,0])    TrackballKey(key_bottom_size-0.5, 17.5,wide1 = 0,wide2=0,pull_z_minus = 13.6,down_wing=0); // 8, 10
    translate ([30,30,0])    TrackballKey(key_bottom_size-0.5, 17,wide1 = 0,wide2=0,pull_z_minus = 13.8,down_wing=0); // 9
    translate ([0,60,0])    TrackballKey(key_bottom_size-0.5, 11,wide1 = 0,wide2=0,pull_z_minus = 12.5,down_wing=0); // 1,5
    translate ([30,60,0])    TrackballKey(key_bottom_size-0.5, 9,wide1 = 0,wide2=0,pull_z_minus = 10.5,down_wing=0); // 2,4
    translate ([0,90,0])    TrackballKey(key_bottom_size-0.5, 11,wide1 = 0,wide2=0,pull_z_minus = 12.5,down_wing=0); // 1,5
    translate ([30,90,0])    TrackballKey(key_bottom_size-0.5, 9,wide1 = 0,wide2=0,pull_z_minus = 10.5,down_wing=0); // 2,4
