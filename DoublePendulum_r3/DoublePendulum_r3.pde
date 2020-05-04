// Yet another double pendulum model. 
// Author: Jeremy Madea
// 
// I watched Daniel Shiffman's video for research: https://youtu.be/uWzPe_S-RVE

float cx, cy; //center x and y offset. 
PGraphics g;
DblPendulum pendulum = new DblPendulum();

void setup() {
  size(900, 720); 
  cx = width/2;
  cy = height/3;
  g = createGraphics(width, height);
  g.beginDraw();
  g.background(0);
  g.endDraw();
  //pendulum.setDrag(0.00005);
  //pendulum.setLengthB(175);
}

//boolean goingdown = true;
void draw() {
  background(0);
  imageMode(CORNER);
  image(g, 0, 0, width, height);
  
  translate(cx, cy);
  stroke(0,255,255);
  strokeWeight(2);
  fill(0,255,255);

  // Draw the pendulum itself. 
  line(0, 0, pendulum.xA, pendulum.yA);
  // Reasonable sihouette diameter = 2 * pow(V/(4/3π), 1/3.0) 
  float d = 2*pow(pendulum.massA/(4/3.0*PI),1/3.0);
  ellipse(pendulum.xA, pendulum.yA, d, d);
  // Reasonable sihouette diameter again.  
  d = 2*pow(pendulum.massB/(4/3.0*PI),1/3.0);
  line(pendulum.xA, pendulum.yA, pendulum.xB, pendulum.yB);
  ellipse(pendulum.xB, pendulum.yB, d, d);

  g.beginDraw();
  g.translate(cx, cy);
  g.stroke(0);
  
  if (pendulum.descending) { 
    g.stroke(200,0,0);
  } else { 
    g.stroke(0,200,0);
  }
  
  if (pendulum.zenith) { 
    g.ellipse(pendulum.x, pendulum.y, 10, 10); 
  }

  if (pendulum.valid_previous()) { 
    g.line(pendulum.px, pendulum.py, pendulum.x, pendulum.y);
  }

  g.endDraw();
  pendulum.update(); 
}

boolean paused = false;
void pause() { 
  paused = true; 
  noLoop();
}
void unpause() { 
  paused = false; 
  loop();
}

void keyPressed() {
 if (key == 'p') { 
   if (paused) { 
     unpause();
   } else { 
     pause();
   }
 } else if (key == 'r') {
   println("reset");
   pendulum.setThetaA(PI/2);
   pendulum.setThetaB(PI/2);
   pendulum.setOmegaA(0.0);
   pendulum.setOmegaB(0.0);
   pendulum.updates = 0;
 } else if (key == 'c') {
   println("clear");
   g.beginDraw();
   g.background(0);
   g.endDraw();
 } else if (key == '{') {
   pendulum.setLengthA(pendulum.lengthA + 1);
   println("Length A:" + pendulum.lengthA);
 } else if (key == '[') {
   pendulum.setLengthA(pendulum.lengthA - 1);   
   println("Length A:" + pendulum.lengthA);
 } else if (key == '}') {
   pendulum.setLengthB(pendulum.lengthB + 1);
   println("Length B:" + pendulum.lengthB);
 } else if (key == ']') {
   pendulum.setLengthB(pendulum.lengthB - 1);   
   println("Length B:" + pendulum.lengthB);
 } else if (key == '_') { 
   pendulum.setMassA(pendulum.massA + 1);
   println("Mass A:" + pendulum.massA);   
 } else if (key == '-') {
   pendulum.setMassA(pendulum.massA - 1);
   println("Mass A:" + pendulum.massA);   
 } else if (key == '+') {
   pendulum.setMassB(pendulum.massB + 1);
   println("Mass B:" + pendulum.massB);   
 } else if (key == '=') {
   pendulum.setMassB(pendulum.massB - 1);
   println("Mass B:" + pendulum.massB);   
 } else if (key == '?') {
   pendulum.setDrag(pendulum.drag + 0.0001);
   println("Drag: " + pendulum.drag);
 } else if (key == '/') {
   if (pendulum.drag >= 0.0001) { 
     pendulum.setDrag(pendulum.drag - 0.0001);
     println("Drag: " + pendulum.drag);
   }
 }
 
}
