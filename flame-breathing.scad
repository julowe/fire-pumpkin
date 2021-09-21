//flamebreathing
//justin lowe 20210722

//generic holder for thing to make flame

//sparker or tea light?
//tea light for ease of other people's use as default, sparker as option later
//next time, just move the cylinder over and don't center all the cubes...

draftingFNs = 36;
renderFNs = 180;
$fn = draftingFNs;

//TODO: 
// X-test if we can just using a servo to depress head of hair spary can. Works!
// X-wire channel - make full height (or most)
// X-fix servo hole dimensions
// -arduino mount
// -holes in base for mounting... nails?

//To Check with test print:
// X-servo mounting hole locations - good so far, maybe more padding horizontally for serov holder tho
// X-servo moutning hole dimensions
// X-servo wires channel
// !!!! -servo arm vs nozzle - touchign but also good force and activation time (change angle moved or vertical/horizontal position of servoholder/arm)
// X-lip to hold can
// -easy enough to insert can into holder without deforming/breaking backplane bottom top etc

/*Description of 3d model
-xy plane will be the top of metal part of can. so nozzle on positive side. nozzle centered on z axis.
-half ring with lip to hold can in place on top.
-servo cutout, find appropriate place relative to nozzle
*/

////what about bottom of base? 
//1. extend spine down back of can and have lip to hold can in place?
//2. extend spine down and just have nail into pumpkin, no material under can?
//3. just nail servo holder to side wall of pumpkin? (prob won't work as then it limits placement of contraption to a wall of pumpkin, may want closer to mouth)

//// properties of physical objects
// hairspray can, specifically tresemme 1.5oz travel size
canTopOuterDiameter = 32.5; //actual
canTopInnerDiameter = 24.6; //actual
canBodyDiameter = 35; //actual
canHeight = 99; //98; //actual
canTopLipInnerDepth = 5; //5.5; //actual
canTopLipOuterDepth = 4; //3.75; //actual
nozzleDiameter = 15; //room for nozzle to rotate forward & down when pressed //13.5; //actual, about 1mm larger than metal can part below it
nozzleHeight = 15;  //actual, height of nozzle plus a tiny bit of the stem above can top

// servo
servoWidth = 23.5; //22.7; //actual
servoHeight = 12.6; //actual 12.6 at rear by wires, 11.9 by servo arm...
servoDepthBehindEars = 15.5; //actual //IDEA: how much can I shorten this, before servo housing starts to torque when arm depresses? Or is it worth it to have wide base here, so leave this?
servoDepthEarsToWires = 9.75; //actual
servoWiresWidth = 2.5;  //1.75; //actual //IDEA - could angle this channel so there is more material for screw (holding servo in) to grip at forward edge, but still not crimping wires at back edge
servoWiresHeight = 4; //actual
servoDepthTopToBottomOfEars = 7; //actual
servoCenterArmToBottomEars = 15.5; //actual, ie how far to the side to place servo to line up servo arm with nozzle
servoArmLength = 16;
servoMountingScrewInnerShaftDiameter = 2; //1.6; //actual-ish wasn't too bad but sides did buldge some
servoMountingScrewInnerShaftLength = 7.5; //actual-ish
servoMountingHoleHorizontalInset = 2.5; //actual


//// properties of holder/model
platformCanTopHeight = 3;
platformCanTopHorizontalPadding = 2; //how far for retention block to go past can diameter
platformCanBottomHeight = 5;
holderBackplaneDepth = 5;
servoHolderVerticalPadding = 4;
servoHolderHorizontalPadding = 5;
servoArmHorizontalSetback = nozzleDiameter/2; //half nozzle diameter?
servoHorizontalSetback = 8; //measured rough placement, y direction movement
servoHorizontalShift = 15; //x direction movement
servoVerticalAdjustment = 5; //rough measurement of how far above top of can should the bottom of the servo housing be, in order to hit the nozzle well
platformCanBottomMountingHoleDiameter = 3.5; //meh?

