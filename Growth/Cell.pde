
class Cell {
  PVector push = new PVector(0, 0);
  PVector pos = new PVector();
  PVector vel = new PVector(0, 0);
  float speed = 5;
  PVector acc = new PVector(0, 0);
  int prevMillis = 0;
  color clr = 0;
  float r; 
  float startR = r = 10;
  boolean mature = false;
  boolean alive = true; 
  boolean justAte = false; int lastMunchAt = 0;
  float splitSize = startR*2;

  Cell(float x, float y) {
    this.pos.x = x; 
    this.pos.y = y;
  }

  void show() {
    pushMatrix();
    stroke(0);
    if (!mature)fill(this.clr, 100, 100);
    else if (mature)fill(this.clr, 50, 50);
    ellipse(this.pos.x, this.pos.y, this.r*2, this.r*2);
    popMatrix();
  }

  void eat(Food food) {
    for (Food.Particle ptl : food.particles) {
      if (this.pos.dist(ptl.pos)<=this.r+5) {
        this.clr++;
        if (this.clr>100) this.clr=0;
        food.setEaten(ptl);
        this.r+=ptl.amount;
      }
    }
  }
  void setEaten() {
    this.alive = false;
  }

  void munch() {
    if (!this.justAte) {
      for (Cell victim : cells) {
        if (this.pos.dist(victim.pos)<=(this.r+victim.r)/4 && this.r>victim.r) {
          victim.setEaten();
          this.r+=victim.r/2;
          this.justAte = true;
          this.lastMunchAt = millis();
        }
      }
    }
  }

  Cell split() {
    this.r /= 2;
    this.mature = false;
    this.pos.x -= this.r;
    Cell newCell = new Cell(this.pos.x+this.r, this.pos.y);
    return newCell;
  }

  void collision(Cell other) {
    PVector dir = PVector.fromAngle(PVector.angleBetween(this.pos, other.pos));
    if (this.pos.dist(other.pos)<=2*r) {
      other.pos.add(dir);
      this.pos.add(dir.mult(-1));
      this.vel.set(0, 0);
      this.acc.set(0, 0);
    }
  }

  void update() {  
    if(this.justAte && millis()-this.lastMunchAt>=1000)this.justAte = false;
    if (this.r>=startR+splitSize/4) this.mature = true;
    if (millis()-this.prevMillis >= 1000 && this.vel.mag() <= speed) {
      this.push = new PVector(0, 0);
      this.push = PVector.random2D().mult(speed);
      this.acc.add(this.push);
      this.prevMillis = millis();
    }
    this.vel.add(this.acc);

    this.vel.mult(drag);
    //this.vel.x *= 0.1;
    //this.vel.y *= 0.1;

    this.pos.add(this.vel);

    // border-control
    if (this.pos.y+this.r>height) { 
      this.pos.y = height-this.r; 
      this.vel.y = this.acc.y = 0;
    }
    if (this.pos.y-this.r<0) { 
      this.pos.y = this.r;        
      this.vel.y = this.acc.y = 0;
    }
    if (this.pos.x+this.r>width) { 
      this.pos.x = width-this.r;  
      this.vel.x = this.acc.x = 0;
    }
    if (this.pos.x-this.r<0) { 
      this.pos.x = this.r;        
      this.vel.x = this.acc.x = 0;
    }

    /*
    fill(0);
     text(millis(), 10,100);
     text(push.x+" "+push.y, 100,70);
     text(this.acc.x+" "+this.acc.y, 100,80);
     text(this.vel.x+"  "+this.vel.y, mouseX, mouseY);
     text(this.vel.mag(), mouseX, mouseY+10);
     */
  }
}