

class ScoreBoard {
  
  int player;
  int posX;
  int posY;
  int textSize;
  int[] textColor;
  String text;
  PFont font;
  int score;
  PFont pfont;
   ScoreBoard() {
     pfont = createFont("PressStart2P.ttf", 32);
     drawText();
   }
   
   ScoreBoard(int player, int posX, int posY, int textSize, String text) {
     this.player = player;
     this.posX = posX;
     this.posY = posY;
     this.textSize = textSize;
     this.textColor = textColor;
     this.text = text;
     this.score = 0;
     pfont = createFont("PressStart2P.ttf", 32);
   }
   
   void addScore(){
     score += 1;
     drawText();
   }
   
   void drawText() {
     
     // The font "andalemo.ttf" must be located in the 
     // current sketch's "data" directory to load successfully
     
     //mono = createFont("Georgia", 32);
     textFont(pfont);
     textAlign(CENTER, CENTER);
     text(score, posX, posY);
   }
}