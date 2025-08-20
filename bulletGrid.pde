//------------------------------------------------------------------------------- 
class BulletGrid
{
  float x;
  float y;
  float diametro;
  float count;
  Cell cells[][] = new Cell[10][15];
  
  boolean onOff;
  
//------------------------------------------------------------------------------- 
  BulletGrid(float x, float y, float r)
  {
    this.x = x;
    this.y = y;
    this.diametro = r*2;
    this.onOff = false;
    
    float yLinePar = (sin( radians(30) ));
    float xLinePar = (cos( radians(30) )) - r ;
    float yLine = 0;
    float xLine = 0;
  
          for(int j = 0; j < cells[0].length; j++)
          {
          for(int i = j%2; i < cells.length; i++)
          {
             xLine = this.x + i * this.diametro + (j%2 == 0 ? 0 : xLinePar);
             yLine = this.y + j * this.diametro*0.9 + (j%2 == 0 ? 0 : yLinePar);
                   
                  cells[i][j] = new Cell( xLine, yLine, this.diametro/2);           
          }
          }
  }
  
//------------------------------------------------------------------------------- 
 void checkCell(Bullet bullet) 
 {
      int linha = 0;
      int columna = 0;
      float lessDistance = 100;
      float distance;
  
  if(bullet.velocityX == 0 && bullet.velocityY == 0 && bullet.y < cannon.y)
  {
      for (int j = 0; j < cells[0].length; j++) 
      {
      for (int i = j % 2; i < cells.length; i++) 
      {
            if(cells[i][j].x - this.diametro*1.4 < bullet.x && cells[i][j].x + this.diametro*1.4 > bullet.x &&
            cells[i][j].y - this.diametro*1.4  < bullet.y && cells[i][j].y + this.diametro*1.4 > bullet.y) 
            {
                distance = dist(cells[i][j].x, cells[i][j].y, bullet.x, bullet.y);
                if(distance < lessDistance && cells[i][j].empty) 
                {
                  lessDistance = distance;
                  linha = i;
                  columna = j;
                
                }
            }
      }
      }
  }
    
    if (cells[linha][columna].empty && lessDistance < bullet.r*1.4 && bullet.boom == false) 
    {
      
      bullet.x = cells[linha][columna].x;
      bullet.y = cells[linha][columna].y;
      cells[linha][columna].b = bullet;
      cells[linha][columna].empty = false;
    }
  
  }

//------------------------------------------------------------------------------- 
  ArrayList<Cell>findNeighbourdCell(Cell centerCell)
  {
      ArrayList<Cell> referenceCell = new ArrayList<Cell>();
  
        for (int j = 0; j < cells[0].length; j++) 
        {
        for (int i = j%2; i < cells.length; i++) 
        { //<>//
            if(!cells[i][j].empty)
            {
                if(cells[i][j].x - this.diametro*1.1 < centerCell.x && cells[i][j].x + this.diametro*1.1 > centerCell.x &&
                cells[i][j].y - this.diametro*1.130 < centerCell.y && cells[i][j].y + this.diametro*1.130 > centerCell.y ) 
                {
                    referenceCell.add(cells[i][j]);
                }
            }
        }
        }
    
    return referenceCell;
  }

//------------------------------------------------------------------------------- 
 ArrayList<Cell> checkCellWithTheSameColor(Bullet b) 
 {
    Cell c;
    ArrayList<Cell> open = new ArrayList<Cell>();
    ArrayList<Cell> closed = new ArrayList<Cell>();
    ArrayList<Cell> neighbours;

    open.add(new Cell(b.x, b.y, b.r));
    open.get(0).b = b;
    
      while (open.size() > 0) 
      {
          c = open.remove(0);
          closed.add(c);

          neighbours = findNeighbourdCell(c);
          for (Cell c2 : neighbours)
          {
                if (!closed.contains(c2) && !open.contains(c2) && c2.b.c == b.c && !c2.b.boom) 
                    {
                      open.add(c2);
                    }
          }
      }

    return closed;
  }

//------------------------------------------------------------------------------- 
  void markConnectedCells()
  {
      ArrayList<Cell> open = new ArrayList<>();
      ArrayList<Cell> neighbours;
      Cell currentCell;
   
      for (int i = 0; i < cells.length; i++) 
      {
          if (!cells[i][0].empty) 
          {
              cells[i][0].connected = true;
              open.add(cells[i][0]);
          }
      }
    
      while (open.size() > 0) 
      {
        currentCell = open.remove(open.size() - 1);
  
        neighbours = findNeighbourdCell(currentCell);
        for (Cell neighbour : neighbours) 
         {
            if (!neighbour.empty && !open.contains(neighbour) && !neighbour.connected) 
               {  
                  open.add(neighbour);
                  neighbour.connected = true;
               }
          }
       }
       
  }
  
//------------------------------------------------------------------------------- 
  void checkConnectedCell()
  {
     markConnectedCells();
     ArrayList<Cell> neighbours;
     
      for (int j = 0; j < cells[0].length; j++) 
      {
      for (int i = j%2; i < cells.length; i++) 
      {
          if(!cells[i][j].empty && !cells[i][j].connected)
          {
              neighbours = findNeighbourdCell(cells[i][j]);
              if(neighbours.size() == 1)
              {
                if(!cells[i][j].b.boom)gameScore += 10 * pow(2,neighbours.size()-1);
                cells[i][j].b.points = 10;
                cells[i][j].b.boom = true;
                
              }
          }
      }
      }
     
  }

//------------------------------------------------------------------------------- 
  void checkBoom(Bullet b)
  {
    ArrayList<Cell> kBoomBullets = new ArrayList<Cell>();
    kBoomBullets = checkCellWithTheSameColor(b);
 
     if( kBoomBullets.size() >= 5)
     {
        for(Cell BulletBoom : kBoomBullets)
          {
             points.play();
             
            if(!BulletBoom.b.boom) gameScore += 25 * pow(2, kBoomBullets.size()-5);
              BulletBoom.b.boom = true;
              BulletBoom.b.velocityX = random( -2.5 , 2.5 );
            
          }
        
     }
  
     checkConnectedCell();
     bulletGrid.resetStateOfCell();//-------------------------> if "BOOM!!" is true you need to reset the empty cell
  }
  
//------------------------------------------------------------------------------- 
  void resetStateOfCell()
  {
  
    float distance = 0;
    for(int j = 0; j <  cells[0].length; j++)
       {
    for(int i = j%2; i < cells.length; i++)
       {
          if( !cells[i][j].empty  && cells[i][j].b != null)
            {
                 distance = dist( cells[i][j].x , cells[i][j].y ,cells[i][j].b.x , cells[i][j].b.y );
                 if(distance > this.diametro*1.2)
                   {
                     cells[i][j].empty = true;
                     cells[i][j].b = null;
                   }
            }
       }
       }
  }
  
//------------------------------------------------------------------------------- 
void designPointsGrid()
{
  for(int j = 0; j <  cells[0].length; j++)
    {
  for(int i = j%2; i < cells.length; i++)
    {
      if(cells[i][j].b != null)
      {
            if(  cells[i][j].b.boom )
            {
              textAlign(CENTER, CENTER); 
              textSize(raio); 
              if(cells[i][j].b.points == 25)  {   fill(WHITE);   }
              else{     fill(BRED);     }
              text( "+"+cells[i][j].b.points,  cells[i][j].x ,  cells[i][j].y  );
          }
      }
    }
    }
}

//------------------------------------------------------------------------------- 
  void makeTheMap()
  {
    int[][] numbersForMap;
    int takeNumberForColor;
    int ColorIndex = 0;
   
    
    numbersForMap = ceiling.readTheFileToList();//-----------------------> read the file and changue the caracters to ArrayList integer
    ceiling.differentColorOfMap( numbersForMap );//------------------------> save the different numbers of file
    ColorIndex = (int)random( differentInteger.size() );

    bullet.clear();
    bullet.add(new Bullet(W_WIDTH/2-150,W_HEIGHT-50,raio, COLORS[ColorIndex], 0 ));
     for(int j = 0; j <  cells[0].length; j++)
      {
     for(int i = j%2; i < cells.length; i++)
      {
           if(numbersForMap[i][j] != 0)
             {
                takeNumberForColor = numbersForMap[i][j]-1 ;
                bullet.add(new Bullet( cells[i][j].x , cells[i][j].y ,raio, COLORS[takeNumberForColor]  , bullet.size()) );
                bullet.get(bullet.size()-1).hit = true;
               
      
             }
            cells[i][j].empty = true;
      }
      }
      
      ColorIndex = (int)random(differentInteger.size());
      bullet.add(new Bullet(W_WIDTH/2,W_HEIGHT-50,raio, COLORS[ColorIndex], bullet.size()-1 ));
     
  }

//------------------------------------------------------------------------------- 
  boolean checkCellsForGameOver()
  {
  
    for(int j = 0; j <  cells[0].length; j++)
    {   
    for(int i = j%2; i < cells.length; i++)
    {
          if(cells[i][j].y > ceiling.y+ceiling.altura/3.7 && !cells[i][j].empty)
             {
                return true;
             }
      }
      }
      return false;
  }
  
//-------------------------------------------------------------------------------  
  boolean checkCellsForWin()
  {
    boolean winTheGame = true;
    cannon.colorCell(cells);
      if(colorGrid.size() > 0) 
        {  
          return !winTheGame;  
        }
        else
        {
         return winTheGame;
        }     
  }

//------------------------------------------------------------------------------- 
  void update(float countDown)
  {
    
    for (int j = 0; j < cells[0].length; j++) 
      {
    for (int i = j % 2; i < cells.length; i++) 
      {
          if (countDown >= seconds) 
            {
              cells[i][j].y += raio*1.7;
            }
      }
      }
  }
//------------------------------------------------------------------------------- 
  void draw()
  {
       designPointsGrid();
        if(this.onOff)
          {
              for(int j = 0; j <  cells[0].length; j++)
              {   
              for(int i = j%2; i < cells.length; i++)
              {    
                 cells[i][j].draw(); 
              }
              }
          }
  }
}
