import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BallGame extends PApplet {

Ball myBall;
Wall []myWall;
lineWall mylineWall;
Timer myTimer;
Timer myTimer2;

final int SIZE = 3;

int score = 0;

public void setup()
{
  
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

public void draw()
{
  background(255);
  
  if(myTimer.isFinished())
  {
    if(myBall.endState == 0)
    {
      for(int i = 0 ; i < SIZE ; i++)
      {
         myWall[i] = new Wall();
         myWall[i].speed += 1.75f;
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
  text("SCORE : "+score/100.0f,width-100,height-20);
}

public void mousePressed()
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
class Ball{
  
  float x, y;
  float r;
  float ySpeed;
  float xSpeed;
  
  int xState;
  
  int endState;
  
  float gravity;
  
  Ball(int tX, int tY)
  {
    x = tX;
    y = tY;
    r = 25;
    ySpeed = 5;
    xSpeed = 2;
    
    xState = 0;
    endState = 0;
    
    gravity = 0.2f;
  }
  
  public void display()
  {
    fill(255,255,0);
    stroke(100);
    ellipse(x,y,r,r);
  }
  
  public void gravity()
  {
    ySpeed += gravity;
  }
  
  public void move()
  {
    y = y +  ySpeed;
  }
  
  public void bound()
  {
    ySpeed = -6.75f;
  }
  
  public void xLoc()
  {
      if(xState == 1)
      {
        x += xSpeed;
      }  
      else if (xState == -1)
      {
        x -= xSpeed;
      }
    
  }
  
  public void sideLine()
  {
    if(x>width || x<0)
    {
      if(x>width)
      {
        xSpeed *= 1;
        xState = -1;
      }
      else
      {
        xSpeed *= 1;
        xState = 1;
      }
    }
  }
  
  public void bottomLine()
  {
    if(y> height+r*3)
    {
      endState = 1;
    }
  }
  
  public void interection(Wall w)
  {
    if(w.size/2 > dist(w.x,w.y,x,y))
    {
      endState = 1;
    }
  }
  
   public void lineInterection(lineWall l)
  {
    if(( y-r/2 <= l.y )&&(y+r/2 >= l.y)&&(x-r/2 <= l.x+l.size/2)&&(x+r/2 >= l.x-l.size/2))
    {
      endState = 1;
    }
  }
  
  public void endGame(int score)
  {
    if(endState == 1)
    {
      x = -width;
      y = -height;
      ySpeed = 0;
      xSpeed = 0;
      gravity = 0;
      
      textSize(20);
      fill(0);
      text("Score : "+ score/100.0f + "sec",width*2/9,height/2);
    }
  }
}
    
class Timer
{
  int savedTime;
  int totalTime;
  
  Timer(int tmpTime)
  {
    totalTime = tmpTime;
  }
  
  public void start()
  {
    savedTime = millis();
  }
  
  public boolean isFinished()
  {
    int passedTime = millis() - savedTime;
    
    if(passedTime > totalTime)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
}
class Wall{
  float x, y;
  float size;
  float speed;
  int c;
  
  float r,g,b;
  
  Wall()
  {
    size = random(30,40);
    x = random(0+size/2, width-size/2);
    y = random(-height/2,0-size/2);
    speed = 2;
    
    r = random(0,255);
    g = random(0,255);
    b = random(0,255);
    
    c = color(r,g,b);
  }
  
  public void display()
  {
    noStroke();
    rectMode(CENTER);
    fill(c);
    rect(x,y,size,size);
  }
  
  public void move()
  {
    y+=speed;
  }
  
  public void endGame(Ball ball)
  {
    if(ball.endState == 1)
    {
      y = -50;
      speed = 0;
    }
  }
  
}
class lineWall{
  float x, y;
  float size;
  float speed;
  
  float l;
  lineWall()
  {
    size = random(70,100);
    x = random(0+size/2, width-size/2);
    y = random(-height*3/4,0-size/2);
    speed = 2;
  }
  
  public void display()
  {
    fill(0);
    stroke(0);
    line(x-size/2,y,x+size/2,y);
  }
  
  public void move()
  {
    y+=speed;
  }
  
  public void endGame(Ball ball)
  {
    if(ball.endState == 1)
    {
      y = -50;
      speed = 0;
    }
  }
  
}
  public void settings() {  size(250,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BallGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
