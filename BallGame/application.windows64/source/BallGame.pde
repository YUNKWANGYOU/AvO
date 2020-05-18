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
  
  myTimer = new Timer(8000);
  myTimer2 = new Timer(10);
  
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
    if(myBall.endState == 0)
    {
      for(int i = 0 ; i < SIZE ; i++)
      {
         myWall[i] = new Wall();
         myWall[i].speed += 1.75;
      }
      mylineWall = new lineWall();
    
      score +=10;
    
      myTimer.start();
    }
  }
  
  if(myTimer2.isFinished())
  {
    if(myBall.endState == 0)
    {
      score += 1;
      myTimer2.start();
    }
  }
  
  
  for(int i=0;  i<SIZE ; i++)
  {
    myWall[i].display();
    myWall[i].move();
    myBall.interection(myWall[i]);
    myWall[i].endGame(myBall);
  }
  
  mylineWall.display();
  mylineWall.move();
  myBall.lineInterection(mylineWall);
  mylineWall.endGame(myBall);
    
  myBall.display();
  myBall.gravity();
  myBall.move();
  myBall.xLoc();
  myBall.sideLine();
  myBall.bottomLine();
  
  myBall.endGame(score);
  
  fill(0);
  textSize(10);
  text("SCORE : "+score/100.0,width-100,height-20);
}

void mousePressed()
{
  if(mouseX > width/2 && myBall.ySpeed > 0)
  {
    myBall.bound();
    myBall.xState = 1;
  }
  if(mouseX < width/2 && myBall.ySpeed > 0)
  {
    myBall.bound();
    myBall.xState = -1;
  }
}
