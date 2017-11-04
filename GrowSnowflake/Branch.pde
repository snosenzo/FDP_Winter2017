class Branch {
  PVector startLoc;
  PVector loc;
  PVector nextLoc;
  PVector growthVec;
  float initLen;
  float len;
  ArrayList<Branch> branches;

  Branch(PVector start, PVector growthVec, float len) {
    this.startLoc = start.copy();
    this.loc = start.copy();
    this.nextLoc = start.copy();
    this.growthVec = growthVec.copy();
    this.len = len;
    this.initLen = len;
    this.branches = new ArrayList<Branch>();
  }

  void update() {
    for (int i = 0; i < this.branches.size(); i++ ) {
      Branch b = this.branches.get(i);
      b.update();
      if (b.initLen > 15 && random(10) > 9.9) {
        println("branching");
        b.addBranch();
      }
      if(b.len < 0) {
        this.branches.remove(b);
      }
    }
    nextLoc = PVector.add(loc, growthVec);
    len -= growthVec.mag();
  }

  void display() {
    for (int i = 0; i < this.branches.size(); i++) {
      Branch b = this.branches.get(i);
      b.display();
    }
    //strokeWeight(1);

    //point(loc.x, loc.y);
    line(loc.x, loc.y, nextLoc.x, nextLoc.y);
    loc = nextLoc.copy();
  }

  void addBranch() {
    Branch b1, b2;
    float speed = random(.5, 1.5);
    float angleOffset = random(0, PI/4);
    float newLen = random(initLen/5, initLen/10);
    b1 = new Branch(loc, PVector.fromAngle(growthVec.heading() + angleOffset).mult(speed), newLen );
    b2 = new Branch(loc, PVector.fromAngle(growthVec.heading() - angleOffset).mult(speed), newLen );
    this.branches.add(b1);
    this.branches.add(b2);
  }
}