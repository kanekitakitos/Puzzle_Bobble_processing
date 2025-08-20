class Color 
{
  color value;
  
  Color(color c)
  {
    this.value = c;
  }

  boolean equals(Object o)
  {
    if(o == this) return true;
 
    if(!(o instanceof Color)) return false;
    
    Color c = (Color) o;
    
    return this.value == c.value;
  }
}
