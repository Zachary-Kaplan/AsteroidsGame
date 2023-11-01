class Floater
{
  protected double myCenterX, myCenterY, mySpeedX, mySpeedY, myAngle, mySpeedAngle;
  protected int[] xCorners;
  protected int[] yCorners;
  protected int corners, myColorR,myColorG,myColorB;
  
  public void move()
  {
    myCenterX +=mySpeedX;
    myCenterY +=mySpeedY;
    
    if(myCenterX > width)
    {
      myCenterX = 0;
    } else if (myCenterX < 0)
    {
      myCenterX = width;
    }
    if(myCenterY > height)
    {
      myCenterY = 0;
    } else if (myCenterY < 0)
    {
      myCenterY = height;
    }
  }
  
  public void warp()
  {
    myCenterX = width * Math.random();
    myCenterY = height * Math.random();
    mySpeedX = 0;
    mySpeedY = 0;
    mySpeedAngle = 0;
  }
  
  public void accelerate (double dAmount)   
  {           
    mySpeedX += ((dAmount) * Math.cos(myAngle));    
    mySpeedY += ((dAmount) * Math.sin(myAngle));      
    if (dAmount == 0)
    {
      mySpeedX = 0;
      mySpeedY = 0;
    }
  }   
  public void turn ()   
  {     
    myAngle+=mySpeedAngle;
    if (myAngle > 2 * PI)
    {
      myAngle -= (2 * PI);
    } else if (myAngle < 0)
    {
      myAngle += (2 * PI);
    }
  }
  
  public void torque(double angularAcceleration)
  {
    mySpeedAngle+= angularAcceleration;
  }
  
  public void show()
  {
    strokeWeight(1);
    fill(myColorR,myColorG,myColorB);
    stroke(myColorR,myColorG,myColorB);
    translate((float)myCenterX, (float)myCenterY);
    rotate((float)myAngle);
    beginShape();
    for (int a = 0; a < xCorners.length; a++)
    {
      vertex(xCorners[a],yCorners[a]);
    }
    endShape(CLOSE);
    rotate(-(float)myAngle);
    translate(-(float)myCenterX, -(float)myCenterY);
  }
  
  public double findClosestTarget(boolean returnType)
  {
    int lowestDistIndex = 0;
    double lowestDist = dist((float)Player.getX(), (float)Player.getY(), (float)belt.get(0).getX(), (float)belt.get(0).getY());
    for(int a = 1; a < belt.size(); a++)
    {
      double newDist = dist((float)Player.getX(), (float)Player.getY(), (float)belt.get(a).getX(), (float)belt.get(a).getY());
      if(lowestDist > newDist)
      {
        lowestDist = newDist;
        lowestDistIndex = a;
      }
    }
    if (returnType == true)
    {
      return lowestDistIndex;
    } else 
    {
      return lowestDist;
    }
  }
  public double getX()
  {
    return myCenterX;
  }
  public double getY()
  {
    return myCenterY;
  }
  public double getSpeedX()
  {
    return mySpeedX;
  }
  public double getSpeedY()
  {
    return mySpeedY;
  }
  public double getAngle()
  {
    return myAngle;
  }
  public double getSpeedAngle()
  {
    return mySpeedAngle;
  }
}
