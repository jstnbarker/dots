import processing.video.*;

Capture cam;
PImage photo;

void setup()
{
  size(1280,720);
  background(0);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[1]);
  printArray(cameras);
  cam.start();
  fill(255);
}

void captureEvent(Capture cam)
{
  cam.read();
}

void draw()
{
  background(0);
  int dotsize = 15;
  for (int i = 0; i < cam.height; i+=dotsize)
  {
    for (int j = 0; j < cam.width; j+=dotsize)
    { //<>//
      PImage temp = cam.get(j,i,dotsize,dotsize);
      temp.loadPixels();
      float sectionDarkness = 0;
      for(int k = 0; k < temp.pixels.length; k+=5)
      {
        color ctemp = temp.pixels[k];
        sectionDarkness += ((red(ctemp) + blue(ctemp) + green(ctemp))/3)*5;
      }
      sectionDarkness = sectionDarkness/temp.pixels.length;
      int ellipseSize = (int)((sectionDarkness/255)*dotsize); //<>//
      ellipse((j+0.5*dotsize),(i+0.5*dotsize),ellipseSize,ellipseSize);
    }
  }
 
}
