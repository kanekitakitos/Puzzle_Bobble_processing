//------------------------------------------------------------------------------- 
class Ceiling
{
  float x;
  float y;
  float largura;
  float altura;
  float yMove;
  
  float count;
  boolean onOff;
  
//------------------------------------------------------------------------------- 
  Ceiling(float x, float y, float largura, float altura)
  {
    this.x = x;
    this.yMove = y ;
    this.y = y;
    this.altura = altura;
    this.largura = largura;
    
    this.onOff = false;
  }
  
//------------------------------------------------------------------------------- 
  void nextLevel(Cell cells[][])
  {

    this.yMove = this.y;
    for(int j = 0; j <  cells[0].length; j++)
      {   
    for(int i = j%2; i < cells.length; i++)
      {
             cells[i][j].y = cells[i][j].yReset; 
      }
      }
    
    bulletGrid.makeTheMap();
    this.count = 0;
    gameScore = 0;
    bulletGrid.count = 0;
  }

//------------------------------------------------------------------------------- 
  void loadTheLevels()
  {
     for (String filename : file) 
     {
          String level[] = loadStrings(filename);
          levels.add(level);
     }  
  }
//-------------------------------------------------------------------------------  
  void differentColorOfMap(int map[][])
{
     differentInteger.clear();
     for(int j = 0; j <  map[0].length; j++)
      {
     for(int i = j%2; i < map.length; i++)
      {
          if(map[i][j] != 0 && !differentInteger.contains(map[i][j]) )
          {
            differentInteger.add( map[i][j] );
          }    
      }
      }
}

//------------------------------------------------------------------------------- 
  int[][] readTheFileToList()
  {
    loadTheLevels();
    int[][] numbersForMap = new int[10][15];
    String[] level = levels.get( indexMap );
  
      for (int j = 0; j < level.length; j++) 
      {
      String[] buffer = level[j].split(" ");
        for (int i = 0; i < buffer.length; i++) 
         {
            numbersForMap[i][j] = Integer.parseInt(buffer[i]);
         }
      } 
    return numbersForMap;
  }
  
//------------------------------------------------------------------------------- 
 void loseTheGame()
 {
  
   if(bulletGrid.checkCellsForGameOver())
   {
      
      fill(colorWall[indexMap]);
      stroke(BLACK);
      rectMode(CENTER);
      rect(width/2,height/2+20,600,120,10,10,10,10);
                   
      textAlign(CENTER, CENTER); 
      textSize(70); 
      fill(WHITE);
      text("GAME OVER :(", width/2, height/2+20);

   }
 }
  
//-------------------------------------------------------------------------------  
 void winTheGame()
 {
   
   if(bulletGrid.checkCellsForWin())
        {
           fill(GREY);
           stroke(BLACK);
           rectMode(CENTER);
           rect(width/2,height/2+20,600,120,10,10,10,10);
                   
           textAlign(CENTER, CENTER); 
           textSize(70); 
           fill(WHITE);
   
             if(indexMap < 3 && timeOfWin >= 550) // 5,50 seconds
             {
                indexMap++;
                nextLevel(bulletGrid.cells);
                timeOfWin = 0;
             }
           else if( indexMap == 3) {    text("YOU WIN!!", width/2, height/2+20);    }
           else if(indexMap < 3)  {    text("NEXT LEVEL!!", width/2, height/2+20);  }
           timeOfWin++;
          
        }
        
 }
  
//------------------------------------------------------------------------------- 
  
  void update()
  {
    if(!bulletGrid.checkCellsForGameOver())
    {
      for(Bullet b1 : bullet)
         {
            b1.update(this.count);    
         }
         
      bulletGrid.update(this.count);
      
      if(this.count >= seconds && this.yMove < this.y + this.altura/1.3 )
        {
          this.yMove += raio*1.7;
          this.count = 0;
        }
      this.count++;
        
    }

  }

//------------------------------------------------------------------------------- 
  void draw()
  {
    strokeWeight(5);
    noFill();
    stroke(BLACK);
    rectMode(CENTER);
    rect(this.x,this.y,this.largura,this.altura);
    
     strokeWeight(5);
     stroke(colorWall[indexMap]);
     rectMode(CENTER);
     line(this.x-this.largura/2, this.y+this.altura/3-25,this.x+this.largura/2, this.y+this.altura/3-25);

    
   if(this.onOff)
   {  
      update();
      stroke(BLACK);
      fill(colorWall[indexMap]);
      rectMode(CENTER);
      rect(  this.x , this.yMove - this.altura/1.91 , this.largura  , raio + raio/4 );
   }
   
    

    
    
  }
}
