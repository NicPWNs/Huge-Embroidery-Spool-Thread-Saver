$fn = 120;

// =============================
// Dimensions for the upper hollow cylinder
// =============================
outer_d = 28;            // enlarged +1mm
wall    = 3;
inner_d = outer_d - 2*wall;   // = 19.5 mm
inner_h = 30;

// =============================
// Chamfer parameters
// =============================
chamfer_depth = 2;      
chamfer_extra = 2;      

// =============================
// FIRST SLIT parameters
// =============================
slit_angle      = 45;    
slit_radius     = 27;    
slit_length     = 12;    
slit_width      = 1;     
slit_tilt       = 80;    

// =============================
// SECOND SLIT parameters
// =============================
slit2_angle_offset = 0;
slit2_radius       = 25;
slit2_length       = 15;
slit2_width        = 1.5;
slit2_tilt         = 290;


// =============================
// BASE DISK WITH HOLE, CHAMFER, AND 3 SLIT PAIRS
// =============================
difference() {

    // Base disk (larger by 1mm)
    cylinder(d = 62, h = 2);

    // Straight portion of the center hole
    cylinder(d = inner_d, h = 2 + 0.2);

    // Chamfer
    cylinder(
        h  = chamfer_depth,
        d1 = inner_d + chamfer_extra,
        d2 = inner_d
    );

    // ---- 3 PAIRS OF SLITS ----
    for (i = [0:2]) {

        // FIRST SLIT
        rotate([0,0, slit_angle + 120*i]) {
            translate([slit_radius, 0, 0]) {
                rotate([0,0, slit_tilt]) {
                    polyhedron(
                        points=[
                            [0,0,0],
                            [slit_length, slit_width/2, 0],
                            [slit_length,-slit_width/2,0],

                            [0,0,2],
                            [slit_length, slit_width/2, 2],
                            [slit_length,-slit_width/2,2]
                        ],
                        faces=[
                            [0,1,2],
                            [3,4,5],
                            [0,3,4,1],
                            [1,4,5,2],
                            [2,5,3,0]
                        ]
                    );
                }
            }
        }

        // SECOND SLIT
        rotate([0,0, slit_angle + slit2_angle_offset + 120*i]) {
            translate([slit2_radius, 0, 0]) {
                rotate([0,0, slit2_tilt]) {
                    polyhedron(
                        points=[
                            [0,0,0],
                            [slit2_length, slit2_width/2, 0],
                            [slit2_length,-slit2_width/2,0],

                            [0,0,2],
                            [slit2_length, slit2_width/2, 2],
                            [slit2_length,-slit2_width/2,2]
                        ],
                        faces=[
                            [0,1,2],
                            [3,4,5],
                            [0,3,4,1],
                            [1,4,5,2],
                            [2,5,3,0]
                        ]
                    );
                }
            }
        }

    } // end loop
}


// =============================
// UPPER HOLLOW CYLINDER
// =============================
translate([0,0,2]) {
    difference() {
        cylinder(d = outer_d, h = inner_h);
        cylinder(d = inner_d, h = inner_h + 0.2);
    }
}




