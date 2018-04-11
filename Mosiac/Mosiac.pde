
import peasy.PeasyCam;

PeasyCam cam;

PImage img;
PImage smaller;

int scl = 8;
int w, h;
int depth = 60;

void setup() {
  size(672, 1024, P3D);

  cam = new PeasyCam(this, 1200);
  img = loadImage("mona.jpg");
  w = img.width/scl;
  h = img.height/scl;

  smaller = createImage(w, h, RGB);
  smaller.copy(img, 0, 0, img.width, img.height, 0, 0, w, h);
}

void draw() {
  translate(-width/2, -height/2, 0);
  background(20);
  colorMode(HSB, 255);

  smaller.loadPixels();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      // Draw an image with equivalent brightness to source pixel

      int index = x + y * w;
      color c = smaller.pixels[index];
      fill(smaller.pixels[index]);
      noStroke();

      float push = map(brightness(c), 0, 255, depth, -depth);

      pushMatrix();
      translate(x*scl, y*scl, push);
      //rect(x*scl, y*scl, scl, scl);
      box(scl, scl, depth);
      popMatrix();
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      saveFrame();
    }
  }
}
