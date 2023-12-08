class Drone extends Bullet
{
  double weaponCoolDown = 0;
  String droneType;
  double wanderX, wanderY;
  double wanderCoolDown = 0;
  public Drone(String weapon)
  {
    //make different designs for different weapon drones
    droneType = weapon;
    myAngle = Player.getAngle();
    mySpeedX = 7 * Math.cos(myAngle);
    mySpeedY = 7 * Math.sin(myAngle);
    myCenterX = Player.getX();
    myCenterY = Player.getY();
    myColorR = 148;
    myColorG = 121;
    myColorB = 118;
  }
  
  public void accelerate (double xThrust, double yThrust)   
  {
    if(xThrust > 0)
    {
      if(mySpeedX > 10)
      {
      } else
      {
        mySpeedX += xThrust;
      }
    } else if (xThrust < 0)
    {
      if(mySpeedX < -10)
      {
      } else
      {
        mySpeedX += xThrust;
      }
    }
    
    if(yThrust > 0)
    {
      if(mySpeedY > 10)
      {
      } else
      {
        mySpeedY += yThrust;
      }
    } else if (yThrust < 0)
    {
      if(mySpeedY < -10)
      {
      } else
      {
        mySpeedY += yThrust;
      }
    }
  }
  
  public void wander()
  {
    //System.out.println(wanderCoolDown);
    if(wanderCoolDown > 0)
   {
     while((wanderX + Player.getX() < 50) || (wanderX + Player.getX() > width - 50))
     {
       wanderX = (Math.random() * 200) - 100;
     }
     while((wanderY + Player.getY() < 50) || (wanderY + Player.getY() > height - 50))
     {
       wanderY = (Math.random() * 200) - 100;
     }
     wanderCoolDown -= 1/frameRate;
     double deltaX = Player.getX() + wanderX - myCenterX;
     double deltaY = Player.getY() + wanderY - myCenterY;
     double moveX = 0;
     double moveY = 0;
     if(deltaX > 100)
     {
       moveX = 2;
     } else if (deltaX < -100)
     {
       moveX = -2;
     } else if ((deltaX > -50) && (deltaX < 50))
     {
       moveX = Math.random() - 0.5;
     }
     
     if(deltaY > 100)
     {
       moveY = 2;
     } else if (deltaY < -100)
     {
       moveY = -2;
     } else if ((deltaY > -50) && (deltaY < 50))
     {
       moveY = Math.random() - 0.5;
     }
     accelerate(moveX,moveY);
     } else 
     {
     wanderCoolDown = 0.1;
     wanderX = (Math.random() * 200) - 100;
     wanderY = (Math.random() * 200) - 100;
     }
  }
  
  public void target()
  {
    int beltIndex = (int)findClosestTarget(true);
    double beltDistance = findClosestTarget(false);
    setAngle(myCenterX,myCenterY,belt.get(beltIndex).getX(),belt.get(beltIndex).getY());
    if(weaponCoolDown <=0)
    {
      if(droneType == "Long Shot")
      {
        if(beltDistance < 200)
        {
          shots.add(new Bullet(droneType,0.25, myCenterX, myCenterY, myAngle));
          weaponCoolDown = 4;
        }
      } else if (droneType == "Ion Wave")
      {
        if(beltDistance < 100)
        {
          shots.add(new Bullet(droneType,0.125, myCenterX, myCenterY, myAngle));
          weaponCoolDown = 8;
        }
      } else if (droneType == "Bomb Shot")
      {
        if(beltDistance < 150)
        {
          shots.add(new Bullet(droneType,0.5, myCenterX, myCenterY, myAngle));
          weaponCoolDown = 6;
        }
      }
    }
  }
  
  public void setAngle(double myX, double myY, double goX, double goY)
  {
    //System.out.println("a");
    double deltaX = goX - myX;
    double deltaY = goY - myY;
    if(deltaX == 0)
    {
      deltaX = 1;
    }
    double newAngle = Math.atan(deltaY/deltaX);
    if(deltaX < 0)
    {
      if(deltaY > 0)
      {
        newAngle += PI;
      } else
      {
        newAngle -= PI;
      }
    }
    myAngle = newAngle;
    //if (newAngle > myAngle)
    //{
    //  System.out.println("b");
    //  torque(PI/2000);
    //} else if (newAngle < myAngle)
    //{
    //  System.out.println("c");
    //  torque(-PI/2000);
    //}
  }
  
  public void show()
  {
    weaponCoolDown -= 1/frameRate;
    strokeWeight(1);
    fill(myColorR,myColorG,myColorB);
    stroke(myColorR,myColorG,myColorB);
    translate((float)myCenterX, (float)myCenterY);
    rotate((float)myAngle);
    rect(2*u,-u,4*u,2*u);
    ellipse(0,0,6*u,6*u);
    if(droneType == "Long Shot")
    {
      stroke(131,219,235);
    } else if (droneType == "Ion Wave")
    {
      stroke(131,219,235);
    } else if (droneType == "Bomb Shot")
    {
      stroke(227,114,16);
    }
    ellipse(0,0,u,u);
    rotate(-(float)myAngle);
    translate(-(float)myCenterX, -(float)myCenterY);

  }
}
