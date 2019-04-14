Ball[] balls;
ColorShift cs;

void setup() {
  size(1920, 640);
  stroke(255);
  balls = new Ball[10];
  for(int i = 0; i < 10; i++) {
    balls[i] = new Ball(width / 2, height / 2);
  }
  cs = new ColorShift();
}

void draw() {
  background(0, 0);
  cs.tick();
  for(Ball b: balls) {
    for(Ball b2: balls) {
      line(b.getX(), b.getY(), b2.getX(), b2.getY());
    }
    b.tick();
    b.drawBall();
    
  }
  
}

public class ColorShift {
  private float r = 0;
  private float velR=.2;
  private float g = 0;
  private float velG = .4;
  private float b = .6;
  private float velB=3;
  public ColorShift() {
  }
  public void tick() {
    r+=velR;
    g+=velG;
    b+=velB;
    if(r>=255 || r<=0) {
      velR*=-1;
    }
    if(g>=255 || g<=0) {
      velG*=-1;
    }
    if(b>=255 || b<=0) {
      velB*=-1;
    }
    stroke(r,g,b);
    fill(r,g,b);
  }
  
}

public class Ball {
  private float x;
  private float locY;
  private float velX;
  private float velY;
  private float vel = .5;
  private int diam = 10;
  public Ball(float x, float locY) {
    this.x = x;
    this.locY = locY;
    velX = random(vel);
    velY = (float)Math.sqrt((double)(vel*vel)-Math.pow(velX,2));
    if(random(1) < .5) {
      velX*=-1;
    }
    if(random(1) < .5) {
      velY*=-1;
    }
  }
  public void tick() {
    if(x+velX > width || x+velX<0) {
      velX*=-1;
    }
    if(locY+velY > height || locY+velY<0) {
      velY*=-1;
    }
    x+=velX;
    locY+=velY;
  }
  public void drawBall() {
    //circle(x,locY,diam);
    ellipse(x, locY, diam, diam);
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return locY;
  }
}