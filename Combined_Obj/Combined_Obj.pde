import ketai.camera.KetaiCamera;

Camera_Piece New_camera;
Display_String New_String;

boolean button_flag;


void setup() {  
  size(2560,1600);
  button_flag=true;
  New_String=new Display_String(button_flag);  
  New_camera=new Camera_Piece(this,button_flag);
}


void draw() {
  if (button_flag){
    New_String.Draw_Navigation();
  }
  else {
    New_camera.Draw_Camera();  
  }
}

void mousePressed(){
  if (button_flag){
   New_String.mousePressed();
   button_flag=New_String.super_button;
  }  
  else{
    New_camera.mousePressed();
    button_flag=New_camera.super_button;
  }
} 

void keyPressed(){
  if (button_flag){
    New_String.keyPressed();
  }
}





