class Spaceship extends Floater
{
  public Spaceship()
  {
    corners = 3;
    xCorners = new int[]{18*u,-2*u,-5*u,-5*u,-7*u,-7*u,-8*u,-6*u,-6*u,-10*u,-10*u,-11*u,-11*u,-10*u,-10*u,-6*u,-6*u,-8*u,-7*u,-7*u,-5*u,-5*u,-2*u};
    yCorners = new int[]{0,6*u,6*u,10*u,10*u,6*u,3*u,3*u,2*u,2*u,4*u,4*u,-4*u,-4*u,-2*u,-2*u,-3*u,-3*u,-6*u,-10*u,-10*u,-6*u,-6*u};
    myAngle = 0;
    mySpeedX = 0 * Math.cos(myAngle);
    mySpeedY = 0 * Math.sin(myAngle);
    myCenterX = width/2;
    myCenterY = height/2;
    myColorR = 126;
    myColorG = 136;
    myColorB = 150;
  }
}
