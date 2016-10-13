



gwidth = 17;
width = 20;
length = 22;
depth = 102;

l2 = 16;
w2 = 24;
d2 = 26;
d3 = 4;
wall = 2.4;

corner = 22;
batt =  19;
lid = 5;

sw = 7;
sl = 20;

hole = 2.8;
hs = 9;

//loop
ld = 20;
lw =  22; //width; //20;
lc = 7;

fn = 50;


//power switch
pd = 19;
ptd = 17;

pcs = 2;
pl = 32+pcs;
pa = 15;


  //[ 22.51, 8.06, 23.74 ]  
 half(false);

// translate([10,0, 0]) 
//rotate([0, 90, 0]) 
//half(true);



module half(top){
    intersection(){
    difference(){
        
 
         base(false);
	  inBase();
         cuts();
    }
    
		     if(top){
			   translate([-lid,length*2,0])    lidCut();
			// translate([width-lid,length,30.2]) c(width, length*6, depth+d2+10);
		     } else {
			    //    translate([0,-32,0])  rotate([-pa,0,0])   c(width*2, 100,200);
			     
			  translate([-lid,length*2,0]) union(){
			 c(width, length*6, depth+d2+10);
	//			  difference(){
	//				   translate([0, -50, 0]) c(100,  200, 200);
	//					lidCut();
	//			  }
	//			   translate([0, -50, 0]) c(100,  100, 30);
			// translate([lid,length+l2-3,depth-18]) c(width, l2, 50);
			  }
		     }
    
    }
}
 
module inBase(){
	 sx = (width-wall*2)/width;
        sy = (length-wall*2)/length;
        sz = (depth-wall*2)/depth;
	
	    difference(){
		    translate([0,wall/2,wall*1.4]) scale([sx, sy, sz]) base(true);
		    translate([-w2/2, 0, 0])  holeSup();
		     stSupport();
			     
			     //============trimming weak points=====
			     //lower left --> upper right
			     union(){
			   //   translate([-w2/2, -16, 14]) rotate([0,90,0])  cy(10, 40);
			     
			      //  translate([0, 4, depth-7.7])  c(40, 10, 17); //th lower
			     }
			     //============================
            

			  //board cut pad
			   if(!top){
				   translate([-w2/2-1, 5, -10]) 
					rotate([-17,0,0]) union(){
					  translate([0,0, -1]) c(100, 100, 84);
				   }
			      }
            }
    }
module cuts(){
	
		 //th cut
		  translate([0,22,depth+14])  rotate([0,90,0]) cyc(36, sw, 4);
	     
		  //power button cut
		     translate([0,  pl/2+pcs-wall-2,  10])  rotate([90-7,0,0]) union()
		     {	
			     translate([0, 0, pl-pcs])   cy(pd, pcs*4);
				translate([0, 0, 0])   cyc(ptd, pl+pcs, 5);
		     }
	     
	     //wire channel
	         translate([2.6, 12, 12])   cy(7,  24);
	       
        
		holes();
		
           
        
		 if(!top){
		     translate([-w2/2-4,14, 57])  rotate([-17,0,0])  boardCuts();
		 }
		 
}

module lidCut(){
	 hull(){
					translate([14 ,-46, 50 ])   rotate([0,90,0]) cy(30, 10);
					  translate([14 ,-22, 117 ])   rotate([0,90,0]) cy(20, 10);
				
				  }
			  }


function getLcutPos() =  [-w2,  -ld*.55, ld/3];


module loopCut(){
	   //loop cut
        translate(getLcutPos() ) lc();
}

module lc(){
	 rotate([0, 90,0])  hull(){
	          translate([0,0,0])   cy(6, w2*2); 
		      translate([2,10,0])   cy(3, w2*2); 
	}
}


module boardCuts(){
   
    union(){
      
    //board
	    
