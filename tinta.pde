int cx, cy;
int num = 6;
float test, w, a;
PVector[] inkArray = new PVector[num];
PVector prevPos = new PVector(0,0);
float[] maxSize = new float[num];
PImage backgroundImage;

void setup() {
  size(600, 600);
  background(255);
  cx = width/2;
  cy = height/2;
  for(int i=0; i<num; i++) {
    inkArray[i] = new PVector(random(-100, 100) + cx, 0);
    maxSize[i] = random(height);
  }
  backgroundImage = createImage(width, height, RGB);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      backgroundImage.pixels[i+j*width] = lerpColor(color(255), color(220), map(j, 0, width, 0, 1));
    }
  }
  image(backgroundImage, 0, 0);
}

void draw() {
  for(int i=0; i<num; i++) {
    prevPos.x = inkArray[i].x;
    prevPos.y = inkArray[i].y;
    inkArray[i].x += random(-0.5, 0.5);
    inkArray[i].y += random(3);
    w = abs(maxSize[i] / (inkArray[i].y + 25));
    a = map(inkArray[i].y, maxSize[i], 0, 0, 200);
    strokeWeight(w);
    stroke(0, a);
    if (inkArray[i].y < maxSize[i]) {
      line(prevPos.x, prevPos.y, inkArray[i].x, inkArray[i].y);
    } else {
      inkArray[i] = new PVector(random(-100, 100) + cx, 0); 
      maxSize[i] = random(height);
    }
  }
}
