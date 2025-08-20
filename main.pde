import processing.sound.*; //<>// //<>//
SoundFile Music, shoot ,  points ,  gameOver  ;
PFont retro;

public String MapFile[] = { "Maps/Map_lvl_1.jpg", "Maps/Map_lvl_2.jpg", "Maps/Map_lvl_3.jpg", "Maps/Map_lvl_4.jpg" , "Maps/Map_lvl_Bonus.jpg"};
public ArrayList<PImage> Mapsbackground = new ArrayList<PImage>(); 

public String file[] = { "levels/level-1.txt", "levels/level-2.txt", "levels/level-3.txt", "levels/level-4.txt" , "levels/Bonus-5.txt"};
public ArrayList<String[]> levels = new ArrayList<String[]>(); 

//------------------------------------------------------------------------------- 
final color GREY = color(120,152,160);
final color lvl1 = color(24,56,64);
final color lvl3 = color(156,129,22);
final color lvl2 = color(79,135,150);
final color lvl4 = color(114,113,57);
final color bonus = color(242,66,231);
final color colorWall[] = { lvl1, lvl2, lvl3, lvl4 , bonus };

final color BRED = color(211,39,52);
final color BORANGE = color(218,125,34);
final color BYELLOW = color(230,218,41); 
final color BGREEN = color (40,198,65);
final color BBLUE = color(45,147,221);
final color BPINK = color(240,93,173);
final color COLORS[] = {  BRED , BORANGE, BYELLOW, BGREEN , BBLUE , BPINK };

final color BLACK = color(0, 0, 0);
final color WHITE = color(255,255,255);
//------------------------------------------------------------------------------- 

final int W_WIDTH = 1280;
final int W_HEIGHT = 896;

//------------------------------------------------------------------------------- 
final int seconds = 10*60;
final float raio = 25;
final int CannonSize = 80;
final float CannonVelocity = 4.4;
final int velocityBullet = 10; 
public int gameScore = 0;


ArrayList<Integer> differentInteger = new ArrayList<Integer>();//--------> inside of ceiling class
public long timeOfWin = 0;

ArrayList<Color> colorGrid = new ArrayList<Color>();//-------------------> inside of cannon class
public long shootTime = 0;

//------------------------------------------------------------------------------- 
final Cannon cannon = new Cannon(W_WIDTH/2,W_HEIGHT-50,PI/2,CannonSize,BLACK);

final Ceiling ceiling = new Ceiling(W_WIDTH/2,W_HEIGHT-390,515,834);

ArrayList<Bullet>bullet = new ArrayList<Bullet>();
ArrayList<Bullet> bulletsToRemove = new ArrayList<>();

final float xGrid = ceiling.x-ceiling.largura/2+raio+raio/4;
final float yGrid = ceiling.yMove - ceiling.altura/2 + raio;
final BulletGrid bulletGrid = new BulletGrid( xGrid , yGrid , raio );
//------------------------------------------------------------------------------- 

void setup() 
{
  bulletGrid.onOff = false; //---------------------------------------------------------------------------> Turn ON or OFF the BulletGrid
  ceiling.onOff = true;//------------------------------------------------------------------------------> Turn ON or OFF the Ceiling
  
  for (String filename : MapFile) 
     {
          PImage maps = loadImage(filename);
          Mapsbackground.add(maps);
     }  
  retro = loadFont("RetroGaming-50.vlw");
  textFont(retro);
  
    shoot = new SoundFile(this,"data/effects/retroExplosion.wav");
    Music = new SoundFile(this,"data/effects/retroMusic.wav");
    points = new SoundFile(this,"data/effects/boom.wav");
    Music.amp(0.4);
    shoot.amp(0.1);
    
  Music.loop();
  
  bulletGrid.makeTheMap();
  frameRate(120);
}
//-------------------------------------------------------------------------------
  public  int indexMap = 0;
void keyPressed()
{
   if( keyCode == RIGHT )
      {
        cannon.right();
      }
  
   else if( keyCode == LEFT )
      {
        cannon.left();
      }
      
   else if( keyCode == ' ' )
      {
        cannon.shootBullet();
      }
 
  else if (keyCode >= '1' && keyCode <= '5' ) 
      {
        indexMap = (keyCode - '0')-1; 
        ceiling.nextLevel(bulletGrid.cells);
      }
  else if (keyCode == BACKSPACE  ) 
      {
        for(Bullet b1 : bullet)
         {
            b1.velocityX = random(-5.5,5.5);
            b1.boom = true;    
         }
      }
}

//------------------------------------------------------------------------------- 
void settings()
{
  size(W_WIDTH, W_HEIGHT);
  
  
}
//------------------------------------------------------------------------------- 
  int contadorFrames = 0;
  float collisionX = ceiling.x - ceiling.largura/2;
  float collisionY = 0;
void draw()
{
//------------------------------------------------------------------ LOGIC OF THE GAME ----------------------------------------------------------------------------------------------//
    background( Mapsbackground.get(indexMap) );
   
    cannon.draw();
    bulletGrid.draw();
    ceiling.draw();
    
    collisionY = ceiling.yMove - ceiling.altura/2;
    
    for(Bullet b1 : bullet)
    {
 
      b1.checkCollision( collisionX , collisionY  );//----------------> calculate collision with the Ceiling
        for( int i = 0; i < bullet.size()-1 ; i++)
          {
            if(b1.collidesWith( bullet.get(i) ) && cannon.y > b1.y && b1 != bullet.get(i) && !bullet.get(i).boom)
                    { 
                      b1.hit = true;//----------------------------> check collision with other bullet
                    }
                    
             else if(bullet.get(i).y > W_HEIGHT+raio*2 && bullet.get(i).boom ) 
                    { 
                      bulletsToRemove.add( bullet.get(i) );//---------------------> save bullet that was out of the screen and after will be eliminates
                    }         
          }
          
      bulletGrid.checkCell(b1);//-------------------------------> check if the cell is empty or not for the bullet
      bulletGrid.checkBoom(b1);//---------------------------------> check if the bullet had around 3 bullet of the same color and BOOM!!
      b1.draw();
    }

    ceiling.winTheGame();
    ceiling.loseTheGame();
   
 
    bullet.removeAll( bulletsToRemove ); //--------------------------------------> eliminates bullets that pass the limit
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
    
    textAlign(CENTER);//---------------------------------------> FPS
    if(frameRate > 105) 
      {  
          fill( 0,255,0 );  
      } 
    else if(frameRate < 105 && frameRate > 80) 
      {  
          fill( 255,255,0 );
      }
    else 
      {  
          fill(BRED);   
      }
    textSize(20);
    text("FPS: " + (int)frameRate , 70, 30);
    
        textSize(25); //---------------------------------------> Score
        fill(  BLACK );
        text( gameScore , W_WIDTH/8 , 485);
    
}
//------------------------------------------------------------------------------- 
