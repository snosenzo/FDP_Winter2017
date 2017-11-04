ArrayList<Flake> flakes;
int maxFlakes = 400;
float maxSize = 20;
void setup() {
  size(1440, 1080);
  background(0, 0, 150);
  flakes = new ArrayList<Flake>();
  
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
  
  
}