class Branch {
  PVector loc;
  PVector nextLoc;
  PVector growthVec;
  float initLen;
  float len;
  ArrayList<Branch> branches;
  float thickness;
  Branch(PVector start, PVector growthVec, float len,float thickness) {
    this.loc = start.copy();
    this.nextLoc = start.copy();
    this.growthVec = growthVec.copy();
    this.len = len;
    this.initLen = len;
    this.branches = new ArrayList<Branch>();
    this.thickness = thickness;
  }
  
  void update() {
    for(int i = 0;i < this.branches.size(); i++ ){
      Branch b = this.branches.get(i);
      b.update();
      if(b.initLen > 5 && random(10) > 9.6) {
        println("branching");
        b.addBranch();
      }
    }
    nextLoc = PVector.add(loc, growthVec);
    //nextLoc = PVector.add(loc, PVector.fromAngle(growthVec.heading() + random(-1, 1)).mult(growthVec.mag())); 
    len -= growthVec.mag();
  }
  
  void display() {
    
    for(int i = this.branches.size()-1;i >= 0; i--){
      Branch b = this.branches.get(i);
      b.display();
      if(b.len < 0) {
        this.branches.remove(i);
      }
    }
    //strokeWeight(1);
    
    strokeWeight(thickness);
    //point(loc.x, loc.y);
    line(loc.x, loc.y, nextLoc.x, nextLoc.y);
    loc = nextLoc.copy();
  }
  
  void addBranch() {
    Branch b1, b2;
    float speed = random(3, 6);
    float angleOffset = random(0, PI/2);
    float newLen = random(len/4, len/2);
    b1 = new Branch(loc, PVector.fromAngle(growthVec.heading() + angleOffset).mult(speed), newLen, this.thickness*.5 );
    b2 = new Branch(loc, PVector.fromAngle(growthVec.heading() - angleOffset).mult(speed), newLen, this.thickness*.5 );
    this.branches.add(b1);
    this.branches.add(b2);
  }
}