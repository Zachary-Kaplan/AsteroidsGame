class Star
{
  double xCoord, yCoord, speed, angle;
  float distance;
  Star()
  {
    xCoord = width/2;
    yCoord = height/2;
    speed = Math.random() * 10 + 1;
    angle = Math.random() * 2 * PI;
  }
  void move ()
  {
    xCoord += speed * Math.cos(angle);
    yCoord += speed * Math.sin(angle);
    if ((xCoord > width) || (xCoord < 0))
    {
      xCoord = width/2;
      yCoord = height/2;
      speed = Math.random() * 8 + 1;
      angle = Math.random() * 2 * PI;
    }
    if ((yCoord > height) || (yCoord < 0))
    {
      xCoord = width/2;
      yCoord = height/2;
      speed = Math.random() * 8 + 1;
      angle = Math.random() * 2 * PI;
    }
  }
  void show ()
  {
    noStroke();
    distance = dist((float)xCoord,(float)yCoord,width/2,height/2);
    
    //blueshift
    if (warpOn == true)
    {
      if (distance < 70)
      {
        fill(100 + .1* distance, 100 + .1 * distance, 100 + 10 * distance);
      } else if(distance < 200)
      {
        fill(200 + .1* distance, 200 + .1 * distance, 200 + 10 * distance);
      } else if (distance > 400)
      {
        fill(100 + 10* distance, 100 + .1 * distance, 100 + .1 * distance);
      } else
      {
        fill(255);
      }
    } else 
    {
      fill(255,255,255);
    }
    
    //star
      ellipse((float)xCoord, (float)yCoord, 2,2);
    }
}