difference(){
    union(){
        //holds on to top of can around nozzle and inside lip of can
        difference(){
            //portion to go into/around lip of can
            translate([(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2-(servoHorizontalShift+servoDepthBehindEars)/2,(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2,-canTopLipInnerDepth+platformCanTopHeight/2]){
        
                cube([(servoHorizontalShift+servoDepthBehindEars)+canTopOuterDiameter/2+platformCanTopHorizontalPadding,canTopOuterDiameter/2+platformCanTopHorizontalPadding,canTopLipInnerDepth*2+platformCanTopHeight],true);
            }
            
            //remove can area
            makeCanTresemme(); 
        } //end difference of cube to can to hold on to top of can
        
        //backplane of holder
        translate([(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2-(servoHorizontalShift+servoDepthBehindEars)/2,holderBackplaneDepth/2+(canTopOuterDiameter+platformCanTopHorizontalPadding*2)/2,platformCanTopHeight/2-(canHeight+platformCanBottomHeight)/2]){
            cube([(servoHorizontalShift+servoDepthBehindEars)+canTopOuterDiameter/2+platformCanTopHorizontalPadding,holderBackplaneDepth,platformCanTopHeight+canHeight+platformCanBottomHeight],true);
        }
        
        //bottom of holder
        translate([(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2-(servoHorizontalShift+servoDepthBehindEars)/2,0,-canHeight-platformCanBottomHeight/2]){
            cube([(servoHorizontalShift+servoDepthBehindEars)+canTopOuterDiameter/2+platformCanTopHorizontalPadding,canTopOuterDiameter+platformCanTopHorizontalPadding*2,platformCanBottomHeight],true);
        }
        
        //servo holder
        difference(){
            //cutout for servo body
            translate([-servoHorizontalShift-(servoDepthBehindEars)/2,(servoWidth/2)+servoHorizontalSetback,(servoHeight)/2+platformCanTopHeight+servoVerticalAdjustment]){
                difference(){
                    translate([0,0,(servoHolderVerticalPadding-servoVerticalAdjustment)/2]){
                    cube([servoDepthBehindEars,servoWidth+servoHolderHorizontalPadding*2,servoHeight+servoHolderVerticalPadding+servoVerticalAdjustment],true);
                    }
                    //main cutout for servo body
                    cube([servoDepthBehindEars,servoWidth,servoHeight],true);                 
                }//end difference for cutout for servo body
            }
            
            //forward side servo mounting hole
            translate([-servoHorizontalShift,servoHorizontalSetback-servoMountingHoleHorizontalInset,(servoHeight)/2+platformCanTopHeight+servoVerticalAdjustment]){
                rotate([0,-90,0]){
                    cylinder(servoMountingScrewInnerShaftLength, servoMountingScrewInnerShaftDiameter/2, servoMountingScrewInnerShaftDiameter/2);
                }
            }
            //rear side servo mounting hole
            translate([-servoHorizontalShift,servoHorizontalSetback+servoWidth+servoMountingHoleHorizontalInset,(servoHeight)/2+platformCanTopHeight+servoVerticalAdjustment]){
                rotate([0,-90,0]){
                    cylinder(servoMountingScrewInnerShaftLength, servoMountingScrewInnerShaftDiameter/2, servoMountingScrewInnerShaftDiameter/2);
                }
            }
            
            //cutout for wires for servo body
            translate([-servoHorizontalShift-servoDepthBehindEars,servoHorizontalSetback-servoWiresWidth,(servoHeight)/2+platformCanTopHeight+servoVerticalAdjustment-servoWiresHeight/2]){
                cube([servoDepthBehindEars,servoWiresWidth*1.01,servoWiresHeight]);
            }
        } //end differnce for servo mounting holes
    }//end union of all

    //this cuts side of the model off so slightly fewer supports are needed when printing
    modelCutoffWidth = 6;
    translate([canTopOuterDiameter/2+platformCanTopHorizontalPadding-modelCutoffWidth,-(canTopOuterDiameter+platformCanTopHorizontalPadding*2)/2,-(canHeight+platformCanBottomHeight)]){
        cube([modelCutoffWidth,canTopOuterDiameter+platformCanTopHorizontalPadding*2+holderBackplaneDepth,platformCanTopHeight+canHeight+platformCanBottomHeight]);
    }
    
    //make mounting hole in bottom of plate
    translate([canTopOuterDiameter/2+platformCanTopHorizontalPadding-modelCutoffWidth-platformCanBottomMountingHoleDiameter,-(canTopOuterDiameter-platformCanBottomMountingHoleDiameter)/2,-(canHeight+platformCanBottomHeight)]){
        cylinder(platformCanBottomHeight, platformCanBottomMountingHoleDiameter/2, platformCanBottomMountingHoleDiameter/2);
    }
    
        translate([-(servoHorizontalShift+servoDepthBehindEars)+platformCanBottomMountingHoleDiameter,-(canTopOuterDiameter-platformCanBottomMountingHoleDiameter)/2,-(canHeight+platformCanBottomHeight)]){
        cylinder(platformCanBottomHeight, platformCanBottomMountingHoleDiameter/2, platformCanBottomMountingHoleDiameter/2);
    }
        
        translate([-(servoHorizontalShift+servoDepthBehindEars)+platformCanBottomMountingHoleDiameter,(canTopOuterDiameter-platformCanBottomMountingHoleDiameter)/2,-(canHeight+platformCanBottomHeight)]){
        cylinder(platformCanBottomHeight, platformCanBottomMountingHoleDiameter/2, platformCanBottomMountingHoleDiameter/2);
    }
        
        translate([canTopOuterDiameter/2+platformCanTopHorizontalPadding-modelCutoffWidth-platformCanBottomMountingHoleDiameter,(canTopOuterDiameter-platformCanBottomMountingHoleDiameter)/2,-(canHeight+platformCanBottomHeight)]){
        cylinder(platformCanBottomHeight, platformCanBottomMountingHoleDiameter/2, platformCanBottomMountingHoleDiameter/2);
    }
}
    


//   //make mounting hole in bottom of plate
//    translate([canTopOuterDiameter/2+platformCanTopHorizontalPadding-6-platformCanBottomMountingHoleDiameter,0,-(canHeight+platformCanBottomHeight)]){
//        cylinder(platformCanBottomHeight, platformCanBottomMountingHoleDiameter/2, platformCanBottomMountingHoleDiameter/2);
//    }



//        //bottom of holder
//        translate([(canTopOuterDiameter/2+platformCanTopHorizontalPadding)/2-(servoHorizontalShift+servoDepthBehindEars)/2,0,-canHeight-platformCanBottomHeight/2]){
//            cube([(servoHorizontalShift+servoDepthBehindEars)+canTopOuterDiameter/2+platformCanTopHorizontalPadding,canTopOuterDiameter+platformCanTopHorizontalPadding*2,platformCanBottomHeight],true);
//        }
//




//Module to make shape of can of tresemme hairspray, 1.5oz travel size
module makeCanTresemme() {
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
} //end makeCanTresemme()
//whitespace holder


/*code to save for now?
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
*/