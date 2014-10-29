//Trying to turn display string into an object so that we can call the object with a simple draw and setup


class Display_String {
  
//FONTS
PFont f;
PFont ff;


StringBuilder sb;
StringBuilder saved_name;
StringBuilder saved_message;
PrintWriter output;
int Enter_Count;
int starting_height; 
int indent;
int shift_key;
int enter_key;
int backspace_key;
int tab_key;
float line_pos;

Table table;
String filename;
PImage bg;

//BUTTON
int distance_gap;
String buttonLabel;
int rectX, rectY;
int rectSize;
color rectColor,rectHighlight;

//SWITCH_BUTTON  
int switch_distance_gap;
String switch_buttonLabel;
int switch_rectX, switch_rectY;
int switch_rectSize;
color switch_rectColor,switch_rectHighlight;
boolean super_button;

Display_String(boolean button_switch){
  // Variable to store text currently being typed
  
  sb = new StringBuilder(512);

  // Variable to store saved text when return is hit
  saved_name = new StringBuilder(512);
  saved_message = new StringBuilder(512);

  // Counts Enters to plot data and save data accordingly
  Enter_Count=0;
  
  //f = createFont("Dialog",32);
  ff = loadFont("Kokila-Bold-48.vlw");
  f = loadFont("Kokila-BoldItalic-72.vlw");
  //output = createWriter("\\sdcard\\message.txt");
  
  table= new Table();
  table.addColumn("Id");
  table.addColumn("Name");
  table.addColumn("Message");
  filename="//storage/emulated/0/Files/messages.tsv";
  table=loadTable("//storage/emulated/0/Files/"+"messages.tsv","header");
  
  //fill(50);
  indent=25;
  starting_height=40;
  distance_gap=96;
  shift_key = 65535;
  enter_key = 66;
  backspace_key = 67;
  tab_key=9;

  width=2560;
  height=1600;
  size(2560,1600);
  bg = loadImage("NewBg.png");


  //BUTTON  
  buttonLabel=" Submit\nMessage";
  rectColor = color(100);
  rectHighlight = color(150);
  rectSize = round(distance_gap*3.5);
  rectX = width/2-rectSize/2;
  rectY = 6*height/8;
  
  super_button=button_switch;
  
  
   
  //SWITCH_BUTTON  
  switch_distance_gap=96;
  switch_buttonLabel=" Take a\n few Pics!";
  switch_rectColor = color(100);
  switch_rectHighlight = color(150);
  switch_rectSize = round(switch_distance_gap*3.5);
  switch_rectX = 13*width/16;
  switch_rectY = 5*height/8;
  

}

void Draw_Navigation(){
  background(bg);
  textFont(f);
  Button_Press();
  switch_Button_Press();
  textAlign(LEFT);
  text("Leave your name", indent, (starting_height+2*distance_gap));
  text("Leave a message!", indent, (starting_height+5*distance_gap)); 
      
  textFont(ff); 
  if (Enter_Count==0)
    {
      textAlign(LEFT);
      text(sb.toString(), indent, (starting_height+2.5*distance_gap), 1800, 300 );
      line(indent+textWidth(sb.toString()),starting_height+2.5*distance_gap-25,
           indent+textWidth(sb.toString()),starting_height+2.5*distance_gap+25);
      text(saved_message.toString(),indent,(starting_height+5.5*distance_gap),1800,600);
    }
    if (Enter_Count==1)
    {
      textAlign(LEFT);
      text(saved_name.toString(), indent, (starting_height+2.5*distance_gap), 1800, 300);
      text(sb.toString(), indent, (starting_height+5.5*distance_gap), 1800, 600 );
      line_pos=floor(textWidth(sb.toString())/1800);
      //println(textWidth(sb.toString()));
      //println(line_pos); 
      line(indent+textWidth(sb.toString())-line_pos*1790,starting_height+5.5*distance_gap-25+48*line_pos,
           indent+textWidth(sb.toString())-line_pos*1790,starting_height+5.5*distance_gap+25+48*line_pos);
    }
    if (Enter_Count==2)
    {
      //output.println(saved_name.toString()); //Write name to the file
      //output.println("\n");
      //output.println(saved_message.toString()); //Write message to the file
       
      TableRow newRow = table.addRow();
      newRow.setInt("Id", table.lastRowIndex());
      newRow.setString("Name", saved_name.toString());
      newRow.setString("Message", saved_message.toString());
      println(table.lastRowIndex()+","+saved_name.toString()+","+saved_message.toString());
      saveTable(table, filename);
      Enter_Count=0;
      sb = new StringBuilder(512);
      saved_name = new StringBuilder(512);
      saved_message = new StringBuilder(512);
    }
  }
  
//@ Override
void onStop() { //This should be called when the app closes
  saveTable(table, filename);
 // super.onStop();
}
 
//@ Override
void onDestroy() { //This might be called when the app is killed
  saveTable(table,filename);
  // super.onDestroy();
}


void keyPressed() 
{
  
// Tab Key is used to toggle between name and message.
  textFont(ff);
  if (int(key)==tab_key)
  {
    if (Enter_Count == 0)
    {
      saved_name = sb;
      sb = saved_message;
      Enter_Count=5;
    }
    if (Enter_Count == 1)
    {
      saved_message = sb;
      sb = saved_name;
      Enter_Count = 0;
    }
    // Used so that tab won't do =0 and =1 back to back
    if (Enter_Count==5)
    {
      Enter_Count=1;
    }
  }
  // You hit Enter twice you are done!
  
  if(Enter_Count==2)
  {
  }
  // If the return key is pressed, save the String and clear it
  
  if (keyCode == enter_key) 
  {
    if (Enter_Count == 0)
    {
      saved_name = sb;
      sb = saved_message;
    }
    if (Enter_Count == 1)
    {
      saved_message = sb;
      sb = saved_name;
    }
    Enter_Count+=1;
    // A String can be cleared by setting it to new 
  }
  else 
  {
    // Otherwise, delete or add value to string
    if (keyCode == backspace_key && sb.length() > 0) 
    {
      sb.deleteCharAt(sb.length()-1);
    }
    else if (int(key)!=shift_key && int(key)!=tab_key)
    {
      sb.append(key);
    }
  }
}

// BUTTON
  
   void Button_Press(){
    fill(255);
    rect(rectX, rectY, rectSize, rectSize/2,7);
    fill(50);
    textAlign(CENTER);
    text(buttonLabel, rectX+rectSize/2, rectY+distance_gap/1.5);
  }

  void switch_Button_Press(){
 
    fill(255);
    rect(switch_rectX, switch_rectY, switch_rectSize, switch_rectSize/2,7);
    fill(50);
    text(switch_buttonLabel, switch_rectX+switch_rectSize/2, switch_rectY+switch_distance_gap/1.5);
}
  
  void mousePressed() {
    if (mouseX > rectX && mouseX < rectX+rectSize && mouseY > rectY && mouseY < rectY+rectSize/2) {
      Enter_Count=2;
      super_button=true;
    }  
    else if (mouseX > switch_rectX && mouseX < switch_rectX+switch_rectSize && mouseY > switch_rectY && mouseY < switch_rectY+switch_rectSize/2){
      super_button=false;
      background(bg);
    }
  }

}





