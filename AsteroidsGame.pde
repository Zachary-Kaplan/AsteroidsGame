Spaceship Player;
ArrayList <Bullet> shots = new ArrayList<Bullet>();
ArrayList <Asteroid> belt = new ArrayList<Asteroid>();
ArrayList <Drone> swarm = new ArrayList<Drone>();
int asteroidCount = 10;
int starCount = 200;
int u = 2;
Star[] field;
boolean W, A, S, D, warpOn;
String[] weaponType = new String[]{"Long Shot","Ion Wave","Bomb Shot","Point Defense"};
float timeSinceLastShot = 0; //when setting this value, integers are stored as seconds
boolean defenseSystem = false;
int weaponIndex = 0;
int hull = 100;
float invincibilityFrames = 3;
int score = 0;


public void setup()
{
  warpOn = true;
  size(1000,1000);
  background(0,0,0);
  Player  = new Spaceship();
  field = new Star[starCount];
  for(int a = 0; a < starCount; a++)
  {
    field[a] = new Star();
  }
  for(int a = 0; a < asteroidCount; a++)
  {
    belt.add(new Asteroid(3));
  }
}

public void draw()
{
  if(hull > 0)
  {
    //stars appear
    if(warpOn == true)
    {
      invincibilityFrames = 3;
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
      for(int a = 0; a < belt.size(); a++)
      {
        belt.get(a).move();
        belt.get(a).turn();
        belt.get(a).show();
        if ((invincibilityFrames <= 0) && (20 > dist((float)belt.get(a).getX(),(float)belt.get(a).getY(),(float)Player.getX(),(float)Player.getY())))
        {
          if(belt.get(a).getSize() == 3)
          {
            hull -= 50 + (int)((Math.random() * 6) - 2.5);
          } else if (belt.get(a).getSize() == 2)
          {
            hull -= 20 + (int)((Math.random() * 3) - 1);
          } else
          {
            hull -= (int)((Math.random() * 3) + 1);
          }
          belt.remove(a);
          invincibilityFrames = 1;
        }
      }
      for(int a = 0; a < swarm.size(); a++)
      {
        swarm.get(a).target();
        swarm.get(a).wander();
        swarm.get(a).turn();
        swarm.get(a).move();
        swarm.get(a).show();
        if(swarm.get(a).findClosestTarget(false) < 20)
        {
          swarm.remove(a);
        }
      }
      
      Player.move();
      Player.turn();
      Player.show();
      if (timeSinceLastShot > 0)
      {
        timeSinceLastShot -= (1.0/frameRate);
      }
      if (invincibilityFrames > 0)
      {
        invincibilityFrames -= (1.0/frameRate);
      }
      
      
      for (int a = 0; a < shots.size(); a++)
      {
        shots.get(a).move();
        shots.get(a).show();
        if(shots.get(a).getX() >= width)
        {
          shots.remove(a);
        } else if (shots.get(a).getX() <= 0)
        {
          shots.remove(a);
        } else if(shots.get(a).getY() >= height)
        {
          shots.remove(a);
        } else if (shots.get(a).getY() <= 0)
        {
          shots.remove(a);
        } else
        {
          if(shots.get(a).weaponClass == "Long Shot")
          {
            for(int b = 0; b < belt.size(); b++)
            {
              double d = dist((float)shots.get(a).getX(), (float)shots.get(a).getY(), (float)belt.get(b).getX(), (float)belt.get(b).getY());
              if (d < 10 * belt.get(b).getSize())
              {
                if(belt.get(b).getSize() > 1)
                {
                  belt.add(new Asteroid(belt.get(b).getSize() - 1,belt.get(b).getX(),belt.get(b).getY(),belt.get(b).getSpeedX(),belt.get(b).getSpeedY()));
                  belt.add(new Asteroid(belt.get(b).getSize() - 1,belt.get(b).getX(),belt.get(b).getY(),belt.get(b).getSpeedX(),belt.get(b).getSpeedY()));
                }
                score+=150;
                belt.remove(b);
                shots.remove(a);
                a--;
                b = belt.size();
              }
            }
          } else if(shots.get(a).weaponClass == "Bomb Shot")
          {
            ArrayList <Asteroid> detonated = new ArrayList<Asteroid>();
            boolean hasDetonated = false;
            for(int b = 0; b < belt.size(); b++)
            {
              double dBelt = dist((float)shots.get(a).getX(), (float)shots.get(a).getY(), (float)belt.get(b).getX(), (float)belt.get(b).getY());
              double dPlayer = dist((float)shots.get(a).getX(), (float)shots.get(a).getY(), (float)Player.getX(), (float)Player.getY());
              if((dPlayer > 200) || (dBelt < 25))
              {
                hasDetonated = true;
              }
            }
            if(hasDetonated == true)
            {
              for(int b = 0; b < belt.size();b++)
              {
                double dBelt = dist((float)shots.get(a).getX(), (float)shots.get(a).getY(), (float)belt.get(b).getX(), (float)belt.get(b).getY());
                if(dBelt < 50)
                {
                  detonated.add(belt.get(b));
                  belt.remove(b);
                  b--;
                }
              }
              fill(242,25,10);
              stroke(242,25,10);
              ellipse((float)shots.get(a).getX(),(float)shots.get(a).getY(), 100, 100);
              shots.remove(a);
              for(int b = 0; b < detonated.size(); b++)
              {
                if(detonated.get(b).getSize() > 2)
                {
                  belt.add(new Asteroid(detonated.get(b).getSize() - 2,detonated.get(b).getX(),detonated.get(b).getY(),detonated.get(b).getSpeedX(),detonated.get(b).getSpeedY()));
                  belt.add(new Asteroid(detonated.get(b).getSize() - 2,detonated.get(b).getX(),detonated.get(b).getY(),detonated.get(b).getSpeedX(),detonated.get(b).getSpeedY()));
                }
                if(detonated.get(b).getSize() > 1)
                {
                  belt.add(new Asteroid(detonated.get(b).getSize() - 1,detonated.get(b).getX(),detonated.get(b).getY(),detonated.get(b).getSpeedX(),detonated.get(b).getSpeedY()));
                  belt.add(new Asteroid(detonated.get(b).getSize() - 1,detonated.get(b).getX(),detonated.get(b).getY(),detonated.get(b).getSpeedX(),detonated.get(b).getSpeedY()));
                }
              }
              score += detonated.size() * 125;
            }
          } else if (shots.get(a).weaponClass == "Ion Wave")
          {
            for(int b = 0; b < belt.size(); b++)
            {
              double d = dist((float)shots.get(a).getX(), (float)shots.get(a).getY(), (float)belt.get(b).getX(), (float)belt.get(b).getY());
              if (d < 20 * belt.get(b).getSize())
              {
                if(belt.get(b).getSize() < 3)
                {
                  if(belt.get(b).getSize() > 1)
                  {
                    belt.add(new Asteroid(belt.get(b).getSize() - 1,belt.get(b).getX(),belt.get(b).getY(),belt.get(b).getSpeedX(),belt.get(b).getSpeedY()));
                    belt.add(new Asteroid(belt.get(b).getSize() - 1,belt.get(b).getX(),belt.get(b).getY(),belt.get(b).getSpeedX(),belt.get(b).getSpeedY()));
                    belt.add(new Asteroid(belt.get(b).getSize() - 1,belt.get(b).getX(),belt.get(b).getY(),belt.get(b).getSpeedX(),belt.get(b).getSpeedY()));
                    belt.add(new Asteroid(belt.get(b).getSize() - 1,belt.get(b).getX(),belt.get(b).getY(),belt.get(b).getSpeedX(),belt.get(b).getSpeedY()));
                  }
                  score+=100;
                  belt.remove(b);
                  b = belt.size();
                }
              }
            }
            if (200 < dist((float)shots.get(a).getX(), (float)shots.get(a).getY(), (float)Player.getX(), (float)Player.getY()))
            {
              shots.remove(a);
              a--;
            }
          }
        }
      }
      
      if (weaponType[weaponIndex] == "Point Defense")
      {
        if(defenseSystem == true)
        {
          int beltIndex = (int)Player.findClosestTarget(true);
          double beltDistance = Player.findClosestTarget(false);
          stroke(255,0,0);
          if((belt.get(beltIndex).mySize < 2) && (beltDistance < 50))
          {
            line((float)Player.getX(),(float)Player.getY(),(float)belt.get(beltIndex).getX(),(float)belt.get(beltIndex).getY());
            belt.remove(beltIndex);
          }
        }
      }
    
    
    
      if(belt.size() < 15 + (5 * Math.random()))
      {
        if (Math.random() < 1.0 / (belt.size() * 100) )
        {
          belt.add(new Asteroid(3));
        }
      }
      
      if(belt.size() < 5)
      {
        belt.add(new Asteroid(3+(int)(Math.random() + 0.2)));
      } else if(Math.random() > belt.size() / 25)
    
      //telemetry screen and values
      strokeWeight(1);
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
      textSize(15);
      text("Weapon Type: " + weaponType[weaponIndex], width - 210, height - 220);
      text("Location: " + (int)Player.getX() + ", " + (int)Player.getY(), width - 210, height - 200);
      text("Vectors: " + (int)(10 * Player.getSpeedX()) + ", " + (int)(10 * Player.getSpeedY()), width - 210, height - 180);
      text("Direction: " + (360 - (int)(180 * Player.getAngle()/PI)), width - 210, height - 160);
      text("Angular Speed: " + (int)(1000 * Player.getSpeedAngle()/PI), width - 210, height - 140);
      //text("Missiles Fired: " + shots.size(), width - 210, height - 120);
      text("Reload Time: " + (int)(timeSinceLastShot * 10), width - 210, height - 120);
      text("Asteroids Present: " + belt.size(), width - 210, height - 100);
      text("Hull Integrity: " + hull + "%", width - 210, height - 80);
      text("Drone Count: " + swarm.size(), width - 210, height - 60);
      text("Score: " + score, width - 210, height - 40);
    
    
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
  } else
  {
    fill(217, 182, 43, 80);
    textSize(15);
    text("You Lost", width/2, height/2);
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
  
  //Fire
  if (key == ' ')
  {
    if(timeSinceLastShot <= 0)
    {
      if(weaponType[weaponIndex] != "Point Defense")
      {
        defenseSystem = false;
        shots.add(new Bullet(weaponType[weaponIndex],1, Player.getX(), Player.getY(), Player.getAngle()));
        if(weaponType[weaponIndex] == "Long Shot")
        {
          timeSinceLastShot = 0.5;
        } else if(weaponType[weaponIndex] == "Ion Wave")
        {
          timeSinceLastShot = 1;
        } else if(weaponType[weaponIndex] == "Bomb Shot")
        {
          timeSinceLastShot = 0.75;
        }
      } else
      {
        defenseSystem = true;
      }
    }
  } else 
  {
    defenseSystem = false;
  }
  //cycle weapon
  if (key == 'q')
  {
    if (weaponIndex < weaponType.length - 1)
    {
      weaponIndex++;
    } else
    {
      weaponIndex = 0;
    }
  }
  
  if (key == 'e')
  {
    Player.torque(-Player.getSpeedAngle());
    Player.accelerate(0);
  }
  if (key == 'r')
  {
    if(weaponType[weaponIndex] == "Long Shot")
    {
      if(score > 1500)
      {
        score -= 1500;
        swarm.add(new Drone(weaponType[weaponIndex]));
      }
    } else if(weaponType[weaponIndex] == "Ion Wave")
    {
      if(score > 2000)
      {
        score -= 2000;
        swarm.add(new Drone(weaponType[weaponIndex]));
      }
    } else if(weaponType[weaponIndex] == "Bomb Shot")
    {
      if(score > 1750)
      {
        score -= 1750;
        swarm.add(new Drone(weaponType[weaponIndex]));
      }
    }
  }
  if(key == 'f')
  {
    if(score > 100)
    {
      score -= 100;
      hull += 1;
    }
  }
}
