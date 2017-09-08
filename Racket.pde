
class Racket {
  int side;
  int rectWidth;
  int rectHeight;
  int rectXpos;
  int rectYpos;
  
  // player 1 = left
  /// player 2 = right
   Racket(int side, int rectXpos, int rectYpos) {
     this.side = side;
     rectWidth = 20;
     rectHeight = 100;
     this.rectXpos = rectXpos;
     this.rectYpos = rectYpos; 
     if (side > 1) { 
       System.out.println(side);
     } else if (side <= 1) {
       System.out.println(side);
     } else { 
       System.out.println("Invalid side");
     }
   }
   
   void drawRacket() {
     rect(rectXpos, rectYpos, rectWidth, rectHeight);
   }
   
   void moveRacket(int yPos) {
      rectYpos += yPos;
   }
   
   int getRacketPos() {
     return rectYpos;
   }
   
   int[] getHitBox() {
     int[] hitBox = new int[4];
     hitBox[0] = rectYpos;
     hitBox[1] = rectXpos;
     hitBox[2] = rectHeight;
     hitBox[3] = rectWidth;
     return hitBox;
   }
}