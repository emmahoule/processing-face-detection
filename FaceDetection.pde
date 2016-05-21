import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*; 


OpenCV opencv;
Rectangle[] faces;
Capture cam; 
//instantiation des images
PImage img;  
PImage img2;  
PImage img3;
//instantiation de l'image utilisée de base
PImage currentImage;

void setup() {
  size(640, 480);
  //initilisation de l'objet capture
  cam = new Capture(this, width, height);
  //initilisation d'opencv  
  opencv = new OpenCV(this, cam.width, cam.height);
  
  //nouvelles instances de PImage en chargeant des images depuis le répertoire data
  img = loadImage("couronne.png");
  img2 = loadImage("chapeau.png");
  img3 = loadImage("lapin.png");
  img.resize(100, 100); 
  img2.resize(100, 100); 
  img3.resize(100, 100); 
  currentImage = img;
  cam.start();
  //detection du visage (frontal_face)
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void captureEvent(Capture cam){ 
  //lecture de l'image depuis la caméra
  cam.read();
} 


void draw() {
  image(cam, 0, 0); 
  opencv.loadImage(cam);
  
  //détection du visage
  faces = opencv.detect();
  
  //calcul du positionnement de l'image au dessus du visage détectée
  for (int i = 0; i < faces.length; i++) {
    image(currentImage, faces[i].x,faces[i].y-(faces[i].height), faces[i].width, faces[i].height);  
  }
  //dessine les images à l'écran aux coordonnées précisées
  image(img,0, 0); 
  image(img2,0, 100); 
  image(img3,0, 200); 
}

//au clic sur un élément
void mousePressed() {
  //en fonction des coordonnées du clic de la souris (mouseX et mouseY), on affiche une image différente
  if ((mouseX>0 && mouseX<img.width) && (mouseY>0 && mouseY<img.height)){
    currentImage = img;
  }
  else if ((mouseX>0 && mouseX<img.width) && (mouseY>img.height && mouseY<img.height*2)) {
    currentImage = img2;
  }
  else if ((mouseX>0 && mouseX<img.width) && (mouseY>img.height*2 && mouseY<img.height*3)) {
    currentImage = img3;
  }
}
