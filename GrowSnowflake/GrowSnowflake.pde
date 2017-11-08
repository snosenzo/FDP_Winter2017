import com.hamoid.*;

int numTrunks = 2;
ArrayList<Branch> branches;
PVector screenCenter;

VideoExport ve;
void setup() {
  size(1440, 1080);
  background(0, 0, 150);
  stroke(255);
  branches = new ArrayList<Branch>();
  screenCenter = new PVector(width/2, height/2);
  initTrunks();
  ve = new VideoExport(this, "growingsnowflakes.mp4");
  ve.startMovie();
}


void draw() {
  
  fill(0, 0, 150, 10);
  noStroke();
  //rect(0, 0, width, height);
  stroke(255);
  strokeCap(PROJECT);
  strokeWeight(4);
  boolean branch = false;
  branch = random(10) > 8 ? true : false;
  for(int i = 0; i < branches.size(); i++) {
    
    Branch b = branches.get(i);
    float strokeMapping = map(b.len, b.initLen, 0, 255, 100);
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
      numTrunks = (int) random(1, 2);
      initTrunks();
    }
  } 
  ve.saveFrame();
}


void initTrunks() {
  branches.clear();

  float randomOffset = random(-1, 1);
  float speed = random(3, 8);
  
  for(int i = 0; i < numTrunks; i++) {
    PVector startLoc = new PVector(random(0, width), random(0, height));
    Branch b = new Branch(startLoc, PVector.sub(screenCenter, startLoc).normalize().mult(speed), random(1000, 1200), 18);
    branches.add(b);
  }
}

void keyPressed() {
  if(key == 'q') {
    ve.endMovie();
    exit();
  }
  
}