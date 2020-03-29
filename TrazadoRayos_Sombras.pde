int num = 100;
Wall[] walls = new Wall[num];

Light light;

void setup() {
  size(800, 600);

  light = new Light(new PVector(100, 100));

  int margins = 50;
  
  for (int i=0; i<num; i++) {
    PVector pos = new PVector(random(margins, width-margins), random(margins, height-margins));
    PVector nxt = PVector.add(PVector.mult(PVector.random2D(), 70), pos); //.mult(70); //.add(pos);
    
    walls[i] = new Wall(pos.x, pos.y, nxt.x, nxt.y);
  }
}

void draw() {
  background(250, 250, 150);

  light.setPos(mouseX, mouseY);

  light.scanWalls(walls);
  light.display(color(255, 255, 230));
  light.castShadow(color(130, 30, 30, 150));

  for (Wall wall : walls) {
    wall.display(color(250, 250, 150), 3);
  }
}


/* Wall class */
class Wall {
  PVector point0, point1;
  public Wall(float x0, float y0, float x1, float y1) {
    this.point0 = new PVector(x0, y0);
    this.point1 = new PVector(x1, y1);
  }
  void display(color col, int w) {
    strokeWeight(w);
    stroke(col);
    line(this.point0.x, this.point0.y, this.point1.x, this.point1.y);
  }
}

/* Light class*/
class Light {
  PVector pos;
  PVector[][] shadows;
  float maxDist;
  public Light(PVector pos) {
    this.pos = pos;
    this.shadows = new PVector[num][4];
    this.maxDist = sqrt(width*width + height*height);
  }

  void setPos(float x, float y) {
    this.pos.set(x, y);
  }
  void scanWalls(Wall[] walls) {
    for (int i=0; i<walls.length; i++) {
      this.shadows[i] = new PVector[4];

      PVector relPos0 = PVector.sub(walls[i].point0, this.pos);
      PVector relPos1 = PVector.sub(walls[i].point1, this.pos);

      this.shadows[i][0] = walls[i].point0;
      this.shadows[i][1] = walls[i].point1; 
      this.shadows[i][2] = PVector.add(PVector.mult(relPos1, this.maxDist),this.pos);
      this.shadows[i][3] = PVector.add(PVector.mult(relPos0, this.maxDist),this.pos);
    }
  }
  void display(color col) {
    noStroke();
    fill(col);
    ellipse(this.pos.x, this.pos.y, 20, 20);
  }
  void castShadow(color col) {
    fill(col);
    noStroke();
    for (int i=0; i<this.shadows.length; i++) {
      beginShape();
      for (int j=0; j<this.shadows[i].length; j++) {
        vertex(this.shadows[i][j].x, this.shadows[i][j].y);
      }
      endShape(CLOSE);
    }
  }
}
