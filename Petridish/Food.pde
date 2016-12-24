

class Food {
  ArrayList<Particle> particles = new ArrayList();
  int maxAmount;
  int atOnce = 1;

  Food(int max) {
    this.maxAmount = max;
  }

  void sprinkle(float x, float randX, float y, float randY) {
    if (particles.size()<=maxAmount)   for (int i=0; i<atOnce; i++) particles.add(new Particle(x+random(-randX,randX), y+random(-randY,randY) , 5));
  }

  void update() {
    for(int i=0;i<particles.size();i++) {
      if(particles.get(i).eaten) particles.remove(i--);
    }
  }

  void show() {
    for (Particle ptl : particles) {
      if (!ptl.eaten) {
        ptl.update();
        ptl.show();
      }
    }
  }

  void setEaten(Particle ptl) {
    ptl.eaten = true;
  }

  void removeParticle(Particle ptl) {
    int i = particles.indexOf(ptl);
    particles.remove(i);
  }


  class Particle {
    PVector pos;
    float amount;
    boolean eaten = false;
    color clr = color(random(255), random(255), random(255));
    Particle(float x, float y, float amount_) {
      this.pos = new PVector(x, y);
      this.amount = amount_;
    }
    void show() { 
      pushMatrix();
      stroke(clr);
      strokeWeight(width/100);
      point(this.pos.x, this.pos.y);
      popMatrix();
    }
    void update() {
      if (this.pos.y<=height)this.pos.y += gravity;
    }
    Particle newParticle() { 
      return new Particle(random(width), 0, 1);
    }
  }
}