import com.hamoid.*;

VideoExport ve;

ArrayList<Flake> flakes;
int maxFlakes = 400;
float maxSize = 20;


void setup() {
  size(1920, 410);
  background(0, 0, 150);
  flakes = new ArrayList<Flake>();
  ve = new VideoExport(this, "fallingsnowSquare.mp4");
  ve.startMovie();
}


void draw() {
  background(0, 0, 150);
  
  if(flakes.size() < maxFlakes) {
    println("adding flake");
    Flake f = new Flake(random(width), 0, random(2, maxSize)); 
    flakes.add(f);
  }
  
  for(int i = flakes.size()-1; i >=0; i--) {
    Flake f = flakes.get(i);  
    f.update();
    f.display();
    if(f.loc.y > height) {
      flakes.remove(i);
    }
  }
  ve.saveFrame();
  
}


void keyPressed() {
  if(key == 'q') {
    ve.endMovie();
    exit();
  }
}