class Flake {
  float sz;
  PVector loc;
  float nx = random(2000);
  float theta = random(1000);
  Flake (float x, float y, float sz) {
    this.sz = sz;
    loc = new PVector(x, y);
  }
  
  
  void update() {
    loc.y += noise(nx)*sz/2;
    loc.x += .5*sin(theta);
    nx+=.001;
    theta += .05;
  }
  
  void display() {
    stroke(255);
    strokeWeight(sz);
    point(loc.x, loc.y);
  }
  
}