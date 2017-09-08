
// variables
int ballXpos;
int ballYpos;
int ballSpeed;
int ballXspeed;
int ballYspeed;
int ballSpeedRange;
int ballSize;
int stageWidth;
int stageHeight;
int racketSpeed;
boolean isKeyPressed;
boolean moveRacketOneUp;
boolean moveRacketTwoUp;
boolean moveRacketOneDown;
boolean moveRacketTwoDown;
Racket racketLeft;
Racket racketRight;
// setup
void setup() {
   size(800, 600);
   stageWidth = 800;
   stageHeight = 600;
   isKeyPressed = false;
   racketLeft = new Racket(1, 50, stageHeight/2);
   racketRight = new Racket(2, stageWidth-50, stageHeight/2); 
   ballXpos = 800/2;
   ballYpos = 600/2;
   ballSpeed = 5;
   ballXspeed = int(random(2, ballSpeed));
   ballYspeed = int(random(ballSpeed, ballSpeed + 2));
   ballSpeedRange= 10;
   ballSize = 30;
   racketSpeed = 2;
}

// loop
void draw() {

  background(0);
  ellipse(ballXpos, ballYpos, ballSize, ballSize);
  //ballXpos = ballXpos + ballXspeed; //int(random(ballSpeed, ballSpeedRange));
  //ballYpos = int(random(ballSpeed, ballSpeedRange));
  //println("ballXpos = " + (ballXpos));
  ballXpos += ballXspeed;
  ballYpos += ballYspeed;
  
  int[] racketOneHitbox = racketLeft.getHitBox();
  if (ballXpos < racketOneHitbox[0] && ballYpos > racketOneHitbox[1] && ballYpos < (racketOneHitbox[1]+racketOneHitbox[2])) {
    ballXspeed = -ballXspeed;
    ballYspeed = -ballYspeed;
  }
  
  if (ballXpos <= 0 || ballXpos >= 800) {
     ballXspeed = -ballXspeed;
  }
  if (ballYpos <= 0 || ballYpos >= 600) {
     ballYspeed = -ballYspeed;
  }
  
  if (moveRacketOneUp) {
     racketLeft.moveRacket(racketSpeed);
  } 
  if (moveRacketOneDown) {
     racketLeft.moveRacket(-racketSpeed);
  }
  
  if (moveRacketTwoUp) {
    racketRight.moveRacket(racketSpeed);
  } 
  if (moveRacketTwoDown) {
    racketRight.moveRacket(-racketSpeed);
  }
  
  racketLeft.drawRacket();
  racketRight.drawRacket();
  
  //println("ballXpos = " + (ballXpos));
  //println(racketLeft.getHitBox()[2]);
}

void keyHandler(int keypressed, int keyreleased) {
  switch (keypressed) {
    //player 1
    case 83:
      // key = s
      moveRacketOneUp = true;
      break;
    case 87:
      //key = w
      moveRacketOneDown = true;
      break;
      
    //player 2
    case 76:
      // key = s
      moveRacketTwoUp = true;
      break;
    case 80:
      //key = w
      moveRacketTwoDown = true;
      break;
  }
  
   switch (keyreleased) {
    //player 1
    case 83:
      // up - key = s
      moveRacketOneUp = false;
      break;
    case 87:
      // down - key = w
      moveRacketOneDown = false;
      break;
      
    //player 2
    case 76:
      // up - key = p
      moveRacketTwoUp = false;
      break;
    case 80:
      // down - key = l
      moveRacketTwoDown = false;
      break;
  }
}

void keyPressed(KeyEvent event) {
    keyHandler(event.getKeyCode(), 0);
}

void keyReleased(KeyEvent event) {
   keyHandler(0, event.getKeyCode()); 
}