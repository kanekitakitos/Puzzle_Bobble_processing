//------------------------------------------------------------------------------- 
class Bullet
{
  float x;
  float y;
  float velocityX;
  float velocityY;
  int index;
  
  float count;
  float r;
  color c;
  
  int points;
  boolean hit;
  boolean boom;

  
  
//------------------------------------------------------------------------------- 
  Bullet(float x, float y, float r,color c, int i)
  {
    this.x = x;
    this.y = y;
    this.r = r;
    this.c = c;
    this.points = 25;
    this.index = i;
    this.count = 0;
  
    this.velocityX = 0;
    this.velocityY = 0;
    
    this.boom = false;
    this.hit = false;
  }

//------------------------------------------------------------------------------- 
  void shoot(float angle)
  {
    this.velocityY = velocityBullet*sin(angle);
    this.velocityX = velocityBullet*cos(angle);
  }
  
//------------------------------------------------------------------------------- 
  void update(float countDown)
  { 
    this.y -= this.velocityY;
    this.x -= this.velocityX;
     if(this.hit && countDown >= seconds)
      {
        this.y += this.r*1.7;
      }
  }

//------------------------------------------------------------------------------- 
  void checkCollision(float x, float y)
  {
    if(boom == false)
    {
       if(this.x -this.r<= x || x + ceiling.largura <= this.r+this.x )
         {
            this.velocityX = -this.velocityX;
         }
       
       else if( y + this.r > this.y || this.hit )
         {
           this.velocityY = 0;
           this.velocityX = 0;
          
           this.hit = true;
         }
    }
    else
    {
      this.velocityY = -velocityBullet/1.7;
    }
       
  }
  
//------------------------------------------------------------------------------- 
  boolean collidesWith(Bullet other) 
  {
      float distance = dist(this.x,this.y,other.x,other.y);
      return distance < this.r*1.9;
  } 
  
//------------------------------------------------------------------------------- 
  void draw()
  { 
   
    strokeWeight(3);
    stroke(BLACK);
    fill(lerpColor(this.c, color(255), 0.3)); // add shadow
    fill(this.c);
    circle(this.x,this.y,r*2);
    noStroke();
    fill(255, 255, 255, 120);
    ellipse(this.x + r*0.3, this.y - r*0.3, r*0.4, r*0.4);// small white circle
  }
  
}
