CLIP_HEIGHT = 10;
CLIP_WALL_THICKNESS = 3.0;
CLIP_SIDE_WALL_THICKNESS = 3.0;

CLIP_MIDDLE_WALL = 4;
MIDDLE_FIN_HEIGHT = 20;

STRIP_THICKNESS = 3.0; // 2.2 without velcro
STRIP_WIDTH = 24;


HOLDER_OFFSET = 10;
HOLDER_THICKNESS = 4;
HOLDER_WIDTH = 24;

BASKED_WALL_THICKNESS = 3;
BASKET_HEIGHT = 40;

BATTERY_L_SHELF_HEIGHT = 10;

rotate([0,180,0])
base();

translate([0,0, (MIDDLE_FIN_HEIGHT)/2-6])
translate([0,-3,0])
color("red")
basket();



module base(){
    clip_thickness = CLIP_WALL_THICKNESS*2 + CLIP_MIDDLE_WALL + STRIP_THICKNESS + HOLDER_THICKNESS;
    clip_width = CLIP_SIDE_WALL_THICKNESS*2 + STRIP_WIDTH;
    union(){
        difference(){
            translate([0,(STRIP_THICKNESS - HOLDER_THICKNESS)/2,0])
            cube([clip_width, clip_thickness,CLIP_HEIGHT], true);

            translate([0,STRIP_THICKNESS/2 + CLIP_MIDDLE_WALL/2,0])
            cube([STRIP_WIDTH,STRIP_THICKNESS,CLIP_HEIGHT*2], true);
            
            translate([0,-HOLDER_THICKNESS/2 - CLIP_MIDDLE_WALL/2,0])        
            cube([HOLDER_WIDTH,HOLDER_THICKNESS,CLIP_HEIGHT*2], true);
            
        };
        translate([0,0, (CLIP_HEIGHT + MIDDLE_FIN_HEIGHT)/2])
        cube([clip_width, CLIP_MIDDLE_WALL, MIDDLE_FIN_HEIGHT], true);        
    }  
}

module basket(){    
    union(){
        cube([STRIP_WIDTH, HOLDER_THICKNESS, CLIP_HEIGHT+MIDDLE_FIN_HEIGHT+HOLDER_THICKNESS], true);
        
        translate([0,-STRIP_TOP_LENGTH/2,(CLIP_HEIGHT+MIDDLE_FIN_HEIGHT-STRIP_TOP_THICKNESS)/2])
        cube([STRIP_WIDTH, STRIP_TOP_LENGTH, HOLDER_THICKNESS+STRIP_TOP_THICKNESS], true);        
        
        translate([0,-(STRIP_TOP_LENGTH+BASKED_WALL_THICKNESS)/2,(CLIP_HEIGHT+MIDDLE_FIN_HEIGHT-STRIP_TOP_THICKNESS)/2 - BASKET_HEIGHT/2])        
        cube([STRIP_WIDTH, HOLDER_THICKNESS, BASKET_HEIGHT], true);        
//        
//        translate([0,-(STRIP_TOP_LENGTH+BASKED_WALL_THICKNESS)/2,(CLIP_HEIGHT+MIDDLE_FIN_HEIGHT-STRIP_TOP_THICKNESS)/2 - BASKET_HEIGHT])      
//        cube([STRIP_WIDTH, STRIP_TOP_LENGTH, HOLDER_THICKNESS+STRIP_TOP_THICKNESS], true);        
        
//        translate([0,-(STRIP_TOP_LENGTH+BASKED_WALL_THICKNESS)/2,(CLIP_HEIGHT+MIDDLE_FIN_HEIGHT-STRIP_TOP_THICKNESS)/2 - BASKET_HEIGHT])      
//        cube([STRIP_WIDTH, HOLDER_THICKNESS, BASKET_HEIGHT], true);    
    }
}