   translate([16,2.7-6.5,-36.5]) union(){
   
         // switch
            translate([5,-10,40]) c(3.4, 15, 7);
       
       //usb board
         translate([-1,-5, 6]) {
              translate([-3.5,-5, 6])  c(3.4, 12, 9);     //micro usb
            translate([5,7, 0]) rcc(20, 26, 26, 4, 6);
         }
    bbd = 18;
    
     translate([5,4,29]) rc(bbd, 30, 24, 4);
      translate([9,0,0])   rc(bbd, 22, 53, 4);
    }
    
    bdc = w2;
    
    
    union(){
    
    translate([0,1.26 + 7/2,7/2]) rotate([0,90,0]) cy(7, bdc);
     translate([0,2.26 + 3.6/2,7/2 + 7]) rotate([0,90,0]) cy(3.6, bdc);
    }
     mirror([0,1,0])  union(){
    
    translate([0,1.26 + 7/2,7/2]) rotate([0,90,0]) cy(7, bdc);
    translate([2+wall,2.26 + 3.6/2,7/2 + 7]) rotate([0,90,0]) cy(3.6, bdc/2);		//led not throught!
    }
    
    }
}

//++++++++++++++++++ Steering pot hole support +++++++++++++++++++//
   //--------------------------------------------------------// 
 
    hs = 7;
    hh = 5;
    sh = 3;
    hd = 24;   
module stSupport(){
    
  
    
    aa = -150;
      translate([-w2/2+7,39,110]) mirror([0, 10, 0]) rotate([0,aa,-90]) {
            sthole();
            translate([0,0,hd])  sthole();
          
          //st stop
           translate([11,7,6]) rotate([90,0,0])  cylinder(d2 = 11, d1=5, h=14, $fn=7,center=false);
      }
                     
}

module sthole(){
    difference(){
             union() {
                   translate([0,0,0]) rotate([90,0,0])  cylinder(d2 = hs*1.5, d1=hs, h=hh, $fn=7,center=false);
                   translate([0,1,0]) rotate([90,0,0]) cy(4.4, hh,fn);
                    }
                  translate([0,1.1,0]) rotate([90,0,0]) cy(sh, hh+1, fn);
             }
}

   //--------------------------------------------------------//
   //--------------------------------------------------------//


 module gripCuts(){
       for(i=[1:3]){
            dz = depth/5+2;
               translate([-width,length + l2/2 + i*9+4, dz/2 + dz*1.3*i] )  rsc(dz+i*2, width*2, 9);//  cy(dz+i*2, width*2);
        }
    }
  
    
    module lensPad(){
         translate([0,length*1.1 + l2,depth + 16]) rotate([110,0,0]) cy(width, 10);
    }
    
    module lensCut(){
         translate([0,length*1.1 + l2 + 1,depth + 16]) rotate([110,0,0]) {
              translate([0,0,3])  cy(20.6, 10);
              translate([0,0,0])  cy(18.6, 20);
             
         }
    }
    
    
  module base(in){
      difference(){
        union(){
                hull(){
			  
                     translate([-gwidth/2+wall,  ld/2, ld/2]) rotate([0,90, 0]) cyc(ld, gwidth, 5);
			    translate([-lw/2+wall, -ld/2, ld/2]) rotate([0,90, 0]) cyc(ld, lw, 5);
                    
			 
			//	translate([0,length/2 + l2,depth-4]) rc(width, length+l2, 6, corner);
                   
                
                
                //top
          translate([0,l2/2,0])   {
                 
                if(in){
            translate([0, 0,0])   
                hull(){
			           translate([-width/2+1, l2/2, depth-ld/2]) rotate([0,90, 0]) cyc(ld, width-1, 5);
			  
                    translate([0, 10,0])   intersection(){
                    translate([0,length/2 + l2,depth]) sp(length+l2);
                    union(){
                    translate([0,length*2,depth]) rotate([90,0,0]) rc(width, length+l2, length*4, width-1);
                      translate([0,length*2,depth+l2]) rotate([90,0,0]) rc(w2, l2, length*4, width-1);
                      }
                }
                
                   //  lensPad();
                }
            } else{
                 translate([0,0,0]) 
              hull(){
			//th bottom curve
			    translate([-width/2+1, l2/2, depth-ld/2]) rotate([0,90, 0]) cyc(ld, width-1, 5);
			
                  intersection(){
                    translate([0,length/2 + l2,depth]) sp(length+l2);
                      union(){
                    translate([0,length*2,depth]) rotate([90,0,0]) rc(width, length+l2, length*4, width-1);
                      translate([0,length*2,depth+l2]) rotate([90,0,0]) rc(w2, l2, length*4, width-1);
                      }
                    }
                    
                     // lensPad();
                }
            }
        }       //top
    }
                    
            }      
            
//            if(in){
//            translate([0,wall+2, 0])  gripCuts();
//            } else{
//                 translate([0,0,0])  gripCuts();
//            }
        }
    }

