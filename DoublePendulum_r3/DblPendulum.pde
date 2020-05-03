
class DblPendulum {
  float xA, yA, xB, yB;
  float x, y; // duplicates of xB and yB. 
  float lengthA = 150;
  float lengthB = 150;
  float massA = 1000; 
  float massB = 40; 
  float thetaA = PI/2; 
  float thetaB = PI/2; 
  float omegaA = 0; // angular velocity
  float omegaB = 0; // angular velocity
  float alphaA, alphaB; // angular acceleration variables
  float gravity = 1;
  float drag = 0; 
 
  //boolean valid_previous = false;
  float pxA, pyA, pxB, pyB, px, py; // px and py are duplicates of pxB and pyB. 
  int updates = 0;
  boolean descending = true;
  boolean nadir = false; 
  boolean zenith = false; 
   
  void update() { 
    nadir = false;
    zenith = false; 
    
    pxA = xA; 
    pyA = yA;
    pxB = xB;
    pyB = yB;
    px = pxB;
    py = pyB; 
    
    xA = lengthA * sin(thetaA);
    yA = lengthA * cos(thetaA);
    xB = xA + lengthB * sin(thetaB);
    yB = yA + lengthB * cos(thetaB);
    x=xB;
    y=yB;
    
    if (updates > 0) { 
      if (descending) { 
        if (pyB >= yB) {
          nadir = true; 
          descending = false;
        }
      } else {
        if (pyB <= yB) {
          zenith = true; 
          descending = true;
        }
      }
    }
    
    
    /* It's just math, folks. Not mine. 
     * See: https://www.myphysicslab.com/pendulum/double-pendulum-en.html
     */
    alphaA = ((-gravity*(2*massA+massB)*sin(thetaA)) + 
              (-massB*gravity*sin(thetaA-2*thetaB)) + 
              (-2*sin(thetaA-thetaB)*massB) * 
                (omegaB*omegaB*lengthB + omegaA*omegaA*lengthA*cos(thetaA-thetaB))) /
              (lengthA * (2*massA + massB - massB*cos(2*thetaA-2*thetaB)));
              
    alphaB = ((2*sin(thetaA-thetaB)) * 
              ((omegaA*omegaA*lengthA*(massA+massB))+
               (gravity*(massA+massB)*cos(thetaA))+
               (omegaB*omegaB*lengthB*massB*cos(thetaA-thetaB)))) / 
             (lengthA * (2*massA + massB - massB * cos(2*thetaA-2*thetaB)));   
             
    omegaA += alphaA;
    omegaB += alphaB;
    thetaA += omegaA;
    thetaB += omegaB;
    omegaA *= (1 - drag); 
    omegaB *= (1 - drag);
    updates += 1;
  }
  
  boolean valid_previous() {
    return updates >= 2;
  }
 
  void setGravity(float g) { gravity = g; }
  void setMassA(float m) { massA = m; }
  void setMassB(float m) { massB = m; }
  void setLengthA(float a) { lengthA = a; }
  void setLengthB(float b) { lengthB = b; }
  void setThetaA(float r) { thetaA = r; }
  void setThetaB(float r) { thetaB = r; }
  void setOmegaA(float v) { omegaA = v; }
  void setOmegaB(float v) { omegaB = v; }
  void setDrag(float d) { drag = d; }

}
