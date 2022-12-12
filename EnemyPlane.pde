import java.util.Iterator; 

class EnemyPlane {
  private float hp;
  private float px;
  private float py;
  private int x;
  private int y;
  private int v;
  private int vX;
  private int vY;
  private int firingRate;
  private boolean isBoss;
  private int enemyMode;
  private boolean bossThere;
  private float bossMaxHP;

  // size default is 100,100
  EnemyPlane() {
    hp = 1;
    x = 100;
    y = 100;
    px = random(x, width-x);
    py = 0-y;
    firingRate = 80;
    v = 2;
    enemyPlane1.resize(x, y);
    enemyPlane2.resize(x, y);
    isBoss = false;
    enemyMode = (int)random(1, 3);
  }

  void boosTheSet() {
    hp = 100;
    x = 500;
    y = 500;
    px = width/2;
    boss.resize(x, y);
    enemyMode = 0;
    vX = 1;
    vY = 1;
    isBoss = true;
    bossThere = false;
  }
  
  void boosMaxHPSet(float bossMaxHP) {
    this.bossMaxHP = bossMaxHP;
    hp = bossMaxHP;
  }

  //// init, can set size
  //EnemyPlane(int enemySizeX, int enemySizeY, boolean isBoss, float hp) {
  //  this.hp = hp;
  //  x = enemySizeX;
  //  y = enemySizeY;
  //  px = random(x, width-x);
  //  py = 0-y;
  //  firingRate = 80;
  //  v = 2;
  //  enemyPlane1.resize(x, y);
  //  enemyPlane2.resize(x, y);
  //  this.isBoss = isBoss;
  //  if (isBoss == true) {
  //    boss.resize(x, y);
  //    enemyMode = 0;
  //    vX = 2;
  //    vY = 2;
  //    bossThere = false;
  //  }
  //}

  // Determine if you are hit, if you are hit, deduct the amount of HP
  boolean wereShot(Bullets bullet) {
    if (dist(px, py, bullet.getPx(), bullet.getPy()) < y/2) {
      hp -= 5;
      return true;
    }
    return false;
  }

  //// Plot the HP level of my plane at the bottom left of the screen
  //void drawHP() {
  //  rectMode(CORNER);
  //  fill(#ecf0f1);
  //  stroke(0);
  //  rect(0, height-200, 15, 200);
  //  fill(#ff6348);
  //  noStroke();
  //  rect(0, height-hp, 15, hp);
  //}

  // The main methods used to call the plane
  // Draw all the appropriate images of the plane
  ArrayList<Bullets> drawPlane() {
    imageMode(CENTER);
    if (enemyMode == 1) {
      image(enemyPlane1, px, py);
    } else if (enemyMode == 2) {
      image(enemyPlane2, px, py);
    }
    ArrayList<Bullets> newBullets = null;
    if ( frameCount % firingRate == 0) {
      newBullets = fire(isBoss);
    }
    //ellipseMode(CENTER);
    //noFill();
    //stroke(#ffff4d);
    //strokeWeight(4);
    //ellipse(px, py, x, y);
    //drawBullets();
    //drawHP();

    // Flight Speed
    py += v;
    return newBullets;
  }

  // draw boss
  ArrayList<Bullets> drawBoss() {
    imageMode(CENTER);
    image(boss, px, py);

    ArrayList<Bullets> newBullets = null;
    if ( frameCount % firingRate == 0) {
      newBullets = fire(isBoss);
    }
    
    ellipseMode(CENTER);
    noFill();
    stroke(#2b5bff);
    if(hp < bossMaxHP/3*2){
      stroke(#ffff4d);
    }
    if(hp < bossMaxHP/3*1){
      stroke(#ff0909);
    }
    strokeWeight(4);
    ellipse(px, py, x, y);
    noStroke();
    
    
    if (bossThere == false) {
      if (py < 0) {
        py += vY;
      } else {
        bossThere = true;
      }
    } else {
      // Flight direction
      if (px<0 || px >width) {
        vX =-vX;
      }
      if (py<0 || py > height/4) {
        vY =-vY;
      }
      // Flight Speed
      px += vX;
      py += vY;
    }
    return newBullets;
  }

  // Generate one bullet object per call and store it in the bullet collection
  ArrayList<Bullets> fire(boolean isBoss) {
    ArrayList<Bullets> bullets = new ArrayList();
    if (isBoss) {
      Bullets newBullet1 = new Bullets(px-x/5, py+y/10, true, true);
      Bullets newBullet2 = new Bullets(px+x/5, py+y/10, true, true);
      bullets.add(newBullet1);
      bullets.add(newBullet2);
      return bullets;
    } else {
      Bullets newBullet = new Bullets(px, py+y/2, true);
      bullets.add(newBullet);
      return bullets;
    }
  }

  //// Draw all the bullets object
  //void drawBullets() {
  //  Iterator<Bullets> iter = enemyBullets.iterator(); 
  //  while (iter.hasNext()) {
  //    Bullets enemyBullet = iter.next();
  //    // Delete the bullet object if the bullet is out of bounds
  //    if (enemyBullet.getPy() > height) {
  //      iter.remove();
  //    } 
  //    // Draw the bullets that are not beyond the boundary
  //    else {
  //      enemyBullet.drawEnemyBullet();
  //      // Delete the bullet object if it is judged to have been shot by enemy
  //      if (enemyBullet.isEnemysBullets() == false && wereShot(enemyBullet)) {
  //        iter.remove();
  //      }
  //    }
  //  }
  //}

  // Set the position of the aircraft, for mouse operation
  void setPosition(float px, float py) {
    this.px = px;
    this.py = py;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
  float getPx() {
    return px;
  }

  float getPy() {
    return py;
  }

  float getHP() {
    return hp;
  }

  boolean isBoss() {
    return isBoss;
  }
}
