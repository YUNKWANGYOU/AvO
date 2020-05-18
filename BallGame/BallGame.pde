Ball myBall;
Wall []myWall; 
lineWall mylineWall; 
Timer myTimer;
Timer myTimer2;

final int SIZE = 3;

int score = 0;

void setup()
{
  size(250,500);
  myBall = new Ball(width/2,height/2);
 
  myWall = new Wall[SIZE];
  mylineWall = new lineWall();
  
  myTimer = new Timer(8000); // timing of falling wall
  myTimer2 = new Timer(10); // just timer
  
  
  for(int i = 0 ; i < SIZE ; i++)
  {
    myWall[i] = new Wall();
  }
  
  
}

void draw()
{
  background(255);
  
  if(myTimer.isFinished())
  {
    if(myBall.endState == 0) // playing game
    {
      for(int i = 0 ; i < SIZE ; i++)
      {
         myWall[i] = new Wall();
         myWall[i].speed += 1.75; //Wall speed up
      }
      mylineWall = new lineWall();
      
      mylineWall.speed += 1.75; // Wall speed up
      score +=10;
    
      myTimer.start();
    }
  }
  
  if(myTimer2.isFinished()) // timer
  {
    if(myBall.endState == 0) // playing game
    {
      score += 1;
      myTimer2.start();
    }
  }
  
  
  for(int i=0;  i<SIZE ; i++)
  {
    myWall[i].display();
    myWall[i].move();
    myBall.interection(myWall[i]); // detect interaction between wall and ball
    myWall[i].endGame(myBall);
  }
  
  mylineWall.display();
  mylineWall.move();
  myBall.lineInterection(mylineWall); // detect interaction between line wall and ball
  mylineWall.endGame(myBall);
    
  myBall.display();
  myBall.gravity(); // give gravity to ball
  myBall.move();
  myBall.xLoc(); // using at mousePressed
  myBall.sideLine(); // if the Ball is out of sideline, then bound
  myBall.bottomLine(); // if the Ball is out of bottomline, then end game
  
  myBall.endGame(score); // save score in game
  
  fill(0);
  textSize(10);
  text("SCORE : "+score/100.0,width-100,height-20);
}

void mousePressed()
{
  if(mouseX > width/2 && myBall.ySpeed > 0) // if you pressed rightside of window, then the Ball is bound right
  {
    myBall.bound();
    myBall.xState = 1;
  }
  if(mouseX < width/2 && myBall.ySpeed > 0) // if you pressed rightside of window, then the Ball is bound left
  {
    myBall.bound();
    myBall.xState = -1;
  }
}
