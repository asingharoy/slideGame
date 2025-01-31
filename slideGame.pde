import ddf.minim.*;

Player player;
Obstacle obstacle;
Mantarave mantaraveLevel;

boolean HalfBlockSpawned = false;
color c1 = color(random(0, 255), random(0, 255), random(0, 255));
color c2 = color(random(0, 255), random(0, 255), random(0, 255));
color cFinal;

Minim minim;
Music music;
FileReader fileReader;

String text;

AudioPlayer creo_Mantarave;

PImage mantaraveBackground;

PFont font;
color pulse = color(0, 255);

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();


Scoreboard scoreboard;
int score = 0;

int milliTime;

//KEYS
boolean keyW = false;
boolean keyS = false;
boolean keyA = false;
boolean keyD = false;
boolean key1 = false;
boolean key2 = false;
boolean key3 = false;
boolean key4 = false;
boolean key5 = false;
boolean key6 = false;



void setup() {
  //size(1500, 1000, P3D);
  fullScreen(P3D);
  rectMode(CENTER);
  frameRate(100);

  minim = new Minim(this);
  fileReader = new FileReader();
  music = new Music(fileReader);

  creo_Mantarave = minim.loadFile("data/Creo-Mantarave.mp3");
  player = new Player();

  fileReader.loadObstaclesFromFile("data/obstacleMap.txt");
  fileReader.loadBeatsFromFile("data/beatMap.txt");

  mantaraveBackground = loadImage("data/mantaraveBackground.jpg");
  mantaraveBackground.resize(width, height);

  mantaraveLevel = new Mantarave();

  font = createFont("data/Monoton-Regular.ttf", 48);
  textFont(font);

  scoreboard = new Scoreboard();

  randomSeed(0);
  //hint(DISABLE_OPTIMIZED_STROKE);
}

void draw() {
  //DRAW
  mantaraveLevel.update();
  mantaraveLevel.display();
  mantaraveLevel.finishScreen();

  player.display();
  player.movement();
  player.collision(obstacles);

  if (!player.isAlive) {
    if (score < 24000) scoreboard.inputRecorded = true;
    if (millis() > milliTime+1000) {
      scoreboard.input();
    }
  } else {
    milliTime = millis();
  }


  fill(pulse);

  rect(width/2, height/2, width, height);

  score = music.positionGameMusic(creo_Mantarave) - player.timesHit*2000;

  fill(#FF89F3);
  textSize(50);
  if (player.isAlive && !player.firstTime) {
    text = "SCORE: " + score;
  } else if (!player.isAlive && !player.firstTime && !scoreboard.inputRecorded) {
    textSize(30);
    text = "FINAL    SCORE: " + score + ",    Enter    name    and    press   L1! \nPress    L2    to    cancel    score!";
  } else if (!player.isAlive && !player.firstTime && scoreboard.inputRecorded) {
    textSize(30);
    text = "Press    L1    to    play    again!";
    textAlign(CENTER);
    textSize(75);
    text("slidegame", width/2, height/2);
    scoreboard.display();
  } else if (player.firstTime) {
    text = "Press    L1    to    play!";
    textAlign(CENTER);
    textSize(75);
    text("slidegame", width/2, height/2);
    scoreboard.display();
  }
  textAlign(LEFT);
  textSize(50);
  text(text, 200, 100);
} //DRAW ENDS

void keyPressed() {
  if (key == 'w' || keyCode == UP || key == 'i') {
    player.playerStateY = false;
    keyW = true;
  }
  if (key == 's' || keyCode == DOWN || key == 'k') {
    player.playerStateY = true;
    keyS = true;
  }
  if (key == 'a' || keyCode == LEFT || key == 'j') {
    player.playerStateX = false;
    keyA = true;
  }
  if (key == 'd' || keyCode == RIGHT || key == 'l') {
    player.playerStateX = true;
    keyD = true;
  }
  if (key == '1' || key == '7') {
    if (music.playingGameMusic == false && (scoreboard.inputRecorded == true || player.firstTime == true)) {
      mantaraveLevel.i1 = 0;
      music.i1 = 0;
      player.isAlive = true;
      player.firstTime = false;
      player.timesHit = 0;
      player.health = 1;
      scoreboard.inputRecorded = false;

      music.playGameMusic(creo_Mantarave);
    }
    key1 = true;
  }
  if (key == '2' || key == '8') {
    key2 = true;
  }
  if (key == '3' || key == '9') {
    key1 = true;
  }
  if (key == '4' || key == '0') {
    key1 = true;
  }
  if (key == '5' || key == '-') {
    key1 = true;
  }
  if (key == '6' || key == '=') {
    key1 = true;
  }
}

void keyReleased() {
  if (key == 'w' || keyCode == UP || key == 'i') {
    keyW = false;
  }
  if (key == 's' || keyCode == DOWN || key == 'k') {
    keyS = false;
  }
  if (key == 'a' || keyCode == LEFT || key == 'j') {
    keyA = false;
  }
  if (key == 'd' || keyCode == RIGHT || key == 'l') {
    keyD = false;
  }
  if (key == '1' || key == '7') {
    key1 = false;
  }
  if (key == '2' || key == '8') {
    key2 = false;
  }
  if (key == '3' || key == '9') {
    key1 = false;
  }
  if (key == '4' || key == '0') {
    key1 = false;
  }
  if (key == '5' || key == '-') {
    key1 = false;
  }
  if (key == '6' || key == '=') {
    key1 = false;
  }
}
