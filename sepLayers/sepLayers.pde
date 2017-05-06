// Ticha Sethapakdi, 2017

// don't hardcode value; find darkest pixel, check it's within some range of darkest pixel
float dark = 150;  
PImage img;
int h;
int w;

float darkestpix = 255;
float tolerance = 20;

PGraphics canvas;

void setup() { 
  surface.setVisible(false);
  //background(255);
  size(100, 100, P2D); 
  surface.setResizable(true);
  smooth(); 

  img = loadImage("1.jpeg");
  img.loadPixels();

  h = img.height;
  w = img.width; 

  // need to change size of canvas
  surface.setSize(w, h);

  canvas = createGraphics(w, h, P2D);
}

void draw() {
  canvas.beginDraw();
  getDarkestPixel();
  println(darkestpix); 

  darkestpix = max(150, darkestpix+tolerance); 

  // get lineart
  makeLayer(true);

  //fill(255);
  //rect(0, 0, width, height);
  canvas.clear();

  // get shading
  makeLayer(false);

  canvas.endDraw();
  exit();
}

void getDarkestPixel() {
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int loc = x + y*w;

      if (brightness(img.pixels[loc]) < darkestpix) {
        darkestpix = brightness(img.pixels[loc]);
      }
    }
  }
}

void makeLayer(boolean isLineart) { 
  //loadPixels();
  canvas.loadPixels();

  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int loc = x + y*w;

      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);

      if (isLineart) {
        if (brightness(img.pixels[loc]) < darkestpix) {
          //pixels[loc] =  color(r, g, b);
          canvas.pixels[loc] =  color(r, g, b);
        }
      } else {
        if (darkestpix <= brightness(img.pixels[loc]) && 
          brightness(img.pixels[loc]) <= 250) {
          //pixels[loc] =  color(r, g, b);
          canvas.pixels[loc] =  color(r, g, b);
        }
      }
    }
  }
  //updatePixels();
  canvas.updatePixels();

  image(canvas, 0, 0);

  if (isLineart) {
    //saveFrame("lines.png");
    canvas.save("lines.png");
  } else {
    //saveFrame("shades.png");
    canvas.save("shades.png");
  }
}