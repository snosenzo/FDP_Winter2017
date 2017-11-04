int numTrunks = 6;
ArrayList<Branch> branches;
PVector screenCenter;
void setup() {
  size(1440, 1080);
  background(0, 0, 150);
  stroke(255);
  branches = new ArrayList<Branch>();
  screenCenter = new PVector(width/2, height/2);
  initTrunks();
}


void draw() {
  
  fill(0, 0, 150, 10);
  noStroke();
  //rect(0, 0, width, height);
  stroke(255);
  strokeCap(SQUARE);
  strokeWeight(1);
  boolean branch = false;
  branch = random(10) > 8 ? true : false;
  for(int i = 0; i < branches.size(); i++) {
    
    Branch b = branches.get(i);
    float strokeMapping = map(b.len, b.initLen, 0, 100, 0);
    stroke(255, strokeMapping);
    //float weightMapping = map(PVector.sub(b.loc, new PVector(0, 0)).mag(), 0, screenCenter.x, 6, 1);
    //strokeWeight(weightMapping);
    if(branch) {
      println("branch");
      b.addBranch();
    }
    b.update();
    b.display();
    if(i == branches.size() -1 && b.len < 0) {
      background(0, 0, 150);
      numTrunks = (int) random(4, 11);
      initTrunks();
    }
  } 
}


void initTrunks() {
  branches.clear();

  float randomOffset = random(-1, 1);
  float speed = random(.5, 1.5);
  
  for(int i = 0; i < numTrunks; i++) {
    PVector startLoc = new PVector(random(0, width), random(0, height));
    Branch b = new Branch(startLoc, PVector.sub(screenCenter, startLoc).normalize().mult(speed), random(500, 700));
    branches.add(b);
  }
}