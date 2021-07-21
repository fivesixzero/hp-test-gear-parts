/* HP Front Panel Side Trim
 * 
 * Settings for two different variants are provided.
 * 
 * The "3748A" variant dimensions include slightly different positioning that may fit better on some gear.
 *   These settings work great with the 3478A in my lab but your mileage may vary.
 * 
 * The "6644A" variant dimensions include what appears to be more standard positioning that should fit a 
 *   wider variety of gear and has been tested with other HP gear in my lab, including a late-model 11713A
 *   and a mil-spec 5328A.
 */

/*[ Panel dimensions]*/ 
panel_length = 78.5; // HP 6644A (also 11713A, 5328A) Dimensions
panel_width = 12.7;
panel_depth = 2.5;

//panel_length = 78.5; // HP 3478A Dimensions
//panel_width = 12.7; 
//panel_depth = 2.5;

/*[ Post positions and dimensions]*/
center_post = false; // HP 6644A Dimensions
post_spacing = 21.95;  // From center point 
post_depth = 3;
post_diameter = 2.9;
post_offset = 0;  // From center point
bottom_post_offset = 0.5;

//center_post = false; // HP 3478A Dimensions
//post_spacing = 22.25;  // From center point
//post_depth = 3;
//post_diameter = 2.9;
//post_offset = -0.45;
//bottom_post_offset = 0;

/*[ Center Cutout]*/
center_cutout = true;  //  False for 3478A, True for models like 66xxA/6060B that have front panel retention screws
center_cutout_diameter = 8;
center_cutout_depth = 1;

/*[ Tape Divots]*/
tape_divots = true;  // Set both of these to true if you want recessed areas to apply thicker double-sided tapes
center_divot = true;
tape_divot_spacing = 31;
tape_divot_depth = 0.3;   // Typically ~half the thickness of the tape being used
tape_divot_width = 25.6;

module __customizer_limit__() {} // End Customizer vars
// Global Variables
$fs = 0.02; // Set facet size to 0.02mm for relatively high arc resolution
$fa = 2.5;  // Set max facet angle to 2.5 degrees for relatively high arc resolution
 
module side_trim() {
    union() {
        
        // Primary plate and cutouts
        difference() {
            cube([panel_length, panel_width, panel_depth]);
            
            if (tape_divots) {
                if (center_divot) {
                translate([panel_length/2, panel_width/2, panel_depth - tape_divot_depth/2])
                    cube([tape_divot_width, panel_width, tape_divot_depth], center = true);
                }
                translate([panel_length/2 - (tape_divot_spacing), panel_width/2, panel_depth - tape_divot_depth/2])
                    cube([tape_divot_width/2, panel_width, tape_divot_depth], center = true);
                translate([panel_length/2 + tape_divot_spacing, panel_width/2, panel_depth - tape_divot_depth/2])
                    cube([tape_divot_width/2, panel_width, tape_divot_depth], center = true);
            }
            
            if (center_cutout) {
                translate([panel_length/2, panel_width/2, panel_depth - center_cutout_depth])
                    cylinder(h = center_cutout_depth, r1 = center_cutout_diameter/2, r2 = (center_cutout_diameter/2) + center_cutout_depth, center = false);
            }
            
        }
        
        if (center_post) {
            translate([panel_length/2, panel_width/2, panel_depth]) 
                cylinder(h = post_depth, r = post_diameter/2, center = false);
        }
        
        translate([(panel_length/2 + post_offset) - post_spacing, panel_width/2, panel_depth]) 
            cylinder(h = post_depth, r = post_diameter/2, center = false);
        translate([(panel_length/2 + post_offset) + post_spacing + bottom_post_offset, panel_width/2, panel_depth]) 
            cylinder(h = post_depth, r = post_diameter/2, center = false);

    }
}

side_trim();