//Sam Nosenzo
//12/3/16
//Final Project for Visual Thinking w/ Aaron Henderson
import com.hamoid.*;
import geomerative.*;
ArrayList<Mover> movs;
RFont font;
String[] saying = { "Merry Christmas", "Happy Kwanzaa", "Happy Holidays", "Happy Hanukkah", "Season's Greetings"};
String SampleText = "EVOLVE";
RPoint[] pts;
float xtext, ytext;

PVector crowdav;
PVector targav;
PVector initialav;
float initialdist = 0;
float moversize = 15;
int cycle = 0;
int textsize = 170;
int changeCounter = 0;
int resetCounter = 200;

float textSegmentLength = 20;


VideoExport ve;

void setup(){
  size(1440, 1080);
  //fullScreen();
  //background(223,37, 11);
  background(30);
  movs = new ArrayList<Mover>();
  createTextPoints();
  targav = new PVector();
  for(int i = 0; i < pts.length; i++){
    PVector targ = new PVector(width/2 + pts[i].x, height/2 + pts[i].y);
    targav.add(targ);
    Mover m = new Mover(width/2, 200, moversize, targ);
    movs.add(m);  
  }
  
  targav.x = targav.x / pts.length;
  targav.y = targav.y / pts.length;
  
  /*for(int i = 0; i < pts.length; i++){
    Mover m = new Mover(width/2, 200, moversize, new PVector(width/2 + pts[i].x, height/2 + pts[i].y));
    movs.add(m);  
  }*/
  xtext = width/2;
  ytext = height/2;
  
  crowdav = new PVector();
  initialav = new PVector(width/2, 200);
  initialdist = PVector.sub(targav, initialav).mag();
  
  ve = new VideoExport(this, "holidaytype.mp4");
  ve.startMovie();
}


void draw(){
  //background(223, 37, 11);
  noStroke();
  fill(70,1);
  rect(0, 0, width, height);
  
  fill(prim[cycle%prim.length], 40);
  //noFill();
  
  beginShape(POLYGON);
  float currcrowdx = 0;
  float currcrowdy = 0;
  
  for(int i = 0; i < movs.size() - 1; i++){
    Mover m1 = movs.get(i);
    Mover m2 = movs.get(i+1);
    currcrowdx+=m1.loc.x;
    currcrowdy+=m1.loc.y;
    m1.update();
    m1.display();
    /*if(i > 0){
      
    }*/
    vertex(m1.loc.x, m1.loc.y);
    if(dist(m1.loc.x, m1.loc.y, m2.loc.x, m2.loc.y) > textSegmentLength*1.3) {
      float d = PVector.sub(targav, crowdav).mag();
      float mapping = map(d, 0, initialdist, 255, 200);
      stroke(mapping, 100);
      endShape();
      beginShape();
    }
    if( i == movs.size() - 2) {
      currcrowdx+=m1.loc.x;
      currcrowdy+=m1.loc.y;
      m2.update();
      m2.display();
      vertex(m2.loc.x, m2.loc.y);
    }
  }
  
  //noStroke();
  strokeWeight(1);
  float d = PVector.sub(targav, crowdav).mag();
  float mapping = map(d, 0, initialdist, 255, 200);
  stroke(mapping, 100);
  //stroke(sec1[(cycle+3)%sec1.length]);
  //noStroke();
  endShape();
  
  currcrowdx = currcrowdx / movs.size();
  currcrowdy = currcrowdy / movs.size();
  crowdav.x = currcrowdx;
  crowdav.y = currcrowdy;
  /*
  fill(255, 0, 0);
  ellipse(crowdav.x, crowdav.y, 20, 20);
  fill(0, 255, 0);
  ellipse(targav.x, targav.y, 20, 20);
  
  pushMatrix();
  translate(xtext, ytext);
  for(int i = 0; i < pts.length; i++){
    //ellipse(pts[i].x, pts[i].y, 3, 3);  
  }
  popMatrix();*/
  if( d < 2.5){
    changeCounter++;
    if(changeCounter == resetCounter){
      createTextPoints();
      setTargets(width/2, random(textsize, height-textsize));
      changeCounter = 0;
      //saveFrame("evolve" + random(10, 20) + ".png");
    }
    if(changeCounter == resetCounter/2){
      
    }
  } else if (d < 400){
    if(random(1) < .03){
      //saveFrame("evolve" + random(10) + ".png");
    }
  }
    
  ve.saveFrame();
  
}

void createTextPoints(){
  RG.init(this);
  font = new RFont("Helvetica.ttf", textsize, RFont.CENTER);
  RCommand.setSegmentLength(textSegmentLength);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  
  if(saying[cycle%saying.length].length() > 0) {
    RGroup grp;
    grp = font.toGroup(saying[cycle%saying.length]);
    pts = grp.getPoints();
  }
  if(!movs.isEmpty()){
    ArrayList<Mover> temp = new ArrayList<Mover>();
    
    if(pts.length > movs.size()){
      for(int i = movs.size(); i < pts.length; i++){
        Mover m = new Mover(xtext, ytext, moversize, new PVector());
        movs.add(m);
      }
    } else if(pts.length < movs.size()){
      for(int i = movs.size()-1; i >= pts.length; i--){
        movs.remove(i);
      }
    }
  }
    //movs.clear();
  
  cycle++;
  
}

void setTargets(float x, float y){
  xtext = x;
  ytext = y;
  initialav = targav;
  targav = new PVector(0, 0);
  for(int i = 0; i < pts.length; i++){
    Mover m = movs.get(i);
    PVector targ = new PVector(x + pts[i].x, y + pts[i].y);
    targav.add(targ);
    m.setTarget(targ);
  }
  targav.x = targav.x / pts.length;
  targav.y = targav.y / pts.length;
}

void keyPressed(){
  if(key == 'c'){
    //if(cycle < 4){
      createTextPoints();
      setTargets(width/2, random(textsize/2, height+100));
    //}
    //else {
      //setTargets(random(textsize*2, width-textsize*2), random(textsize/2, height-textsize/2));
      //cycle++;
    //}
  }
  if(key == 'q') {
    ve.endMovie();
    exit();
  }
}