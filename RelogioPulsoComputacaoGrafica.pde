int Y_AXIS = 1, count = 0, countCor = 0;
color c1, c2, cBorda, cFundo;

PImage parteCima, parteBaixo, botao, botao2;
int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

int M = month(), D = day(), Y = year();
int Hr, Min, Sec; 
PFont dateAndTime;

PShape borda;

void setup() {
  size(640, 600);
  
  dateAndTime = createFont("Arial", 18);
  parteCima = loadImage("cimaRelogio.png");
  parteBaixo = loadImage("parteBaixo.png");
  botao = loadImage("botao.png");
  botao2 = loadImage("botao2.png");
  
  c2 = color(219, 181, 69);
  c1 = color(251, 221, 134);
  
  cBorda = color(98,69,27);
  cFundo = color(248,230,149);
  
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
  stroke(cBorda);
  strokeWeight(11);
  ellipse(300,300, clockDiameter+23,clockDiameter+25);
  
  
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  
  
  stroke(cBorda);
  fill(cFundo);
  strokeWeight(4);
  rect(265,373, 70,20);
  if(count % 2 == 0){
    relogioDigital();
  }else{
     dataRelogio();
  }
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
    
    strokeWeight(4);
    if(a==0){
      fill(0);
      strokeWeight(8);
      text(3, x+15,y+5);
      textAlign(CENTER);
    }else if(a==30){
      fill(0);
      strokeWeight(8);
      //text(4, x+5,y+8);
    }else if(a==60){
      fill(0);
      strokeWeight(8);
      //text(5, x,y+13);
    }else if(a==90){
      fill(0);
      strokeWeight(8);
      text(6, x,y+25);
    }else if(a==120){
      fill(0);
      strokeWeight(8);
      //text(7, x-5,y+13);
    }else if(a==150){
      fill(0);
      strokeWeight(8);
      //text(8, x-12,y+8);
    }else if(a==180){
      fill(0);
      strokeWeight(8);
      text(9, x-13,y+5);
    }else if(a==210){
      fill(0);
      strokeWeight(8);
      //text(10, x-18,y+2);
    }else if(a==240){
      fill(0);
      strokeWeight(8);
      //text(11, x-11,y-5);
    }else if(a==270){
      fill(0);
      strokeWeight(8);
      text(12, x,y-10);
      
    }else if(a==300){
      //strokeWeight(1);
      fill(0);
      strokeWeight(8);
      //text(1, x,y-3);
    }else if(a==330){
      fill(0);
      strokeWeight(8);
      //text(2, x+4,y+1);
    }
    vertex(x,y);
    
  }
  endShape();
  image(botao,422,200);
  image(botao2,144,200);
}

void mouseClicked(){
  
  if(mouseButton == LEFT && ( pmouseX >=420  && pmouseX <= (420+botao.width)) && ( pmouseY >=200  && pmouseY <= (200+botao.height))){
    count++;
  }
  
  if(mouseButton == LEFT && ( pmouseX >=144  && pmouseX <= (144+botao2.width)) && ( pmouseY >=200  && pmouseY <= (200+botao2.height))){
    countCor++;
    if(countCor%2==0){
      c2 = color(219, 181, 69);
      c1 = color(251, 221, 134);
      
      cBorda = color(98,69,27);
      cFundo = color(248,230,149);
    }else{
      c2 = color(79, 87, 91);
      c1 = color(255, 255, 255); 
      
      cBorda = color(0,0,0);
      cFundo = color(255, 255, 255); 
    }
    
  }
  
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

void dataRelogio() {
  String Ms = str(M);
  String Ds = str(D);
  String Ys = str(Y-2000);
  String MDY = Ds + "/" + Ms+ "/" + Ys;

  
  fill(0);
  textFont(dateAndTime, 16);
  text(MDY, 300, 390);
  
}

void relogioDigital(){
  Hr = hour();      //hour          
  Min = minute();   //minute
  Sec = second();   //second  
  
  String Hrs = str(Hr);
  String Mins = str(Min);
  if (Mins.length() < 2) {
    Mins = "0" + Mins;
  }
  String Secs = str(Sec);
  if (Secs.length() < 2) {
    Secs = "0" + Secs;
  }
  String HMS = Hrs + ":" + Mins + ":" + Secs;
  textFont(dateAndTime,16);
  fill(0);
  text(HMS, 300, 390);
  textAlign(CENTER);
  
}
