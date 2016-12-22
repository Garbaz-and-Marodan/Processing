ArrayList<Cell> tree;
int amount;

void setup() {
  amount = 0;

  size(400, 400, P2D);
  tree = new ArrayList<Cell>();
  tree.add(new Cell(width/2, height));
  for (int i=0; i<amount; i++) tree.add(tree.get(i).growCell());
}



void draw() {
  background(255);
  for (Cell cell : tree) cell.show();
  stroke(0);

  if (mousePressed) tree.add(tree.get(tree.size()-1).growCell());
}