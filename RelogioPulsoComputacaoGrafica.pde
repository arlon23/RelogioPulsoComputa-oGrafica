int Y_AXIS = 1;
color c1, c2;

PImage parteCima, parteBaixo;
int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

PShape borda;

void setup() {
  size(640, 600);
  
  parteCima = loadImage("cimaRelogio.png");
  parteBaixo = loadImage("parteBaixo.png");
  
  c2 = color(219, 181, 69);
  c1 = color(251, 221, 134);
  
  stroke(255);
  
  
  
  int radius = min(width, height) / 4;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;

  
  cx = 300;
  cy = 300;
  
  
}

void draw() {
  background(255);
  
  
  // Draw the clock background
  createGradient(cx, cy, min(width, height) / 4, 
      c1, 
      c2);
  image(parteCima, 167,27,265,200);
  image(parteBaixo, 175,387,250,200);

  fill(0,1);
  stroke(98,69,27);
  strokeWeight(11);
  ellipse(300,300, clockDiameter+23,clockDiameter+25);
  
  
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  
  
  
  // Draw the hands of the clock
  stroke(255,0,0);
  strokeWeight(2);
  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  stroke(0);
  strokeWeight(4);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  strokeWeight(6);
  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
  
  
  // Draw the minute ticks
  strokeWeight(3);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy + sin(angle) * secondsRadius;
    if(a==0){
      fill(0);
      text(3, x+5,y+5);
    }else if(a==30){
      fill(0);
      text(4, x+5,y+8);
    }else if(a==60){
      fill(0);
      text(5, x,y+13);
    }else if(a==90){
      fill(0);
      text(6, x-3,y+15);
    }else if(a==120){
      fill(0);
      text(7, x-5,y+13);
    }else if(a==150){
      fill(0);
      text(8, x-12,y+8);
    }else if(a==180){
      fill(0);
      text(9, x-13,y+5);
    }else if(a==210){
      fill(0);
      text(10, x-18,y+2);
    }else if(a==240){
      fill(0);
      text(11, x-11,y-5);
    }else if(a==270){
      fill(0);
      text(12, x-7,y-10);
    }else if(a==300){
      fill(0);
      text(1, x,y-3);
    }else if(a==330){
      fill(0);
      text(2, x+4,y+1);
    }
    vertex(x,y);
    
  }
  endShape();
  
  
}

void createGradient (float x, float y, float radius, color c1, color c2){
  float px = 0, py = 0, angle = 0;

  // calculate differences between color components 
  float deltaR = red(c2)-red(c1);
  float deltaG = green(c2)-green(c1);
  float deltaB = blue(c2)-blue(c1);
  // hack to ensure there are no holes in gradient
  // needs to be increased, as radius increases
  float gapFiller = 32.0;

  for (int i=0; i< radius; i++){
    for (float j=0; j<360; j+=1.0/gapFiller){
      px = x+cos(radians(angle))*i;
      py = y+sin(radians(angle))*i;
      angle+=1.0/gapFiller;
      color c = color(
      (red(c1)+(i)*(deltaR/radius)),
      (green(c1)+(i)*(deltaG/radius)),
      (blue(c1)+(i)*(deltaB/radius)) 
        );
      set(int(px), int(py), c);      
    }
  }
  // adds smooth edge 
  // hack anti-aliasing
  noFill();
  noStroke();
  ellipse(cx, cy, clockDiameter, clockDiameter);
}
