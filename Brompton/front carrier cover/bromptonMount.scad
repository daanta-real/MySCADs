//The brompton luggage mount is approx 11 thick, 70 tall, 50 wide at the top and 68 wide at the bottom. The corners are rounded

tolerance=1;
mblockThickness=11 + tolerance;
mblockTopWidth=50 + tolerance;
mblockBottomWidth=68 + tolerance;
mblockHeight=70;
shellThickness=4;
mblock=[[mblockHeight/2,-(mblockBottomWidth/2)]
			,[-(mblockHeight/2 ),-(mblockTopWidth/2 )]
			,[-(mblockHeight/2),mblockTopWidth/2 ]
			,[mblockHeight/2,mblockBottomWidth/2 ]];
overlap=8;
mblockCut=[[mblockHeight/2,-(mblockBottomWidth/2 - overlap)]
			,[-(mblockHeight/2 ),-(mblockTopWidth/2 - overlap )]
			,[-(mblockHeight/2 ),mblockTopWidth/2 - overlap ]
			,[mblockHeight/2,mblockBottomWidth/2 - overlap ]];
claspDepth=2.5;claspWidth=12;claspHeight=6;

screwHole=2;


module trapezoid( longSide, shortSide, height, length){
	translate([0,0,-length/2]) linear_extrude(length) polygon([[-height/2,-shortSide/2]
		,[-height/2,shortSide/2]
		,[height/2,longSide/2]
		,[height/2,-longSide/2]]);
	}

module extrudePoly( polyPoints, thickness = 2) {
	linear_extrude(height = thickness , center = true) {
		polygon(polyPoints);
		}
	
}


difference(){

	minkowski(){  //rounded outer shell.  This will render slowly at high $fn 
		extrudePoly(mblock, mblockThickness);
 		sphere(r=shellThickness, $fn=20);
		}
	//trim off exess created by minkowski sum
	translate([mblockHeight/2 +5,0,0]) cube(size=[10,200,60], center = true);
	extrudePoly(mblock, mblockThickness); //cut a slot for the mounting plate
	//cut a passage for the mounting block arm
	translate([0,0,(mblockThickness+shellThickness)/2]) extrudePoly(mblockCut,shellThickness);
	//screw holes
	for (i=[[-15,0,-mblockThickness/2-shellThickness/2],[10,0,-mblockThickness/2-shellThickness/2]]){
		translate(i) cylinder(h=shellThickness, r1=screwHole, r2=2*screwHole, center=true);
		}	
	//add a depression to engage the clasp
	translate([54 - mblockHeight/2 , 0, - (mblockThickness/2 + claspDepth/2) ]) cube([claspHeight,claspWidth,claspDepth], center=true);	
	
}
//Work in progress
// Add a rail to attach ornamental objects
/*
railLength=60; railDepth=5; railBaseWidth=15; railFlare=4; faceThickness=1; 
translate([0,0, -(mblockThickness/2 + shellThickness + railDepth/2)])
	rotate(a=[0,-90,0]) 
	{
		intersection()
			{		
			difference()
				{
				trapezoid(railBaseWidth, railBaseWidth + railFlare, railDepth, railLength);
				translate([0,0,-railLength/2]) cube([railDepth,5,railLength], center=true);
				}
			rotate([0,0,0]) translate([railDepth/2,0,0]) cylinder(r1=2*(railBaseWidth+railFlare), r2=0, h=railLength, center=true, $fn=40);
		
			}
	translate([0,0,-railLength/4]) cube([railDepth/2.5,3,railLength/2], center=true);

	}

*/