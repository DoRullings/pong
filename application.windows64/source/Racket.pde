
class Racket {
  int side;
  int rectWidth;
  int rectHeight;
  int rectXpos;
  int rectYpos;
  int oldRectYpos;
  
  // player 1 = left
  /// player 2 = right
   Racket(int side, int rectWidth, int rectHeight, int rectXpos, int rectYpos) {
     this.rectWidth = rectWidth;
     this.rectHeight = rectHeight;
     this.side = side;

     this.rectXpos = rectXpos;
     this.rectYpos = rectYpos; 
     oldRectYpos = rectYpos;
     /*if (side > 1) { 
       System.out.println(side);
     } else if (side <= 1) {
       System.out.println(side);
     } else { 
       System.out.println("Invalid side");
     }*/   
   }
   
   void drawRacket() {
     rect(rectXpos, rectYpos, rectWidth, rectHeight);
   }
   
   int[] getRacketMoving() {
     int[] isMovInDir = new int[2]; // isMovInDir[isMoving, up/down] 0 = isMoving, 1 = !isMoving, 0 = up, 1 = down.
     
     if (rectYpos < oldRectYpos) { // up
       isMovInDir[0] = 1; // isMoving
       isMovInDir[1] = 0; // up
     } else if (rectYpos > oldRectYpos) {
       isMovInDir[0] = 1; // isMoving
       isMovInDir[1] = 1; // down
     } else if (rectYpos == oldRectYpos) {
       isMovInDir[0] = 0; // !isMoving
       isMovInDir[1] = 0; // ---      
     }
     oldRectYpos = rectYpos;
     //println(rectYpos + " " + oldRectYpos);
     return isMovInDir;
   }
   
   
   
   void moveRacket(int yPos) {
      rectYpos += yPos;
   }
   
   int getRacketPos() {
     return rectYpos;
   }
   
   void setRacketPos(int racketPos) {
       rectYpos = racketPos;
       drawRacket();
   }
   
   int[] getHitBox() {
     int[] hitBox = new int[4];
     hitBox[0] = rectXpos;
     hitBox[1] = rectYpos;
     hitBox[2] = rectHeight;
     hitBox[3] = rectWidth;
     return hitBox;
   }
}