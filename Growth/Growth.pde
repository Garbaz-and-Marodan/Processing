ArrayList<Cell> tree;
int amount;

void setup() {
  amount = 20;
  
  size(400, 400, P2D);
  tree = new ArrayList<Cell>();
  tree.add(new Cell(width/2, height));
  for(int i=0;i<50;i++){
    int random = round(random(1,2));
    for(int r=0;r<random;r++){
      tree.add(tree.get(i).growCell());
    }
  }
  
  print(tree.size());
}

void draw() {
  background(255);
  for(Cell cell : tree) cell.show();
  stroke(0);
}