//       translate([0,(length-batt)/2-wall,wall*2]) rotate([-5.5,0,0])  cy(batt, 70);
//    }
//    
    w = width;
    d = depth;
    l = length + l2/2;
    
    function getHolePos()
    = [
 //   [0, l+15, d+4],    //top right
 //    [0, 10, 107.],       //top left
   //  [0, 37, 62]       //bottom right
   //  [0, -(l/2-hs), hs/2+8]   //bottom left
    ];
    
    

module holes(){
    
        for(i=getHolePos()){
            translate(i) rotate([0,90,0]) {
            cylinder(d=hole, h=width*2, $fn=fn);
            //counter sink
              translate([0,0,width-14])  cylinder(d=6.2, h=width, $fn=fn);
        }
        }
    }
    
    
    module holeSup(){
        for(i=getHolePos()){
            translate(i) rotate([0,90,0]) cylinder(d1=hs+3, d2=hs, h=w2, $fn=fn);
        }
    }
    
function getBaseCorners(w, l, d, c)
    = [
    [w/2, 0, d],
    [-w/2, 0, d],
    [w/2, 0, c/2],
    [-w/2, 0, c/2],
    [w/2 + w2, 0, c/2 + d],
    ];
    

module rsc(d, w, c){
		translate([w/2,0, 0])  union(){
			hull(){
			translate([0,0, 0])  rotate([0,90,0]) cy(d, 1);
		translate([-w/2,-c, 0])  rotate([0,90,0])  cy(d, 1);
			}
			hull(){
				
			translate([0,0, 0])  rotate([0,90,0]) cy(d, 1);
		translate([w/2,-c, 0])  rotate([0,90,0])  cy(d, 1);
			}
	}
}


module cys(d, w, h){
    
    intersection(){
            translate([0,(d-w)/2,0]) cy(d, h);
            translate([0,0,0]) c(w, w, h);
    }
}

module rs(d, l, h){
    hull(){
         translate([0,l/2-d/2,0]) cy(d, h);
            translate([0,-l/2+d/2,0]) cy(d, h);
    }
    
}

module sp(d){  
    translate([0,0,0])    sphere(d=d, $fn=fn, center=false);
}

module cyc(d, h, c){
      translate([0,0,0])  minkowski(){
                sphere(d=c, $fn=fn, center=true);
                   translate([0,0,0]) cy(d-c, h-c);
        }
    
}

module cy(d, h){  
    translate([0,0,0])    cylinder(d=d, h=h, $fn=fn, center=false);
}
    
module c(w, l, d){
    translate([0,0,d/2]) cube([w, l, d], center=true);
}


module rc(w, l, d, c){
    hull(){
            translate([w/2-c/2,l/2-c/2,0]) cy(c, d);
            translate([w/2-c/2,-l/2+c/2,0]) cy(c, d);
            translate([-(w/2-c/2),l/2-c/2,0]) cy(c, d);
            translate([-(w/2-c/2),-l/2+c/2,0]) cy(c, d);
    }
    
}

module rcc(w, h, d, c, s){
          translate([0,0,d/2])  minkowski(){
                sphere(d=s, $fn=fn, center=true);
                   translate([0,0,-(d-s)/2])  rc(w-s, h-s, d-s, c);
        }
    
}

