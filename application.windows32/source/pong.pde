
// variables
int ballXpos;
int ballYpos;
int ballSpeed;
int ballXspeed;
int ballYspeed;
int ballSpeedRange;
float ballSize;
int stageWidth;
int stageHeight;
int racketSpeed;
int pointsLeft;
int pointsRight;
boolean isKeyPressed;
boolean moveRacketOneUp;
boolean moveRacketTwoUp;
boolean moveRacketOneDown;
boolean moveRacketTwoDown;
boolean ballIsMoving;
boolean ballIsShrinking;

Racket racketLeft;
Racket racketRight;
int[] racketOneHitbox;
int[] racketTwoHitbox;
int[] racketOneMoving;
int[] racketTwoMoving;
ScoreBoard sc1;
ScoreBoard sc2;
// setup
void setup() {
   size(800, 600);
   stageWidth = 800;
   stageHeight = 600;
   isKeyPressed = false;
   
   
   racketLeft = new Racket(1, 20, 100, 50, stageHeight/2-50);
   racketRight = new Racket(2, 20, 100, stageWidth-50-20, stageHeight/2-50); 
   racketOneHitbox = racketLeft.getHitBox(); // return [x-position, y-position, heigth, width], alternative syntax = racketLeft.getHitBox()[2] - returns height.
   racketTwoHitbox = racketRight.getHitBox();
   
   
   ballXpos = stageWidth/2;
   ballYpos = stageHeight/2;
   ballSpeed = 5;
   ballXspeed = ballSpeed;//int(random(3, ballSpeed));
   ballYspeed = int(random(1, 2));
   ballSpeedRange= 10;
   ballSize = 30;
   racketSpeed = 4;
   ballIsMoving = true;
   ballIsShrinking = false;
   pointsLeft = 0;
   pointsRight = 0;
   
   sc1 = new ScoreBoard(1, 200, 30, 32, "0");
   sc2 = new ScoreBoard(2, stageWidth-200, 30, 32, "0");
    
}

// loop
void draw() {
  background(0);

  ellipse(ballXpos, ballYpos, ballSize, ballSize);
  
  if (ballIsMoving) {
    ballXpos += ballXspeed;
    ballYpos += ballYspeed;
  }
  
  racketOneHitbox = racketLeft.getHitBox(); // return [x-position, y-position, heigth, width], alternative syntax = racketLeft.getHitBox()[2] - returns height.
  racketTwoHitbox = racketRight.getHitBox();
  /*println("ballXpos = " + ballXpos);
  println("racketXpos = " + racketOneHitbox[0]);
  println("ballYpos = " + ballYpos);
  println("racketOneHitbox[1] " + racketOneHitbox[1]);*/
  // check if the ball is inside the racket hitbox from all sides
  racketOneMoving = racketLeft.getRacketMoving();
  if (ballXpos < racketOneHitbox[0]+ballSize && ballXpos > racketOneHitbox[0] + racketOneHitbox[3] && ballYpos > racketOneHitbox[1] && ballYpos < (racketOneHitbox[1]+racketOneHitbox[2])) {
    ballXspeed = -ballXspeed;
    ballXpos += ballSpeed*2; // to push the ball out of the hitbox to prevent the ball to get stuck in the racket hitbox by moving one step back and forth on the x axis. 
    
    if (racketOneMoving[0] == 1 && racketOneMoving[1] == 0) {
      ballYspeed -= 1;
    } else if (racketOneMoving[0] == 1 && racketOneMoving[1] == 1) {
       ballYspeed += 1; 
    } else if (racketOneMoving[0] == 0) {
      
    }
  } else if (ballXpos < racketOneHitbox[0]-racketOneHitbox[3]) {
      //println("racket one " + (racketOneHitbox[0]-racketOneHitbox[3]));
      
     ballIsMoving = false;
     shrinkBall();
     if (!ballIsShrinking) sc2.addScore();
     ballIsShrinking = true;
  }
  
   racketTwoMoving = racketRight.getRacketMoving();

  if (ballXpos > racketTwoHitbox[0]-ballSize/2 && ballXpos < racketTwoHitbox[0] + racketTwoHitbox[3] && ballYpos >= racketTwoHitbox[1] && ballYpos < (racketTwoHitbox[1]+racketTwoHitbox[2])) {
    ballXspeed = -ballXspeed;
    ballXpos -= ballSpeed*2; // to push the ball out of the hitbox to prevent the ball to get stuck in the racket hitbox by moving one step back and forth on the x axis
    if (racketTwoMoving[0] == 1 && racketTwoMoving[1] == 0) {
      println("racket two is moving up");
      ballYspeed -= 1;
    } else if (racketTwoMoving[0] == 1 && racketTwoMoving[1] == 1) {
      println("racket two is moving down");
      ballYspeed += 1; 
    } else if (racketTwoMoving[0] == 0) {
       println("racket is NOT moving"); 
   }    

  } /*else if (ballXpos > racketTwoHitbox[0]+racketTwoHitbox[3]) {
     // player two loose
     println("racket two = " + (racketOneHitbox[0]-racketOneHitbox[3]));
     ballIsMoving = false;
     shrinkBall();
     if (!ballIsShrinking) sc2.addScore();
     ballIsShrinking = true;
  }*/
  

  
  if (ballXpos <= 0 || ballXpos >= 800) {
     ballXspeed = -ballXspeed;
 
     
  } else if (ballYpos <= 0 || ballYpos >= 600) {
     ballYspeed = -ballYspeed;
     // right side win
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
  
  sc1.drawText();
  sc2.drawText();
}

void shrinkBall() {
  if (ballSize >=0.0) ballSize -= 0.5;
}

void moveRacket(int player, String direction) {
  
  if (player == 1) {
    println("player = " + player + ", direction = " + direction);
    if (racketOneHitbox[1] < 0) {
        
        moveRacketOneDown = true;
    } else if ((racketOneHitbox[1] + racketOneHitbox[2]) <= stageHeight) {
        moveRacketOneUp = true; 
    } else {
      if (direction == "up") {
       moveRacketOneUp = true;
      } else if (direction == "down") {
        println(direction);
        moveRacketOneDown = true;
      }
    }
  }
  
  if (player == 2) {
    if (racketTwoHitbox[1] < 0) {
        moveRacketTwoDown = true;
    } else if ((racketTwoHitbox[1] + racketTwoHitbox[2]) <= stageHeight) {
        moveRacketTwoUp = true; 
    } else {
      if (direction == "up") {
       moveRacketTwoUp = true;
      } else if (direction == "down") {
        moveRacketTwoDown = true;
      }
    }
  }
}

void keyHandler(int keypressed, int keyreleased) {
  switch (keypressed) {
    //player 1
    case 83:
      // key = s
      moveRacketOneUp = true;
      //moveRacket(1, "up");
      break;
    case 87:
      //key = w
      moveRacketOneDown = true;
      //moveRacket(1, "down");
      break;
      
    //player 2
    case 76:
      // key = s
      moveRacketTwoUp = true;
      //moveRacket(2, "up");
      break;
    case 80:
      //key = w
      moveRacketTwoDown = true;
      //moveRacket(2, "down");
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

void reset() {
   racketLeft.setRacketPos(stageHeight/2-50);
   racketRight.setRacketPos(stageHeight/2-50);
   pointsLeft = 0;
   pointsRight = 0;
}