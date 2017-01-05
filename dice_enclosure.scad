dice_dimension = 40.0;
shell_dimension = 34.0;
dice_half = dice_dimension / 2.0;
matrix_dimension = 21.0;

module base_dice() {
    intersection() {
        translate([-dice_dimension/2,-dice_dimension/2,-dice_dimension/2-3]) {
            cube([dice_dimension,dice_dimension,dice_dimension+3]);
        }
        sphere(dice_dimension/1.5);
    }       
}

module inner_shell() {
    difference() {
        intersection() {
            translate([-shell_dimension/2,-shell_dimension/2,-dice_dimension/2+3]) {
                cube(shell_dimension);
            }
            sphere(shell_dimension/1.5);
        }
        
        masking_triangle_size = 50.0;
        masking_triangle_height = 100.0;       
        corner_offset = 15.5;
        corner_mask_outer = shell_dimension + 20;        
        corner_mask_inner = corner_mask_outer-corner_offset;
        corner_mask_height = 100;
        translate([0,-corner_mask_outer*sqrt(2)/2, -corner_mask_height/2]) {
            rotate([0,0,45]) {           
                difference() {           
                    cube([corner_mask_outer,corner_mask_outer,101]);       
                    translate([corner_offset/2,corner_offset/2,-(corner_offset)/2]) {
                        cube([corner_mask_inner,corner_mask_inner,corner_mask_height+(corner_offset)/2+1.5]);
                    }
                }
            }
        }
    }
}

module outer_screw_holes() {
    screw_length = 12.0;
    outer_screw_hole_r = 1.5;
    outer_screw_hole_offset = 3.5;
    
    top_hole_r = 2.5;
    captive_nut_r = 2.5;
    
    /******************/
    translate([dice_half-outer_screw_hole_offset, dice_half-outer_screw_hole_offset, -dice_half]){
        cylinder(h=dice_dimension, r=outer_screw_hole_r,$fn=100);
    }
    translate([dice_half-outer_screw_hole_offset, dice_half-outer_screw_hole_offset, screw_length/2]){
        cylinder(h=screw_length, r=top_hole_r,$fn=100);
    }
    translate([dice_half-outer_screw_hole_offset, dice_half-outer_screw_hole_offset, -screw_length*1.5]){
        cylinder(h=screw_length, r=captive_nut_r,$fn=6);    
    }
    /******************/
    translate([-dice_half+outer_screw_hole_offset, dice_half-outer_screw_hole_offset, -dice_half]){
        cylinder(h=dice_dimension, r=outer_screw_hole_r,$fn=100);
    }
    translate([-dice_half+outer_screw_hole_offset, dice_half-outer_screw_hole_offset, screw_length/2]){
        cylinder(h=screw_length, r=top_hole_r,$fn=100);
    }
    translate([-dice_half+outer_screw_hole_offset, dice_half-outer_screw_hole_offset, -screw_length*1.5]){
        cylinder(h=screw_length, r=captive_nut_r,$fn=6);    
    }
    /******************/
    translate([dice_half-outer_screw_hole_offset, -dice_half+outer_screw_hole_offset, -dice_half]){
        cylinder(h=dice_dimension, r=outer_screw_hole_r,$fn=100);
    }
    translate([dice_half-outer_screw_hole_offset, -dice_half+outer_screw_hole_offset, screw_length/2]){
        cylinder(h=screw_length, r=top_hole_r,$fn=100);
    }
    translate([dice_half-outer_screw_hole_offset, -dice_half+outer_screw_hole_offset, -screw_length*1.5]){
        cylinder(h=screw_length, r=captive_nut_r,$fn=6);    
    }
    /******************/
    translate([-dice_half+outer_screw_hole_offset, -dice_half+outer_screw_hole_offset, -dice_half]){
        cylinder(h=dice_dimension, r=outer_screw_hole_r,$fn=100);
    }
    translate([-dice_half+outer_screw_hole_offset, -dice_half+outer_screw_hole_offset, screw_length/2]){
        cylinder(h=screw_length, r=top_hole_r,$fn=100);
    }
    translate([-dice_half+outer_screw_hole_offset, -dice_half+outer_screw_hole_offset, -screw_length*1.5]){
        cylinder(h=screw_length, r=captive_nut_r,$fn=6);    
    }
}

module matrix_cutout() {
    
    thickness = 10.0;
    translate([-matrix_dimension/2,-matrix_dimension/2,dice_half-thickness+0.1+3]) {
        cube([matrix_dimension, matrix_dimension, thickness]);  
    }        
}

module matrix_mount_bolts() {
    screw_length = 12.0;
    outer_screw_hole_r = 1.5;  
    screw_hole_r = 3.5;  
    x_offset = 3.0;
    y_offset = 2.0;
    top_hole_r = 2.5;
    translate([-matrix_dimension/2+x_offset,-matrix_dimension/2-y_offset, 0]){
        cylinder(h=screw_length, r=outer_screw_hole_r,$fn=100);
    }
    translate([-matrix_dimension/2+x_offset,-matrix_dimension/2-y_offset, 6]){
        cylinder(h=screw_length, r=screw_hole_r,$fn=6);
    }
    
