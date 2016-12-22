
class Cell{
  PVector pos = new PVector();
  float r;
  
  Cell(float x, float y){
    this.pos.x = x; 
    this.pos.y = y;
    this.r = 10;
  }
  
  void show(){
    pushMatrix();
    stroke(0);
    fill(255);
    ellipse(this.pos.x, this.pos.y, this.r*2, this.r*2);
    popMatrix();
  }
  
  Cell growCell(){
    float x = random(this.pos.x-r, this.pos.x+r);
    float y = -sqrt(pow(2*r,2)-pow(x-this.pos.x,2))+this.pos.y;
    
    Cell newCell = new Cell(x,y);    
    return newCell;
  }
  
}