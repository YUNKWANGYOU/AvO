class Timer
{
  int savedTime;
  int totalTime;
  
  Timer(int tmpTime)
  {
    totalTime = tmpTime;
  }
  
  void start()
  {
    savedTime = millis();
  }
  
  boolean isFinished()
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
