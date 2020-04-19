PVector birdPos;
PVector birdVel;
PVector jump;
PVector gravity;
PVector pipePos;
PVector pipeVel;
float gapHeight;
float birdSize;
float pipeWidth;
float w;
float h;
boolean dead;
int score;
boolean in;
PVector scorePos;

void setup() {
  size(300, 600);
  //frameRate(120000000);

  w = width;
  h = height;
  birdPos = new PVector(width/4, height/2);
  birdVel = new PVector(0, 0);
  jump = new PVector(0, -height/80);
  gravity = new PVector(0, h/1800);
  pipePos = newPipe();
  pipeVel = new PVector(-width/90, 0);
  gapHeight = height/4;
  birdSize = width/10;
  pipeWidth = width/6;
  dead = true;
  score = 0;
  in = false;
  scorePos = new PVector(width/2, height*0.1);

  strokeWeight(5);
  textAlign(CENTER);
  textSize(20);
}

void draw() {
  background(100, 100, 255);

  if (!dead) {
    birdVel.add(gravity);
    birdPos.add(birdVel);
    pipePos.add(pipeVel);
  }

  if (birdPos.y >= height) {
    dead = true;
    birdPos.y = height;
  } else if (birdPos.x > pipePos.x && birdPos.x < pipePos.x + pipeWidth) {
    if (birdPos.y > pipePos.y + gapHeight) {
      dead = true;
    } else if (birdPos.y < pipePos.y) {
      dead = true;
    } else {
      in = true;
    }
  } else if (in) {
    score++;
    in = false;
  }

  fill(200, 0, 0);
  stroke(200, 200, 0);
  circle(birdPos.x, birdPos.y, birdSize);

  fill(0, 255, 0);
  stroke(0, 80, 0);
  rect(pipePos.x, -10, pipeWidth, pipePos.y+10);
  rect(pipePos.x, pipePos.y + gapHeight, pipeWidth, height);

  fill(255);
  text(score, scorePos.x, scorePos.y);

  if (pipePos.x < -pipeWidth) {
    pipePos = newPipe();
  }
}

void keyPressed() {
  if (dead) {
    birdPos = new PVector(width/4, height/2);
    birdVel = new PVector(0, 0);
    pipePos = newPipe();
    pipeVel = new PVector(-width/90, 0);
    birdVel = jump.copy();
    dead = false;
  } else {
    birdVel = jump.copy();
  }
}

PVector newPipe() {
  return new PVector(width, random(gapHeight*.3, height - gapHeight*1.3));
}
