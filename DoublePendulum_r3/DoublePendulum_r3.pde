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
  pendulum.setDrag(0.0005);
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

  if (pendulum.valid_previous()) { 
    g.line(pendulum.px, pendulum.py, pendulum.x, pendulum.y);
  }

  g.endDraw();
  pendulum.update(); 
}
