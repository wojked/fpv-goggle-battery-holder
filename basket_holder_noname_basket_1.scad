CLIP_HEIGHT = 10;
CLIP_WALL_THICKNESS = 3.0;
CLIP_SIDE_WALL_THICKNESS = 3.0;

CLIP_MIDDLE_WALL = 4;
MIDDLE_FIN_HEIGHT = 20;

STRIP_THICKNESS = 3.0; // 2.2 without velcro
STRIP_WIDTH = 24; // 24


HOLDER_OFFSET = 10;
HOLDER_THICKNESS = 4;
HOLDER_WIDTH = 24;

BASKED_WALL_THICKNESS = 3;
BASKET_HEIGHT = 40;

TOLERANCE = 0.05;
SHELF_FULL_HEIGHT = 45;

SHELF_BASE_THICKNESS = 4;
SHELF_WALL_THICKNESS = 4;
SHELF_BATTERY_SPACE = 22; // 25
SHELF_FIN_HEIGHT = 9.5;
SHELF_FULL_DEPTH = SHELF_BATTERY_SPACE + 2*SHELF_WALL_THICKNESS;

CLIP_TOP_THICKNESS = 4;
CLIP_LENGTH = 25;
CLIP_ZIP_OFFSET = 6;

ZIP_TIE_WIDTH = 2.65;
ZIP_TIE_THICKNESS = 1.50;
ZIP_TIE_OFFSET = 12;
ZIP_TIE_LENGTH = 100; // NOT THAT RELEVEANT

EXTRA_SHELF_WIDTH = 6;

//color("red")
//translate([0,-9,14])
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
        
        translate([0,HOLDER_THICKNESS-TOLERANCE,-CLIP_TOP_THICKNESS])
        cube([STRIP_WIDTH, clip_depth, SHELF_FULL_HEIGHT], true);  
        
        translate([0,-TOLERANCE,-CLIP_LENGTH])        
        cube([STRIP_WIDTH, clip_depth, SHELF_FULL_HEIGHT], true);          
    }
}

module zip_tie() {
        cube([ZIP_TIE_LENGTH, ZIP_TIE_THICKNESS, ZIP_TIE_WIDTH], true);      
}

module extra_shelf() {
    difference(){
        cube([EXTRA_SHELF_WIDTH, SHELF_BATTERY_SPACE, SHELF_BASE_THICKNESS], true);
        rotate([90,0,90])
        zip_tie();    
    }
}

module basket(){    
    clip_depth = HOLDER_THICKNESS + CLIP_WALL_THICKNESS;    
    difference(){
        union(){   
            // Main shelf for the battery
            translate([0,SHELF_FULL_DEPTH/2,0])        
            shelf();
            
            // Extra shelf
            translate([-(STRIP_WIDTH + EXTRA_SHELF_WIDTH)/2,SHELF_FULL_DEPTH/2,-(SHELF_FULL_HEIGHT-SHELF_BASE_THICKNESS)/2])
            extra_shelf();            
            
            // Clip
            translate([0,-clip_depth/2,0])
            clip();
        }
        translate([0,SHELF_WALL_THICKNESS/2,ZIP_TIE_OFFSET])        
        zip_tie();
        
        translate([0,-CLIP_WALL_THICKNESS - HOLDER_THICKNESS/2,CLIP_ZIP_OFFSET])
        zip_tie();        
    }          
}
