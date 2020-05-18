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
    
    gravity = 0.2;
  }
  
  void display()
  {
    fill(255,255,0);
    stroke(100);
    ellipse(x,y,r,r);
  }
  
  void gravity()
  {
    ySpeed += gravity;
  }
  
  void move()
  {
    y = y +  ySpeed;
  }
  
  void bound()
  {
    ySpeed = -6.75;
  }
  
  void xLoc()
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
  
  void sideLine()
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
  
  void bottomLine()
  {
    if(y> height+r*3)
    {
      endState = 1;
    }
  }
  
  void interection(Wall w)
  {
    if(w.size/2 > dist(w.x,w.y,x,y))
    {
      endState = 1;
    }
  }
  
   void lineInterection(lineWall l)
  {
    if(( y-r/2 <= l.y )&&(y+r/2 >= l.y)&&(x-r/2 <= l.x+l.size/2)&&(x+r/2 >= l.x-l.size/2))
    {
      endState = 1;
    }
  }
  
  void endGame(int score)
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
      text("Score : "+ score/100.0 + "sec",width*2/9,height/2);
    }
  }
}
    
