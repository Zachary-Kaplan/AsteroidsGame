Spaceship Player;
int asteroidCount = 10;
int starCount = 200;
int u = 2;
Star[] field;
boolean W, A, S, D, warpOn, bulletFired;


public void setup()
{
  warpOn = true;
  size(1000,1000);
  background(0,0,0);
  Player = new Spaceship();
  field = new Star[starCount];
  for(int a = 0; a < starCount; a++)
  {
    field[a] = new Star();
  }
}

public void draw()
{
  
  //stars appear
  if(warpOn == true)
  {
    fill(0,0,0,50);
    rect(0,0,width,height);
    for(int a = 0; a < starCount; a++)
    {
      field[a].show();
      field[a].move();
    }
  } else
  {
    background(0,0,0);
    for(int a = 0; a < starCount; a++)
    {
      field[a].show();
    }
    Player.move();
    Player.turn();
    Player.show()
    
    //telemetry screen and values
    fill(242, 225, 196,50);
    stroke(94,77,9);
    beginShape();
    vertex(width - 250, height);
    vertex(width - 250, height - 210);
    vertex(width - 210, height - 250);
    vertex(width, height - 250);
    vertex(width, height);
    endShape(CLOSE);
    fill(217, 182, 43, 80);
    textSize(20);
    text("Location: " + (int)Player.myCenterX + ", " + (int)Player.myCenterY, width - 210, height - 200);
    text("Vectors: " + (int)(10 * Player.mySpeedX) + ", " + (int)(10 * Player.mySpeedY), width - 210, height - 180);
    text("Direction: " + (int)(180 * Player.myAngle/PI), width - 210, height - 160);
    text("Angular Speed: " + (int)(1000 * Player.mySpeedAngle/PI), width - 210, height - 140);
    
    //Viewports and window frames
    
    //stroke(34, 34, 64);
    //fill(50, 50, 74);
    //beginShape();
    //vertex(200,0);
    //vertex(400,200);
    //vertex(width-400,200);
    //vertex(width-200,0);
    //vertex(width-140,0);
    //vertex(width-400,220);
    //vertex(400,220);
    //vertex(140,0);
    //endShape(CLOSE);
}
  
  
  //WASD checks
  if (W == true)
  {
    Player.accelerate(0.125);
  } else if (S == true)
  {
    Player.accelerate((float)(-0.0625));
  }
  
  if (A == true)
  {
    Player.torque(-PI/2000);
  } else if (D == true)
  {
    Player.torque(PI/2000);
  }
  
  if(keyPressed == false)
  {
    W = false;
    S = false;
    A = false;
    D = false;
  }
}



//button presses
public void keyPressed()
{
  if(key == 'h')
  {
    if (warpOn == false)
    {
      warpOn = true;
    } else
    {
      Player.warp();
      warpOn = false;
    }
  }
  
  //accelerate
  if (key == 'w')
  {
    W = true;
    S = false;
  } else if ((key != 'w') && (D || A))
  {
    W = false;
  }
  if (key == 's')
  {
    S = true;
    W = false;
  } else if ((key != 's') && (D || A))
  {
    S = false;
  } 
  
  //rotates
  if (key == 'a')
  {
    A = true;
    D = false;
  } else if (key != 'a')
  {
    A = false;
  }
  if (key == 'd')
  {
    D = true;
    A = false;
  } else if (key != 'd')
  {
    D = false;
  }
  

  
  if (key == 'e')
  {
    Player.torque(-Player.mySpeedAngle);
    Player.accelerate(0);
  }
}
