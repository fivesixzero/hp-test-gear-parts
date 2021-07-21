/* HP Front Panel Top Trim (single unit width)
 * 
 * Works with 59303A DAC, which is a mid-70's half-width unit (half the width of, say, a 3478A)
 *
 * Two model options are provided: "single model" and "separated model"
 *
 * For SLA printers the "single model" will probably be best, since layering isn't an issue there.
 *
 * For FDM printers the "split model" is nice, since it eliminates the need for printing overhangs and makes 
 *   the visible surface of both the panel and its recessed portion nice looking, especially if you're using
 *   a textured printing surface for printing. This model can easily be glued together with CA glue or your
 *   adhesive of choice
 */
 
/*[ Panel Dimensions]*/ 
// HP 59303A Dimensions
panel_length = 96;
panel_width = 12.5;
panel_depth = 3.2;

/*[ Panel Lip Dimensions]*/
// HP 59303A Dimensions
lip_length = 81;
lip_width = 3.5;
lip_depth = 2.3;

/*[ Panel Bezel Dimensions]*/
// HP 59303A Dimensions
bezel_z_offset = 0.75;
bezel_y_offset = 13;
bezel_rotation = 45;

/*[ Post Positions and Dimensions]*/
// HP 59303A Dimensions
center_post = false;
post_spacing = 11.25;  // From center point
post_depth = 3;
post_diameter = 2.9;
post_bezel_height = 0.5;

/*[ Split Model Dimensions]*/
// HP 59303A Dimensions
model_two_y_offset = -15;
split_length = 85;
split_width = 9.5;
split_tolerance = 0.1;

module __customizer_limit__() {} // End Customizer vars
// Global Variables
$fs = 0.25; // Set facet size to 0.02mm for relatively high arc resolution
$fa = 5;  // Set max facet angle to 2.5 degrees for relatively high arc resolution

lip_thickness = panel_depth - lip_depth;

// Initial Model
module single_model() {
    union() {
        
        // Main panel and cutouts
        difference() {
            // Main panel
            cube([panel_length, panel_width, panel_depth]);
            
            // Lip Cutout
            translate([panel_length/2, lip_width/2, lip_depth/2]) 
                cube([lip_length, lip_width, lip_depth], center = true);
            
            // Bottom-Front Edge Bevel Cutout
            translate([0, bezel_y_offset, bezel_z_offset]) rotate([bezel_rotation, 0, 0]) 
                cube([panel_length, 10, 10]);
        }
        
        // Left Post
        translate([(panel_length/2) - post_spacing, panel_width/2, 3]) 
            cylinder(h = post_bezel_height, r1 = post_diameter/2 + post_bezel_height, r2 = post_diameter/2, center = false);
        translate([(panel_length/2) - post_spacing, panel_width/2, 3])
            cylinder(h = post_depth, r = 1.5, center = false);
        
        // Right Post
        translate([(panel_length/2) + post_spacing, panel_width/2, 3]) 
            cylinder(h = post_bezel_height, r1 = post_diameter/2 + post_bezel_height, r2 = post_diameter/2, center = false);
        translate([(panel_length/2) + post_spacing, panel_width/2, 3]) 
            cylinder(h = post_depth, r = post_diameter/2, center = false);

    }
}

module split_model() {
    union() {
        difference() {
            // Main panel
            cube([panel_length, panel_width, panel_depth]);
            
            // Lip Cutout
            translate([panel_length/2, lip_width/2, lip_depth/2]) 
                cube([lip_length, lip_width, lip_depth], center = true);
            
            // Bottom-Front Edge Bevel Cutout
            translate([0, bezel_y_offset, bezel_z_offset]) rotate([bezel_rotation, 0, 0]) 
                cube([panel_length, 10, 10]);
            
            // Part 2 Cutout
            translate([panel_length/2, split_width/2, lip_depth + ((lip_thickness)/2)]) 
                cube([split_length, split_width, panel_depth - lip_depth], center = true);
        }
    }
    
    // Secondary Plate
    translate([0, model_two_y_offset, 0])
        union() {
            translate([panel_length/2, 0, lip_thickness/2]) 
                cube([split_length - (split_tolerance * 2), split_width - split_tolerance, lip_thickness], center = true);
            
            // Left Post
            translate([(panel_length/2) - post_spacing, 0, lip_thickness]) 
                cylinder(h = post_bezel_height, r1 = post_diameter/2 + post_bezel_height, r2 = post_diameter/2, center = false);
            translate([(panel_length/2) - post_spacing, 0, lip_thickness])
                cylinder(h = post_depth, r = 1.5, center = false);
            
            // Right Post
            translate([(panel_length/2) + post_spacing, 0, lip_thickness]) 
                cylinder(h = post_bezel_height, r1 = post_diameter/2 + post_bezel_height, r2 = post_diameter/2, center = false);
            translate([(panel_length/2) + post_spacing, 0, lip_thickness])
                cylinder(h = post_depth, r = 1.5, center = false);
        }

}

//single_model();

split_model();