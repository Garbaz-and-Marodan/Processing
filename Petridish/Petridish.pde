Cell[] cells = new Cell[0];
Food food;
float gravity = 1;
float drag = 0.2;
boolean spawnFlag = true;
int foodStop = 0; int foodDelay = 100;
void setup() {  
  //size(400, 400, P2D);
  colorMode(HSB, 100);
  fullScreen();
  cells = increase(cells);
  cells[0]= new Cell(width/2, height/4);
  food = new Food (2000);
}



void draw() {  
  pushMatrix();
  strokeWeight(1);
  background(0, 0, 100);

  food.show();
  food.update();
  if(millis()-foodStop >= foodDelay){
    food.sprinkle(width/2,width/2,0,0);
    foodStop = millis();
  }
  for (int i=0; i<cells.length; i++) {
    if (cells[i].r >= cells[i].splitSize ){
      cells = increase(cells);
      cells[cells.length-1] = cells[i].split();
    }
    if (cells[i].alive) {
      cells[i].eat(food);
      cells[i].munch(i);
      cells[i].update();
      cells[i].show();
    } else if (!cells[i].alive) cells = takeOut(cells,i);
  }



  if (mousePressed && spawnFlag) {
    cells = increase(cells);
    cells[cells.length-1]= new Cell(mouseX, mouseY);
    spawnFlag = false;
  }
  else if(!mousePressed && !spawnFlag) spawnFlag = true;

  popMatrix();
  //println(cells.length);
}




Cell[] increase(Cell[] old){
  Cell[] new_ = new Cell[old.length+1];
  for(int i=0; i<old.length; i++){
    new_[i] = old[i];
  }
  return new_;
}
Cell[] takeOut(Cell[] old,int index){
  Cell[] new_ = new Cell[old.length-1];
  for(int i=0; i<index; i++) new_[i] = old[i];
  for(int i=index+1; i<old.length; i++) new_[i-1] = old[i];
  return new_;
}