    translate([matrix_dimension/2-x_offset,-matrix_dimension/2-y_offset, 0]){
        cylinder(h=screw_length, r=outer_screw_hole_r,$fn=100);
    }
    translate([matrix_dimension/2-x_offset,-matrix_dimension/2-y_offset, 6]){
        cylinder(h=screw_length, r=screw_hole_r,$fn=6);
    }
    
    translate([-matrix_dimension/2+x_offset,matrix_dimension/2+y_offset, -screw_length/2]){
        cylinder(h=screw_length, r=outer_screw_hole_r,$fn=100);
    }
    translate([-matrix_dimension/2+x_offset,matrix_dimension/2+y_offset, 6]){
        cylinder(h=screw_length, r=screw_hole_r,$fn=6);
    }
    
    translate([matrix_dimension/2-x_offset,matrix_dimension/2+y_offset, -screw_length/2]){
        cylinder(h=screw_length, r=outer_screw_hole_r,$fn=100);
    }
    translate([matrix_dimension/2-x_offset,matrix_dimension/2+y_offset, 6]){
        cylinder(h=screw_length, r=screw_hole_r,$fn=6);
    }
}

module matrix_mount_bolt_spacer() {
    thickness = 2.0;
  translate([-matrix_dimension/2,-matrix_dimension/2-3.5,dice_dimension/2-5]) {
                cube([21, 3.5, thickness]);  
            }
    translate([-matrix_dimension/2,-matrix_dimension/2-3.5,dice_dimension/2-6]) {
                cube([21, 3.5, 2.25]);  
            }
       
    translate([-matrix_dimension/2,matrix_dimension/2,dice_dimension/2-5]) {
                cube([21, 3.5, thickness]);  
            }
    translate([-matrix_dimension/2,matrix_dimension/2,dice_dimension/2-6]) {
                cube([21, 3.5, 2.25]);  
            }
}

module top_mask_cube() {
    cube_size = 100.0;
    half_cube_size = cube_size/2;
    translate([-cube_size/2,-cube_size/2,-cube_size]) {
        cube(cube_size);
    }
}

module bottom_mask_cube() {
    cube_size = 100.0;    
    translate([-cube_size/2,-cube_size/2,0]) {
        cube(cube_size);
    }
}

module side_hole() {      
    rotate([0,90,0]) {
        translate([-5,0,0]){
            cylinder(h=dice_dimension/2, r=1.5,$fn=100);
        }
        
        translate([-5,0,dice_dimension/2-1.0]){
            cylinder(h=dice_dimension/2, r=3.0,$fn=100);
        }
        
        translate([-5,0,-dice_dimension+5]){
            cylinder(h=dice_dimension/2, r=1.5,$fn=100);
        }
        
        translate([-5,0,-dice_dimension+1]){
            cylinder(h=dice_dimension/2, r=3.0,$fn=100);
        }
    }
}


top_or_bottom = 1; //0 - both, 1 - top, 2 - bottom

module dice_top() {
    difference() {         
        rotate([180,0,0]) {
            translate([0,0,-dice_dimension/2]) {
              difference() {          
                difference() {  
                    difference() {
                        base_dice();
                        matrix_cutout();
                        outer_screw_holes();                        
                        
                        if(top_or_bottom == 1) {
                            top_mask_cube();
                        }
                        else if(top_or_bottom == 2) {
                            bottom_mask_cube();
                        }
                        inner_shell();              
                    }                                                        
                }           
                side_hole();
            }
        }
        
            translate([0,0,-dice_dimension/2]) {
                matrix_mount_bolt_spacer(); 
            }
        }    
    }
}

module power_button_opening() {    
    rotate([0,180,0]) {
        translate([-50-4.5,-9,-3]) {
            intersection() {
                cube([8,25,4]);
                translate([4, 9,0]) {
                    cylinder(h=4,r=6.25, $fn=100);
                }
            }
            
            translate([4,9,4]) {
                cylinder(h=10, r=3.5, $fn=100);
            }
            translate([2.25,0,-6]) {
                cube([3,3, 10]);
            }
            translate([2.25,15,-6]) {
                cube([3,3, 10]);
            }
        }
    }
}

module dice_bottom() {
    translate([50,0,dice_dimension/2]) {        
        difference() {
            base_dice();       
            outer_screw_holes();                       
            bottom_mask_cube();            
            inner_shell();
        }      
    }
}

dice_top();

//bottom section
difference() {
    dice_bottom();
    translate([25,-25,-10]) {
        cube([50,50,5]);
    }
    power_button_opening();
}
    
    

 