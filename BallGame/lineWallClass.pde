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
  
  void display()
  {
    fill(0);
    stroke(0);
    line(x-size/2,y,x+size/2,y);
  }
  
  void move()
  {
    y+=speed;
  }
  
  void endGame(Ball ball)
  {
    if(ball.endState == 1)
    {
      y = -50;
      speed = 0;
    }
  }
  
}
