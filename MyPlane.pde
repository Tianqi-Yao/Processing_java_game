import java.util.Iterator; 

class MyPlane {
  private float hp;
  private float px;
  private float py;
  private int x;
  private int y;
  private int firingRate;
  private static final float MAX_HP = 100;

  MyPlane() {
    hp = MAX_HP;
    px = width/2;
    py = height-50;
    x = 100;
    y = 100;
    firingRate = 30;
    userPlane.resize(x, y);
  }

  // Collision with Enemy
  boolean collisionWithEnemy(EnemyPlane enemy) {
    if (dist(px, py, enemy.getPx(), enemy.getPy()) < (x/2 + enemy.getX()/2)) {
      hp -= 5;
      return true;
    }
    return false;
  }

  // Determine if you are hit, if you are hit, deduct the amount of HP
  boolean wereShot(Bullets bullet) {
    if (dist(px, py, bullet.getPx(), bullet.getPy()) < x/2) {
      hp -= 5;
      return true;
    }
    return false;
  }

  // Plot the HP level of my plane at the bottom left of the screen
  void drawHP() {
    rectMode(CORNER);
    fill(#ecf0f1);
    stroke(0);
    rect(0, height-200, 15, 200);
    fill(#ff6348);
    stroke(0);
    rect(0, height-(200*(hp/MAX_HP)), 15, 200*(hp/MAX_HP));
  }

  // The main methods used to call the plane
  // Draw all the appropriate images of the plane
  // if generate a bullet return this bullet obj
  Bullets drawPlane() {

    imageMode(CENTER);
    image(userPlane, px, py);
    Bullets newBullet = null;
    if ( frameCount % firingRate == 0) {
      newBullet =  fire();
    }
    ellipseMode(CENTER);
    noFill();
    stroke(#2b5bff);
    if(hp < MAX_HP/3*2){
      stroke(#ffff4d);
    }
    if(hp < MAX_HP/3*1){
      stroke(#ff0909);
    }
    strokeWeight(4);
    ellipse(px, py, x, y);
    //drawBullets();
    drawHP();
    return newBullet;
  }

  // Generate one bullet object per call and return this obj
  Bullets fire() {
    Bullets newBullet = new Bullets(px, py-y/2, false);
    //userBullets.add(newBullet);
    biu.play();
    return newBullet;
  }

  //// Draw all the bullets object
  //void drawBullets() {
  //  Iterator<Bullets> iter = userBullets.iterator(); 
  //  while (iter.hasNext()) {
  //    Bullets bullet = iter.next();
  //    // Delete the bullet object if the bullet is out of bounds
  //    if (bullet.getPy() < 0) {
  //      iter.remove();
  //    } 
  //    // Draw the bullets that are not beyond the boundary
  //    else {
  //      bullet.drawUserBullet();
  //      // Delete the bullet object if it is judged to have been shot by enemy
  //      if (bullet.isEnemysBullets() == true && wereShot(bullet)) {
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
  
  void setPositionByKeyboard(float px, float py) {
    this.px += px;
    this.py += py;
  }

  float getPx() {
    return px;
  }

  float getPy() {
    return py;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
  
  float getHP(){
    return hp;
  }
  
}
