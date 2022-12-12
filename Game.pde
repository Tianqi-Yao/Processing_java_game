import processing.sound.*; //<>//
// Statement Voice
SoundFile menuBackground;
SoundFile inGameBackground;
SoundFile bossBackground;
SoundFile biu;
SoundFile bom;
SoundFile pang;

//Statement picture
PImage startBackgournd;
PImage easyBackground;
PImage hardBackground;
PImage userPlane;
PImage enemyPlane1;
PImage enemyPlane2;
PImage boss;

//Statement of menu
Interface menu;

// Statement of space
Space space;


void setup() {
  size(800, 800);

  // load sound and pic
  load();

  // create menu
  menu = new Interface(); //<>//

  // create space
  space = new Space(); //<>//
}



void draw() {
  if (menu.inMenu() == false) {
    space.drawSpace();
    menu.drawSpaceMenu();
  }
}

void mousePressed() {
  menu.mousePressed();
}

void keyPressed() {
  space.keyPressed();
}
void keyReleased() {
  space.keyReleased();
}

void load() {
  // Load a soundfile from the /data folder of the sketch and play it back
  menuBackground = new SoundFile(this, "sounds/menuBackground.wav"); //<>//
  inGameBackground = new SoundFile(this, "sounds/inGameBackground.wav");
  bossBackground = new SoundFile(this, "sounds/bossBackground.wav");
  biu = new SoundFile(this, "sounds/biu.wav");
  bom = new SoundFile(this, "sounds/bom.wav");
  pang = new SoundFile(this, "sounds/pang.wav");

  // Loading images
  startBackgournd = loadImage("pics/startBackgournd.jpeg");
  easyBackground = loadImage("pics/easyBackground.jpg");
  easyBackground.resize(width, height);
  hardBackground = loadImage("pics/hardBackground.jpg");
  hardBackground.resize(width, height);
  userPlane = loadImage("pics/userPlane.png");
  enemyPlane1 = loadImage("pics/enemyPlane1.png"); 
  enemyPlane2 = loadImage("pics/enemyPlane2.png");
  boss = loadImage("pics/boss.png");
}
