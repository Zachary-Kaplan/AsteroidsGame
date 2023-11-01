class Asteroid extends Floater
{
  int mySize = 0;
  public Asteroid(int size)
  {
    mySize = size;
    corners = 5 + (int)(Math.random() * 2);
    xCorners = new int[corners];
    yCorners = new int[corners];
    double cornerAngle = Math.random() * PI/6;
    for(int a = 0; a < corners; a++)
    {
      cornerAngle = (a * PI/3) + (PI/6 * Math.random());
      xCorners[a] = (int)(((mySize + 1) * Math.random()) + (mySize * 5 * Math.cos(cornerAngle)));
      yCorners[a] = (int)(((mySize + 1) * Math.random()) + (mySize * 5 * Math.sin(cornerAngle)));
    }
    mySpeedAngle = Math.random() * Math.random() * Math.random();
    myAngle = 2 * PI * Math.random();
    mySpeedX = Math.cos(myAngle) * 3 * Math.random();
    mySpeedY = Math.sin(myAngle) * 3 * Math.random();
    myCenterX = Math.random() * width;
    myCenterY = Math.random() * height;
    myColorR = 230;
    myColorG = 230;
    myColorB = 230;
  }
  public Asteroid(int size, double xPos, double yPos, double dX, double dY)
  {
    mySize = size;
    corners = 5 + (int)(Math.random() * 2);
    xCorners = new int[corners];
    yCorners = new int[corners];
    double cornerAngle = Math.random() * PI/corners;
    for(int a = 0; a < corners; a++)
    {
      cornerAngle = (a * PI/3) + (PI/corners * Math.random());
      xCorners[a] = (int)(((mySize + 1) * Math.random()) + (mySize * 5 * Math.cos(cornerAngle)));
      yCorners[a] = (int)(((mySize + 1) * Math.random()) + (mySize * 5 * Math.sin(cornerAngle)));
    }
    mySpeedAngle = Math.random() * Math.random() * Math.random();
    myAngle = (Math.random() * PI/8) + (Math.atan(dY/dX));
    mySpeedX = Math.cos(myAngle) * sqrt((float)((dX * dX) + (dY * dY)));
    mySpeedY = Math.sin(myAngle) * sqrt((float)((dX * dX) + (dY * dY)));
    myCenterX = xPos;
    myCenterY = yPos;
    myColorR = 230;
    myColorG = 230;
    myColorB = 230;
  }
  public int getSize()
  {
    return mySize;
  }
}
