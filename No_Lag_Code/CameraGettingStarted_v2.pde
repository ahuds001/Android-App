import ketai.camera.*;

KetaiCamera cam;

int time;
int photos;
PFont f;
int starting_height;
PImage bg;

void setup() {
  orientation(LANDSCAPE);
  width=2560;
  height=1600;
  size(2560,1600);
  starting_height=40;
  f = loadFont("Kokila-BoldItalic-72.vlw");
  imageMode(CENTER);
  cam = new KetaiCamera(this, 1280, 1024, 30);
  cam.setCameraID(1);
  cam.setSaveDirectory("//storage//sdcard");
  //Timer1.setup_timer();
  cam.start();
  bg = loadImage("bgimage2.png");
}

void draw() {
  background(bg);
  textFont(f);
  textAlign(CENTER);
  text("Welcome to\nOur Special Day",width/2,1.5*starting_height);
  text("Take Some Photos! \n Tap The Screen!",width/2,7*height/8);
  image(cam, width/2, height/2);

}
 
void exit()
{
  cam.stop();
}

void onCameraPreviewEvent()
{
  cam.read();
}

// start/stop camera preview by tapping the screen
void mousePressed()
{ 
  photos=1;
  time=millis()+1000;
  for(int i = 0 ; i < photos;) {
      //redraw();
      if( millis() > time ){
      time = millis() + 1000;
      i++;
      if (photos<4){
        photos++;
        }
      image(cam, width/8,(7*i-2.5)*height/32,width/7,3.5*height/16);
      cam.savePhoto();
      }
  } 
}


