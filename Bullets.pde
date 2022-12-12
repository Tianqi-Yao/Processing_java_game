class Bullets {
  private float px;
  private float py;
  private int x;
  private int y;
  private int v;
  private boolean isEnemysBullets;

  Bullets(float px, float py, boolean isEnemysBullets) {
    this.px = px;
    this.py = py;
    x = 5;
    y = 5;
    v = 3;
    // true means enemy's bullets
    // false means player's bullets
    this.isEnemysBullets = isEnemysBullets;
  }

  Bullets(float px, float py, boolean isEnemysBullets, boolean isBoss) {
    this.px = px;
    this.py = py;
    v = 3;
    this.isEnemysBullets = isEnemysBullets;
    if (isBoss == true) {
      x = 10;
      y = 10;
    } else {
      x = 5;
      y = 5;   
    }
  }

  // Draw the user's bullet, the bullet flies upwards
  void drawUserBullet() {
    ellipseMode(CENTER);
    noStroke();
    fill(#fc8705);
    ellipse(px, py, x, y);
    py -= v;
  }

  // Draw the enemy's bullet, the bullet flies downwards
  void drawEnemyBullet() {
    ellipseMode(CENTER);
    noStroke();
    fill(#fc8705);
    ellipse(px, py, x, y);
    py += v;
  }

  float getPy() {
    return py;
  }

  float getPx() {
    return px;
  }

  boolean isEnemysBullets() {
    return isEnemysBullets;
  }
}
