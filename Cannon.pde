//------------------------------------------------------------------------------- 
class Cannon
{
  float x;
  float y;
  float angle;
  float size;
  color c;
  
//------------------------------------------------------------------------------- 
  Cannon(float x, float y, float angle, float size,color c)
  {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.size = size;
    this.c = c;
  }

//------------------------------------------------------------------------------- 

void colorCell(Cell cells[][])
{
      colorGrid.clear();
       for(int j = 0; j <  cells[0].length; j++)
       {
       for(int i = j%2; i < cells.length; i++)
       {
         
          if(  !cells[i][j].empty  )    
            {
                if( !colorGrid.contains( cells[i][j].b.c  ) )
                  {
                    colorGrid.add(  new Color(cells[i][j].b.c)  );
                  }
            }
        
       }
       }
}

//------------------------------------------------------------------------------- 
void shootBullet() 
{
  if(  !bulletGrid.checkCellsForGameOver()  )
  {
    colorCell(bulletGrid.cells); //-------------------------------------------------------> only use the color than had in the map
    int colorIndex = (int)random(colorGrid.size()-1);
    
    long WaitingTime = millis();
    if (WaitingTime - shootTime > 500 ) 
    {  
      shoot.play();
      
      bullet.get( bullet.size()-1 ).shoot(cannon.angle);//-----------------------------------------------------------> shoot the ball
        bullet.add(new Bullet(W_WIDTH/2,W_HEIGHT-50,raio, bullet.get(0).c, bullet.size()) ); //------------------------> copy color [0] 
        bullet.get(0).c = colorGrid.get(  colorIndex  ).value;//-------------------------------------------------------> change color Index [0]
      shootTime = WaitingTime;
    }
   
  }
}

//------------------------------------------------------------------------------- 
void right()
{
  if(this.angle < radians(150))
  {
    this.angle += radians(CannonVelocity);
  }
}

//------------------------------------------------------------------------------- 
void left()
{
  if(this.angle > radians(30))
  {
     this.angle -= radians(CannonVelocity);
  }
}

//------------------------------------------------------------------------------- 
  void draw()
  {
    pushMatrix();
    translate(this.x, this.y);
    rotate(this.angle);
    fill(GREY);
    stroke(lvl1);
    strokeWeight(3);
    rectMode(CENTER);
    rect(0,0,this.size,this.size/2,0,20,20,0);
    popMatrix();

    //pushMatrix();
    //translate(this.x,this.y);
    //rotate(this.angle);
    //imageMode(CENTER);
    //image(arrow,0,0,arrow.width/1.5, arrow.height/1.5);
    //popMatrix();
    
    
  }
}
