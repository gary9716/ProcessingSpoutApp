 //
//             SpoutReceiver
//
//       Receive from a Spout sender
//
//             spout.zeal.co
//
//       http://spout.zeal.co/download-spout/
//

// IMPORT THE SPOUT LIBRARY
import spout.*;

PImage img; // Image to receive a texture
String senderName = "UnitySender1";

// DECLARE A SPOUT OBJECT
Spout spout;
int screenNumber = 2; //the order of the screen you want to project
int overlappingLen = 210;
int startX = 0;
int cropWidth = 0;
int cropHeight = 0;

int originalImgWidth = 15390;
int originalImgHeight = 1200;

void setup() {
  
  // Initial window size
  //size(1920, 1200, P2D); 
  
  fullScreen(P2D, screenNumber); //if in fullscreen mode, need to make sure that resolution is 1920 * 1200
  println("screen resolution(w,h):(" + width + "," + height + ")");
  
  // Needed for resizing the window to the sender size
  // Processing 3+ only
  surface.setResizable(true);
   
  img = createImage(originalImgWidth, originalImgHeight, ARGB);
  
  // Graphics and image objects can be created
  // at any size, but their dimensions are changed
  // to match the sender that the receiver connects to.
  
  
  String[] parameters = loadStrings("parameters.txt");
  if(parameters != null && parameters.length == 2) {
    senderName = parameters[0];
    screenNumber = Integer.valueOf(parameters[1]);
  }
  else {
    println("number of parameters is wrong");
    exit();
  }
  // CREATE A NEW SPOUT OBJECT
  try {
    spout = new Spout(this);
    spout.createReceiver(senderName);
  
  }
  catch(Exception e) {
    println("we got some error:" + e.toString());
    exit();
  }
  
  cropWidth = width;
  cropHeight = height;
  
  startX = (screenNumber - 1) * (width -  overlappingLen);
  if(startX < 0)
    startX = 0;
  else if(startX + cropWidth > originalImgWidth) 
    startX = originalImgWidth - cropWidth;

  // OPTION : CREATE A NAMED SPOUT RECEIVER
  //
  // By default, the active sender will be detected
  // when receiveTexture is called. But you can specify
  // the name of the sender to initially connect to.
  // spout.createReceiver("Spout DX11 Sender");
 
} 

void draw() {
  
    background(0);
  
    //
    // RECEIVE A SHARED TEXTURE
    //
    
    // Crop the image
     img = spout.receivePixels(img);
     
     
     //image(img.get(startX,startY,cropWidth,cropHeight), 0, 0, width, height);

     image(img.get(startX, 0, cropWidth, cropHeight), 0, 0, width, height);

    // Optionally resize the window to match the sender
    //spout.resizeFrame();
    
}