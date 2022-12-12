class Space { //<>//
  // Data
  //Statement of user aircraft objects
  private MyPlane userPlane;
  //Statement an array of enemy aircraft objects
  private ArrayList<EnemyPlane> enemies;
  // Statement of enemy generation rate
  private int enemyFormationRate;
  // Statement of enemy bullets in space
  private ArrayList<Bullets> enemyBullets;
  // Statement of user bullets in space
  private ArrayList<Bullets> userBullets;
  // boss
  private EnemyPlane boss;

  private boolean bossThere;

  private boolean isWin;

  private boolean up, down, left, right;
  private static final int KEYBOARD_V = 5;
  private static final int BOSS_APPEARS_SECOND = 60;

  Space() {
    // init
    // Create my plane
    userPlane = new MyPlane();

    // create ememy array
    enemies = new ArrayList();
    // enemy Formation Rate, The smaller it is, the faster it is generated
    if (menu.getHard()) {
      enemyFormationRate = 30;
    } else {
      enemyFormationRate = 100;
    }

    // create enemyBullets array
    enemyBullets = new ArrayList();
    // create userBullets array
    userBullets = new ArrayList();
    bossThere = false;
    isWin = false;
  }

  // Method
  void drawSpace() {

    // draw user plane and store bullets shot by users
    if (menu.getKeyboard()) {
      //keyboardContral();
      if (up) {
        userPlane.setPositionByKeyboard(0, -KEYBOARD_V);
      }
      if (down) {
        userPlane.setPositionByKeyboard(0, KEYBOARD_V);
      }
      if (left) {
        userPlane.setPositionByKeyboard(-KEYBOARD_V, 0);
      }
      if (right) {
        userPlane.setPositionByKeyboard(KEYBOARD_V, 0);
      }
    } else {
      userPlane.setPosition(mouseX, mouseY);
    }

    Bullets bullet = userPlane.drawPlane();
    if (bullet != null) {
      userBullets.add(bullet);
    }
    drawUserBullets();


    //// ** one enemy test
    //// Delete the enemy object if the enemy is out of bounds
    //if (enemy.getPy()- enemy.getY()> height) {
    //  enemy = null;
    //} 
    //// Draw the enemy that are not beyond the boundary
    //else {
    //  enemy.drawPlane();
    //  // Delete the bullet object if it is judged to have been shot by enemy
    //  //if (bullet.getIsEnemysBullets() == true && wereShot(bullet)) {
    //  //  iter.remove();
    //  //}
    //}
    //// ** end

    // create boss
    //println((menu.getStartSecond()+10)%60+", "+ second());
    if ((menu.getStartSecond()+BOSS_APPEARS_SECOND)%60 == second() && bossThere == false) {
      inGameBackground.stop();
      bossBackground.loop();
      boss = new EnemyPlane();
      boss.boosTheSet();
      if (menu.getHard()) {
        boss.boosMaxHPSet(300);
      }
      bossThere = true;
    } 
    // Create regular aircraft
    else {
      // create enemy by enemyFormationRate
      generateAnEnemy();
    }

    drawEnemyBullets();

    //draw boss
    if (boss != null) {
      ArrayList<Bullets> bullets = boss.drawBoss();
      if (bullets != null) {
        enemyBullets.addAll(bullets);
      }
      println(boss.getHP());
      if (isBossDie(boss)) {
        boss = null;
        pang.play();
        isWin = true;
        bossThere = false;
      }
    }

    // draw all enemies in array
    drawAllEnemies();
  }

  void keyPressed() {
    if (menu.getKeyboard()) {
      if (keyCode  == UP) {
        up = true;
        //userPlane.setPositionByKeyboard(0, -2);
      }
      if (keyCode  == DOWN) {
        down = true;
        //userPlane.setPositionByKeyboard(0, 2);
      }
      if (keyCode  == LEFT) {
        left = true;
        //userPlane.setPositionByKeyboard(-2, 0);
      }
      if (keyCode  == RIGHT) {
        right = true;
        //userPlane.setPositionByKeyboard(2, 0);
      }
    }
  }

  void keyReleased() {
    if (menu.getKeyboard()) {
      if (keyCode  == UP) {
        up = false;
        //userPlane.setPositionByKeyboard(0, -2);
      }
      if (keyCode  == DOWN) {
        down = false;
        //userPlane.setPositionByKeyboard(0, 2);
      }
      if (keyCode  == LEFT) {
        left = false;
        //userPlane.setPositionByKeyboard(-2, 0);
      }
      if (keyCode  == RIGHT) {
        right = false;
        //userPlane.setPositionByKeyboard(2, 0);
      }
    }
  }


  // create enemy by enemyFormationRate
  void generateAnEnemy() {
    if ( frameCount % enemyFormationRate == 0) {
      EnemyPlane newEnemy = new EnemyPlane();
      enemies.add(newEnemy);
    }
  }

  // draw all enemies in array
  void drawAllEnemies() {
    Iterator<EnemyPlane> iter = enemies.iterator(); 
    while (iter.hasNext()) {
      EnemyPlane enemy = iter.next();
      // Delete the enemy object if the enemy is out of bounds
      if (enemy.getPy()- enemy.getY()> height) {
        iter.remove();
        menu.setScore(-5);
      } 
      // be shot
      else if (collision(iter, enemy)) {
        //println("be shot!");
      }
      // Draw the enemy that are not beyond the boundary
      else {
        ArrayList<Bullets> bullets = enemy.drawPlane();
        if (bullets != null) {
          enemyBullets.addAll(bullets);
        }
        //// traverse each bullet
        //for (Bullets bullet : userPlane.userBullets) {
        //  if (bullet.isEnemysBullets() == false && userPlane.wereShot(bullet)) {
        //    println(bullet.isEnemysBullets());
        //    iter.remove();
        //  }
        //}

        // Delete the bullet object if it is judged to have been shot by enemy
        //if (bullet.getIsEnemysBullets() == true && wereShot(bullet)) {
        //  iter.remove();
        //}
      }
    }
  }

  // Draw all the user bullets object
  void drawUserBullets() {
    Iterator<Bullets> iter = userBullets.iterator(); 
    while (iter.hasNext()) {
      Bullets bullet = iter.next();
      // Delete the bullet object if the bullet is out of bounds
      if (bullet.getPy() < 0) {
        iter.remove();
      }
      //// Delete the bullet object if it is judged to have been shot by enemy
      //else if (bullet.isEnemysBullets() == false && userPlane.wereShot(bullet)) {
      //  iter.remove();
      //}
      // Draw the bullets that are not beyond the boundary
      else {
        bullet.drawUserBullet();
      }
    }
  }

  // Draw all the enemy bullets object
  void drawEnemyBullets() {
    Iterator<Bullets> iter = enemyBullets.iterator(); 
    while (iter.hasNext()) {
      Bullets bullet = iter.next();
      // Delete the bullet object if the bullet is out of bounds
      if (bullet.getPy() < 0) {
        iter.remove();
      }
      // Delete the bullet object if it is judged to have been shot by enemy
      else if (bullet.isEnemysBullets() == true && userPlane.wereShot(bullet)) {
        iter.remove();
      }
      //Draw the bullets that are not beyond the boundary
      else {
        bullet.drawEnemyBullet();
      }
    }
  }

  boolean collision(Iterator<EnemyPlane> iter, EnemyPlane enemy) {
    // Collision with userPlane
    if (userPlane.collisionWithEnemy(enemy)) {
      iter.remove();
      bom.play();
      return true;
    }
    // Collision with bullets
    // traverse each bullet
    for (Bullets bullet : userBullets) {
      if (bullet.isEnemysBullets() == false && enemy.wereShot(bullet)) {
        userBullets.remove(bullet);
        if (enemy.getHP() <= 0) {
          iter.remove();
          bom.play();
          menu.setScore(5);
        }

        return true;
      }
    }
    return false;
  }

  boolean isBossDie(EnemyPlane boss) {
    // boos Crash with bullets
    // traverse each bullet
    for (Bullets bullet : userBullets) {
      if (bullet.isEnemysBullets() == false && boss.wereShot(bullet)) {
        userBullets.remove(bullet);
        if (boss.getHP() <= 0) {
          menu.setScore(50);
          return true;
        }
        return false;
      }
    }
    return false;
  }

  //void keyboardContral() {
  //  if (keyPressed) {
  //    if (keyCode  == UP) {
  //      //if (keyCode  == LEFT) {
  //      //  userPlane.setPositionByKeyboard(-2, -2);
  //      //} else if (keyCode  == RIGHT) {
  //      //  userPlane.setPositionByKeyboard(2, -2);
  //      //} else {
  //        userPlane.setPositionByKeyboard(0, -2);

  //    }
  //    if (keyCode  == DOWN) {
  //      //if (keyCode  == LEFT) {
  //      //  userPlane.setPositionByKeyboard(-2, 2);
  //      //} else if (keyCode  == RIGHT) {
  //      //  userPlane.setPositionByKeyboard(2, 2);
  //      //} else {
  //        userPlane.setPositionByKeyboard(0, 2);

  //    }
  //    if (keyCode  == LEFT) {
  //      userPlane.setPositionByKeyboard(-2, 0);
  //    }
  //    if (keyCode  == RIGHT) {
  //      userPlane.setPositionByKeyboard(2, 0);
  //    }
  //  }
  //}

  void setEnemyFormationRate(int enemyFormationRate) {
    this.enemyFormationRate = enemyFormationRate;
  }

  boolean isOver() {
    if (userPlane.getHP() <=0) {
      return true;
    }
    return false;
  }

  boolean isWin() {
    return isWin;
  }
}
