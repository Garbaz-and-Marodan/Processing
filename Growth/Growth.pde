ArrayList<Cell> cells = new ArrayList();
Food food;
float gravity = 1;
float drag = 0.2;
boolean spawnFlag = true;

void setup() {
  size(400, 400, P2D);
  colorMode(HSB, 100);
  //fullScreen();
  cells.add(new Cell(width/2, height/4));
  food = new Food (2000);
}



void draw() {  
  pushMatrix();
  strokeWeight(1);
  background(0, 0, 100);

  for (int i=0; i<cells.size(); i++) {
    if (cells.get(i).r >= cells.get(i).splitSize ) cells.add(cells.get(i).split());
    if (cells.get(i).alive) {
      cells.get(i).eat(food);
      cells.get(i).munch();
      cells.get(i).update();
      cells.get(i).show();
    } else if (!cells.get(i).alive) cells.remove(i);
  }
  food.show();
  food.update();


  food.sprinkle();

  if (mousePressed && spawnFlag) {
    cells.add(new Cell(mouseX, mouseY));
    spawnFlag = false;
  }
  else if(!mousePressed && !spawnFlag) spawnFlag = true;

  popMatrix();
}