//flamebreathing
//justin lowe 20210722

//generic holder for thing to make flame

//sparker or tea light?
//tea light for ease of other people's use as default, sparker as option later

//TODO: test if we can just use a servo to depress head of hair spary can. Works!

//base
// print with back flat on build plate, so box to hold nema stepper has open back and closed front a bit off build plate. or do we just need the 4 screw holes for moutning nema motor and no lip to further hold in place? print with base plate in plane with z-y axis printing up. chamfer bottom plate to hairspray support (which is flat on build plate). make holes to nail thiw whole thing into the pumpkin for support. x and z axis nails.

//can holder w/ servo

//xy plane will be the top of metal part of can. so nozzle on positive side. nozzle centered on z axis.
//half ring with lip to hold can in place on top.
//servo cutout, find appropriate place relative to nozzle

//what about bottom of base? 
//1. extend spine down back of can and have lip to hold can in place?
//2. extend spine down and just have nail into pumpkin, no material under can?
//3. just nail servo holder to side wall of pumpkin? (prob won't work as then it limits placement of contraption to a wall of pumpkin, may want closer to mouth)

//// properties of physical objects
// hairspray can
canTopOuterDiameter = 32.5; //actual
canTopInnerDiameter = 24.6; //actual
canBodyDiameter = 35; //actual
canHeight = 98; //actual
canTopLipInnerDepth = 5; //5.5; //actual
canTopLipOuterDepth = 4; //3.75; //actual
nozzleDiameter = 13.5; //actual, about 1mm larger than metal can part below it
nozzleHeight = 15;  //actual, height of nozzle plus a tiny bit of the stem above can top
// servo
servoWidth = 22.7; //actual
servoHeight = 12.3; //actual
servoDepthBehindEars = 15.5; //actual
servoDepthEarsToWires = 10; //actual
servoDepthTopToBottomOfEars = 7; //actual
servoCenterArmToBottomEars = 15.5; //actual, ie how far to the side to place servo to line up servo arm with nozzle
servoArmLength = 16;



//properties of holder
platformCanTopHeight = 3;
platformCanTopHorizontalPadding = 2; //how far for retention block to go past can diameter
platformCanBottomHeight = 5;
holderBackplaneDepth = 5;
servoHolderVerticalPadding = 4;
servoHolderHorizontalPadding = 4;
servoArmHorizontalSetback = nozzleDiameter/2; //half nozzle diameter?
servoHorizontalSetback = 8; //measured rough placement, y direction movement
servoHorizontalShift = 15; //x direction movement
servoVerticalAdjustment = 5; //rough measurement of how far above top of can should the bottom of the servo housing be, in order to hit the nozzle well

difference(){
    union(){
//holds on to top of can around nozzle and inside lip of can
difference(){
    //portion to go into/around lip of can
    translate([(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2-(servoHorizontalShift+servoDepthBehindEars)/2,(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2,-canTopLipInnerDepth+platformCanTopHeight/2]){

        cube([(servoHorizontalShift+servoDepthBehindEars)+canTopOuterDiameter/2+platformCanTopHorizontalPadding,canTopOuterDiameter/2+platformCanTopHorizontalPadding,canTopLipInnerDepth*2+platformCanTopHeight],true);
    }
    
    //remove can area
    makeCan(); 
}

//backplane of holder
translate([(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2-(servoHorizontalShift+servoDepthBehindEars)/2,holderBackplaneDepth/2+(canTopOuterDiameter+platformCanTopHorizontalPadding*2)/2,platformCanTopHeight/2-(canHeight+platformCanBottomHeight)/2]){
    cube([(servoHorizontalShift+servoDepthBehindEars)+canTopOuterDiameter/2+platformCanTopHorizontalPadding,holderBackplaneDepth,platformCanTopHeight+canHeight+platformCanBottomHeight],true);
}

//bottom of holder
translate([(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2-(servoHorizontalShift+servoDepthBehindEars)/2,0,-canHeight-platformCanBottomHeight/2]){
    cube([(servoHorizontalShift+servoDepthBehindEars)+canTopOuterDiameter/2+platformCanTopHorizontalPadding,canTopOuterDiameter+platformCanTopHorizontalPadding*2,platformCanBottomHeight],true);
}

//servo holder
translate([-servoHorizontalShift-(servoDepthBehindEars)/2,(servoWidth/2)+servoHorizontalSetback,(servoHeight)/2+platformCanTopHeight+servoVerticalAdjustment]){
    difference(){
        translate([0,0,(servoHolderVerticalPadding-servoVerticalAdjustment)/2]){
        cube([servoDepthBehindEars,servoWidth+servoHolderHorizontalPadding*2,servoHeight+servoHolderVerticalPadding+servoVerticalAdjustment],true);
        }
        cube([servoDepthBehindEars,servoWidth,servoHeight],true);
    }
}
}//end union of all

//this cuts side of the model off so slightly fewer supports are needed
modelCutoffWidth = 6;
translate([canTopOuterDiameter/2+platformCanTopHorizontalPadding-modelCutoffWidth,-(canTopOuterDiameter+platformCanTopHorizontalPadding*2)/2,-(canHeight+platformCanBottomHeight)]){
    cube([modelCutoffWidth,canTopOuterDiameter+platformCanTopHorizontalPadding*2+holderBackplaneDepth,platformCanTopHeight+canHeight+platformCanBottomHeight]);
}
}



    
    
//makeCan();

module makeCan() {
    difference(){
        union(){//can body
            //main can body
            translate([0,0,-canHeight]){
                cylinder(canHeight-canTopLipOuterDepth,canBodyDiameter/2,canBodyDiameter/2);
            }
            
            //upper part of can body
            translate([0,0,-canTopLipOuterDepth]){
                //ridge around edge of can
                cylinder(canTopLipOuterDepth,canTopOuterDiameter/2,canTopOuterDiameter/2);   
            }
        }//end union can body 
        
        translate([0,0,-canTopLipInnerDepth]){
            //inside wall of ring
            cylinder(canTopLipInnerDepth,canTopInnerDiameter/2,canTopInnerDiameter/2);
        }
    }//end difference of inner lip from can body
    
    translate([0,0,-canTopLipInnerDepth]){
        //interior stem
        cylinder(canTopLipInnerDepth+platformCanTopHeight,nozzleDiameter/2,nozzleDiameter/2);
    }
} //end makeCan()
//whitespace holder


//code to save for now?
////just can top
//difference(){
//    //portion to go into/around lip of can
//    translate([0,0,-canTopLipInnerDepth+platformCanTopHeight/2]){
//
//        cube([canTopOuterDiameter+platformCanTopHorizontalPadding*2,canTopOuterDiameter+platformCanTopHorizontalPadding*2,canTopLipInnerDepth*2+platformCanTopHeight],true);
//    }
//    
//    //remove can area
//    makeCan();
//    
//    //remove front half of rings
//    translate([0,-(canTopOuterDiameter+platformCanTopHorizontalPadding*2)/2,-canTopLipInnerDepth+platformCanTopHeight/2]){
//        cube([canTopOuterDiameter+platformCanTopHorizontalPadding*2,canTopOuterDiameter+platformCanTopHorizontalPadding*2,canTopLipInnerDepth*2+platformCanTopHeight],true);
//    }
//}
