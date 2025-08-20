//------------------------------------------------------------------------------- 
class Cell
{
  float x;
  float y;
  float yReset;
  float r;
  
  Bullet b;
  boolean empty;
  boolean connected;
//------------------------------------------------------------------------------- 
  Cell(float x, float y, float r)
  {
    this.x = x;
    this.y = y;
    this.yReset = y;
    this.r = r;
    this.b = null;
    this.empty = true;
    this.connected = false;
  }
//------------------------------------------------------------------------------- 
void draw()
{
    noFill();
    if(this.empty == true)
      {
        stroke(BLACK);
      } 
      
    else
      {   
        stroke(WHITE);
      }
      
    strokeWeight(3);
    circle(this.x,this.y,this.r*2);
  }
}
