class Wall{
  float x, y;
  float size;
  float speed;
  color c;
  
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
  
  void display()
  {
    noStroke();
    rectMode(CENTER);
    fill(c);
    rect(x,y,size,size);
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
