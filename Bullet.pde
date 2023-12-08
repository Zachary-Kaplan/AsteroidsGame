class Bullet extends Floater
{
  String weaponClass = "";
  public Bullet()
  {
    corners = 4;
    xCorners = new int[]{3*u,2*u,8*u,2*u};
    yCorners = new int[]{0,-2*u,0,2*u};
    myAngle = Player.getAngle();
    mySpeedX = 7 * Math.cos(myAngle);
    mySpeedY = 7 * Math.sin(myAngle);
    myCenterX = Player.getX();
    myCenterY = Player.getY();
    myColorR = 114;
    myColorG = 118;
    myColorB = 125;
  }
  public Bullet(String weapon, float scale, double startX, double startY, double startAngle)
  {
    scale = 0;
    weaponClass = weapon;
    if (weaponClass == "Long Shot")
    {
      corners = 4;
      xCorners = new int[]{3*u,2*u,8*u,2*u};
      yCorners = new int[]{0,-2*u,0,2*u};
      myAngle = startAngle;
      mySpeedX = 17 * Math.cos(myAngle);
      mySpeedY = 17 * Math.sin(myAngle);
      myCenterX = startX;
      myCenterY = startY;
      myColorR = 114;
      myColorG = 118;
      myColorB = 125;
    } else if (weaponClass == "Ion Wave")
    {
      corners = 4;
      xCorners = new int[]{u,4*u,4*u,u};
      yCorners = new int[]{10*u,10*u,-10*u,-10*u};
      myAngle = startAngle;
      mySpeedX = 10 * Math.cos(myAngle);
      mySpeedY = 10 * Math.sin(myAngle);
      myCenterX = startX;
      myCenterY = startY;
      myColorR = 131;
      myColorG = 219;
      myColorB = 235;
    } else if (weaponClass == "Bomb Shot")
    {
      corners = 9;
      xCorners = new int[]{2*u,u,-u,-2*u,-3*u,-3*u,-2*u,-u,u};
      yCorners = new int[]{0,u,u,0,u,-u,0,-u,-u};
      myAngle = startAngle;
      mySpeedX = 7 * Math.cos(myAngle);
      mySpeedY = 7 * Math.sin(myAngle);
      myCenterX = startX;
      myCenterY = startY;
      myColorR = 227;
      myColorG = 114;
      myColorB = 16;
    } else if (weaponClass == "Point Defence")
    {
      //check for nearest asteroid
      //if close enough fire there
      //has to be size 1 asteroid tho
      corners = 0;
      xCorners = new int[]{0};
      yCorners = new int[]{0};
      myAngle = 0;
      mySpeedX = 0;
      mySpeedY = 0;
      myCenterX = Player.getX();
      myCenterY = Player.getY();
      myColorR = 255;
      myColorG = 0;
      myColorB = 0;
    }
  }
  
  public void fire()
  {
    myAngle = Player.getAngle();
    mySpeedX = Player.getSpeedX() + (10 * Math.cos(myAngle));
    mySpeedY = Player.getSpeedY() + (10 * Math.sin(myAngle));
    myCenterX = Player.getX();
    myCenterY = Player.getY();
  }

  public void show()
  {
    if ((weaponClass == "Long Shot") || (weaponClass == "Bomb Shot"))
    {
      super.show();
    } else if (weaponClass == "Ion Wave")
    {
      noFill();
      strokeWeight(5);
      stroke(myColorR,myColorG,myColorB);
      translate((float)myCenterX, (float)myCenterY);
      rotate((float)myAngle);
      bezier(xCorners[0], yCorners[0], xCorners[1], yCorners[1], xCorners[2], yCorners[2], xCorners[3], yCorners[3]);
      rotate(-(float)myAngle);
      translate(-(float)myCenterX, -(float)myCenterY);
    } else if (weaponClass == "Bomb Shot")
    {
      super.show();
    }
  }
}
