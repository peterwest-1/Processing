
import peasy.PeasyCam;

PeasyCam cam;

PImage img;
PImage smaller;

int scl = 8;
int w, h;
int depth = 80;

float ang = 0;

void setup() {
  size(600, 800, P3D);
  lights();
  smooth();

  cam = new PeasyCam(this, 1200);
  img = loadImage("albert-1262-1600.jpg");
  w = img.width/scl;
  h = img.height/scl;

  smaller = createImage(w, h, RGB);
  smaller.copy(img, 0, 0, img.width, img.height, 0, 0, w, h);
}

void draw() {

  background(20);
  colorMode(HSB, 255);
  translate(-width/2, -height/2, 0);

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
      box(scl, scl, depth);
      popMatrix();
    }
  }

}
