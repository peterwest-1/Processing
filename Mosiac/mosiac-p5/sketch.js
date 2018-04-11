
const scl = 16
const depth = 60

let w,h
let img, smaller

function preload() {
  // put setup code here
  img = loadImage("data/mona-687-1024.jpg", handleGotImage, handleErrorImage)
}

function setup() {
  // put setup code here
  createCanvas(672, 1024, WEBGL)

  w = img.width/scl;
  h = img.height/scl;

    smaller = createImage(w, h, RGB);
    smaller.copy(img, 0, 0, img.width, img.height, 0, 0, w, h);

}

function draw() {
  // put drawing code here
  background(42)


    translate(-width/2, -height/2, 0);
    colorMode(HSB);

    smaller.loadPixels();
    for (let x = 0; x < w; x++) {
      for (let y = 0; y < h; y++) {
        // Draw an image with equivalent brightness to source pixel

        let index = x + y * w;
        let col = smaller.pixels[index]
        let c = color(255,0,255)
        console.log(c)
        fill(c)
        noStroke()

        let out = map(brightness(col), 0, 255, depth, -depth)

        push()
        translate(x*scl, y*scl, out)
        box(scl, scl, depth)
        pop()
      }
    }
}

function handleGotImage(){
  console.log("Successfully got image");
}

function handleErrorImage(err){
  console.log("Error retrieving image");
  console.log(err);
}
