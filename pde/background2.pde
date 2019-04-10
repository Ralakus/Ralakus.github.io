ArrayList<Chain> chains;
int[] dirs = new int[4];
void setup() {
  size(1920, 720);
  background(0, 0);
  chains = new ArrayList<Chain>();
  dirs[0] = -2;
  dirs[1] = -1;
  dirs[2] = 1;
  dirs[3] = 2;
}

void draw() {
  background(0, 0);
  if(frameCount%15==0) {
    chains.add(new Chain());
  }
  ArrayList<Chain> toKill = new ArrayList<Chain>();
  for(Chain c: chains) {
    c.drawSegment(toKill);
  }
  chains.removeAll(toKill);
}

public class Chain {
  private float r;
  private float g;
  private float b;
  private int x;
  private int y;
  private int dir;
  private int life = 500;
  ArrayList<Segment> segments = new ArrayList<Segment>();
  public Chain() {
    r = random(245) + 10;
    g = random(245) + 10;
    b = random(245) + 10;
    if(random(1) > .5) {
      if(random(1) > .5) {
        x = width;
        y = (int)random(height);
      } else {
        x = 0;
        y = (int)random(height);
      }
    } else {
      if(random(1) > .5) {
        y = height;
        x = (int)random(width);
      } else {
        y = 0;
        x = (int)random(width);
      }
    }
  }
  public Chain(int mx, int my) {
    r = random(245) + 10;
    g = random(245) + 10;
    b = random(245) + 10;
    x = mx;
    y = my;
  }
  
  public void drawSegment(ArrayList toKill) {
    life--;
    if(life<=0) {
      toKill.add(this);
    }
    stroke(r,g,b,life);
    int newDir;
    do{
      newDir = dirs[(int)random(4)];
    } while(newDir==(dir*-1));
    dir = newDir;
    int newX = x;
    int newY = y;
    if(dir==2) {
      if(x<width){newX = x+10;} else {newX=x-10;}
    } else if(dir==-2) {
      if(x>0){newX = x-10;} else {newX=x+10;}
    } else if(dir==1) {
      if(y<height){newY = y+10;} else {newY=y-10;}
    } else {
      if(y>0){newY = y-10;} else {newY=y+10;}
    }
    for(Segment s: segments) {
      line(s.x1,s.y1,s.x2,s.y2);
    }
    segments.add(new Segment(x,y,newX,newY));
    line(x,y,x=newX,y=newY);
  }
}
public class Segment {
  public int x1;
  public int x2;
  public int y1;
  public int y2;
  public Segment(int x1,int y1,int x2,int y2) {
    this.x1 = x1;
    this.x2=x2;
    this.y1=y1;
    this.y2=y2;
  }
}
void mouseClicked() {
  chains.add(new Chain(mouseX,mouseY));
}