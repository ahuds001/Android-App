//cam = new KetaiCamera(this, 1280, 1024, 30);
//import ketai.camera.*;


public class Camera_Piece
{

//FONT N BACKGROUND
PFont f;
PFont ff;
PFont fff;
PImage bg;

int starting_height;
int distance_gap;

//SWITCH_BUTTON  
int switch_distance_gap;
String switch_buttonLabel;
int switch_rectX, switch_rectY;
int switch_rectSize;
color switch_rectColor,switch_rectHighlight;
boolean switch_rectOver;


//CAMERA
KetaiCamera cam;
int time;
int photos;
boolean super_button;

Camera_Piece(PApplet PApplet1,boolean button_switch) {
  
  //CAMERA
  imageMode(CENTER);
  cam = new KetaiCamera(PApplet1, 1280,960,30);
  //cam = new KetaiCamera(PApplet1, 320, 240, 24);
  cam.setCameraID(1);
  //cam.setSaveDirectory("");
  cam.start();  
  //cam.autoSettings();
  
  super_button=button_switch;
  
  //BACKGROUND
  orientation(LANDSCAPE);
  width=2560;
  height=1600;
  size(2560,1600);
  bg = loadImage("NewBg.png");
  starting_height=40;
  distance_gap=96;
  
  f = loadFont("TimesNewRomanPS-BoldMT-55.vlw");
  ff = loadFont("TimesNewRomanPSMT-40.vlw");
  fff=loadFont("EdwardianScriptITC-80.vlw");
  
  //SWITCH_BUTTON  
  switch_distance_gap=96;
  switch_buttonLabel="Sign our\nGuestbook!";
  switch_rectColor = color(100);
  switch_rectHighlight = color(150);
  switch_rectSize = round(switch_distance_gap*3.5);
  switch_rectX = 13*width/16;
  switch_rectY = 5*height/8;
  //text(buttonLabel, rectX, rectY+distance_gap);
  switch_rectOver=false;
  
}

void onCameraPreviewEvent()
{
  cam.read();
}


void Draw_Camera() {
  textAlign(CENTER);
  textFont(fff);
  text("Tap the screen to take some photos!",width/2,starting_height+2.5*distance_gap);
  textFont(ff);
  text("When you tap the screen four photos will be taken (1 second delay). Use the props provided!",width/2,starting_height+3.5*distance_gap);
  textFont(f);
  switch_Button_Press();
  
  cam.read();
  image(cam, width/2, height/2+100);
}
 
void switch_Button_Press(){
    fill(255);
    rect(switch_rectX, switch_rectY, switch_rectSize, switch_rectSize/2,7);
    fill(50);
    text(switch_buttonLabel, switch_rectX+switch_rectSize/2, switch_rectY+switch_distance_gap/1.5);
}

void exit()
{
  cam.stop();
}

  
void Take_a_Picture(){
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
      cam.read();
      image(cam, width/8,(7*i-2.5)*height/32,width/7,3.5*height/16);
      cam.savePhoto("//storage/emulated/0/Pictures"+"/photo-"+str(hour())+str(minute())+str(second())+".jpg");
      }
  }  
}

// start/stop camera preview by tapping the screen
void mousePressed()
{ 
   if (mouseX > switch_rectX && mouseX < switch_rectX+switch_rectSize && mouseY > switch_rectY && mouseY < switch_rectY+switch_rectSize/2){
   super_button=true;
   background(bg);
   }
   else {
    Take_a_Picture(); 
    super_button=false;
   }
}
}


