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

TOLERANCE = 0.5;
SHELF_FULL_HEIGHT = 34;

SHELF_BASE_THICKNESS = 4;
SHELF_WALL_THICKNESS = 3;
SHELF_BATTERY_SPACE = 25;
SHELF_FIN_HEIGHT = 4;
SHELF_FULL_DEPTH = SHELF_BATTERY_SPACE + 2*SHELF_WALL_THICKNESS;

CLIP_TOP_THICKNESS = 4;
CLIP_LENGTH = 20;

//color("red")
//translate([0,-9,8])
//rotate([0,180,180])
//base();

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

module shelf() {
    difference(){
        cube([STRIP_WIDTH-TOLERANCE, SHELF_FULL_DEPTH, SHELF_FULL_HEIGHT], true);  
        
        translate([0,0,SHELF_BASE_THICKNESS])
        cube([STRIP_WIDTH, SHELF_BATTERY_SPACE, SHELF_FULL_HEIGHT], true);          
        
        translate([0,SHELF_BATTERY_SPACE/2,SHELF_BASE_THICKNESS+SHELF_FIN_HEIGHT])
        cube([STRIP_WIDTH, SHELF_BATTERY_SPACE, SHELF_FULL_HEIGHT], true);
    }
}

module clip() {
    clip_depth = HOLDER_THICKNESS + CLIP_WALL_THICKNESS;
    difference(){
        cube([STRIP_WIDTH-TOLERANCE, clip_depth, SHELF_FULL_HEIGHT], true);  
        translate([0,CLIP_WALL_THICKNESS+TOLERANCE,-CLIP_TOP_THICKNESS])
        cube([STRIP_WIDTH, clip_depth, SHELF_FULL_HEIGHT], true);  
        
        translate([0,-TOLERANCE,-CLIP_LENGTH])        
        cube([STRIP_WIDTH, clip_depth, SHELF_FULL_HEIGHT], true);          
    }
}

module basket(){    
    clip_depth = HOLDER_THICKNESS + CLIP_WALL_THICKNESS;    
    union(){        
        translate([0,SHELF_FULL_DEPTH/2,0])        
        shelf();
        translate([0,-clip_depth/2,0])
        clip();
    }
}
