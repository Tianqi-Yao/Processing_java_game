class Interface {
  // Variables
  //Statement of button positions and sizes
  private int[] leftButtonPosition;
  private int[] rightButtonPosition;
  private int[] sizeTheButton;
  private int[] leaveButton;
  private int score;
  private int startSecond;
  //Statement of interface state
  private boolean selectOperatingMode, selectDifficulty, gameOver, winningGame, inGame, readyToStart;

  //Statement of interface properties
  private boolean hard, easy, keyboard, mouse;

  // Method
  Interface() {
    // Set button size and position
    // Left button, right button, leave button
    leftButtonPosition = new int[]{width/4, height-120};
    rightButtonPosition = new int[]{width/4*3, height-120};
    sizeTheButton = new int[]{100, 50};
    leaveButton = new int[]{width-70, 50};
    selectOperatingMode = true;
    score= 0;

    // Reset all states
    reset(); //<>//

    // Start playing background music in a loop
    menuBackground.loop();
  }

  boolean inMenu() {
    // background
    if (selectOperatingMode == true || selectDifficulty == true || readyToStart == true) {
      background(#2e62cd);
      imageMode(CORNER);
      image(startBackgournd, 0, 0);
      drawButton("leave", leaveButton[0], leaveButton[1], sizeTheButton[0], sizeTheButton[1]);
    } else if (easy == true) {
      background(easyBackground);
    } else if (hard == true) {
      background(hardBackground);
    }


    // Interface Mode
    if (selectOperatingMode == true) {
      drawButton("keyboard", leftButtonPosition[0], leftButtonPosition[1], sizeTheButton[0], sizeTheButton[1]);
      drawButton("mouse", rightButtonPosition[0], rightButtonPosition[1], sizeTheButton[0], sizeTheButton[1]);
      if (menuBackground.isPlaying() == false) {
        inGameBackground.stop();
        bossBackground.stop();
        menuBackground.loop();
      }
    }

    if (selectDifficulty == true) {
      drawButton("easy", leftButtonPosition[0], leftButtonPosition[1], sizeTheButton[0], sizeTheButton[1]);
      drawButton("hard", rightButtonPosition[0], rightButtonPosition[1], sizeTheButton[0], sizeTheButton[1]);
    }

    if (readyToStart == true) {
      drawButton("start", leftButtonPosition[0], leftButtonPosition[1], sizeTheButton[0], sizeTheButton[1]);
      drawButton("reset", rightButtonPosition[0], rightButtonPosition[1], sizeTheButton[0], sizeTheButton[1]);
    }

    if (inGame == true) {
      if (inGameBackground.isPlaying() == false && bossBackground.isPlaying() == false) {
        startSecond = second();
        menuBackground.stop();
        inGameBackground.loop();
        bossBackground.stop();
      }
      if (space.isOver()) {
        inGame = false;
        gameOver = true;
      }
      if (space.isWin()) {
        inGame = false;
        winningGame = true;
      }
    }

    if (gameOver == true) {
      inGameBackground.stop();
      bossBackground.stop();
      drawButton("restart", leaveButton[0], leaveButton[1], sizeTheButton[0], sizeTheButton[1]);
      String scoreStr = Integer.toString(score);
      scoreStr = "GAME OVER\n" + scoreStr;
      textAlign(CENTER);
      textSize(50);
      fill(#f39c12);
      text(scoreStr, width/2, height/2);
    }

    if (winningGame == true) {
      inGameBackground.stop();
      bossBackground.stop();
      drawButton("restart", leaveButton[0], leaveButton[1], sizeTheButton[0], sizeTheButton[1]);
      String scoreStr = Integer.toString(score);
      scoreStr = "YOU WIN\n" + scoreStr;
      textAlign(CENTER);
      textSize(50);
      fill(#f39c12);
      text(scoreStr, width/2, height/2);
    }

    return !inGame;
  }

  void drawSpaceMenu() {
    // draw restart button
    drawButton("restart", menu.leaveButton[0], menu.leaveButton[1], menu.sizeTheButton[0], menu.sizeTheButton[1]);
    //draws score
    String scoreStr = Integer.toString(score);
    textAlign(LEFT);
    textSize(50);
    fill(#f39c12);
    text(scoreStr, 10, 50);
  }

  // one buttom + text
  void drawButton(String lName, int px, int py, int x, int y) {
    rectMode(CENTER);
    fill(#f39c12);
    rect(px, py, x, y, 7);

    fill(0);
    textSize(19);
    textAlign(CENTER);
    text(lName, px, py+5);
  }

  void mousePressed() {
    //// Access different operation selection methods according to different interface status tabs
    //if (selectOperatingMode == true) {
    //  selectOperatingMode();
    //} else if (selectDifficulty == true) {
    //  selectDifficulty();
    //} else if (readyToStart == true) {
    //  selectReadyToStart();
    //}
    
    // Leave button, which also has the function of restarting the game in the game
    if (inGame == false && gameOver == false && winningGame == false) {
      // Access different operation selection methods according to different interface status tabs
      if (selectOperatingMode == true) {
        selectOperatingMode();
      } else if (selectDifficulty == true) {
        selectDifficulty();
      } else if (readyToStart == true) {
        selectReadyToStart();
      }
      selectLeave();
    } else {
      selectRestart();
      
    }
  }

  void selectOperatingMode() {
    // select left button, Add keyboard tab
    if (mouseX > leftButtonPosition[0] - sizeTheButton[0]/2 && mouseX < leftButtonPosition[0] + sizeTheButton[0]/2
      && mouseY > leftButtonPosition[1] - sizeTheButton[1]/2 && mouseY < leftButtonPosition[1] + sizeTheButton[1]/2
      ) {
      selectOperatingMode = false;
      selectDifficulty = true;
      keyboard = true;
    }
    // select right button, Add mouse tab
    if (mouseX > rightButtonPosition[0] - sizeTheButton[0]/2 && mouseX < rightButtonPosition[0] + sizeTheButton[0]/2
      && mouseY > rightButtonPosition[1] - sizeTheButton[1]/2 && mouseY < rightButtonPosition[1] + sizeTheButton[1]/2) {
      selectOperatingMode = false;
      selectDifficulty = true;
      mouse = true;
    }
  }

  void selectDifficulty() {
    // select left button, Add easy tab
    if (mouseX > leftButtonPosition[0] - sizeTheButton[0]/2 && mouseX < leftButtonPosition[0] + sizeTheButton[0]/2
      && mouseY > leftButtonPosition[1] - sizeTheButton[1]/2 && mouseY < leftButtonPosition[1] + sizeTheButton[1]/2
      ) {
      readyToStart = true;
      selectDifficulty = false;
      easy = true;
    }
    // select right button, Add hard tab
    if (mouseX > rightButtonPosition[0] - sizeTheButton[0]/2 && mouseX < rightButtonPosition[0] + sizeTheButton[0]/2
      && mouseY > rightButtonPosition[1] - sizeTheButton[1]/2 && mouseY < rightButtonPosition[1] + sizeTheButton[1]/2) {
      readyToStart = true;
      selectDifficulty = false;
      hard = true;
    }
  }

  void selectReadyToStart() {
    // select left button, Start the game
    if (mouseX > leftButtonPosition[0] - sizeTheButton[0]/2 && mouseX < leftButtonPosition[0] + sizeTheButton[0]/2
      && mouseY > leftButtonPosition[1] - sizeTheButton[1]/2 && mouseY < leftButtonPosition[1] + sizeTheButton[1]/2
      ) {
      inGame = true;
      readyToStart = false;
    }
    // select right button, reset the game
    if (mouseX > rightButtonPosition[0] - sizeTheButton[0]/2 && mouseX < rightButtonPosition[0] + sizeTheButton[0]/2
      && mouseY > rightButtonPosition[1] - sizeTheButton[1]/2 && mouseY < rightButtonPosition[1] + sizeTheButton[1]/2) {
      reset();
    }
  }

  void selectLeave() {
    // select left button, leave the game
    if (mouseX > leaveButton[0] - sizeTheButton[0]/2 && mouseX < leaveButton[0] + sizeTheButton[0]/2
      && mouseY > leaveButton[1] - sizeTheButton[1]/2 && mouseY < leaveButton[1] + sizeTheButton[1]/2
      ) {
      exit();
    }
  }

  void selectRestart() {
    // select left button, restart the game
    if (mouseX > leaveButton[0] - sizeTheButton[0]/2 && mouseX < leaveButton[0] + sizeTheButton[0]/2
      && mouseY > leaveButton[1] - sizeTheButton[1]/2 && mouseY < leaveButton[1] + sizeTheButton[1]/2
      ) {
      reset();
      space = new Space();
    }
  }

  void reset() {
    // Game interface status
    selectOperatingMode = true;
    selectDifficulty = false; 
    readyToStart = false;
    inGame = false;

    // Game Result Status
    gameOver = false; 
    winningGame = false; 

    // Game Property Tags
    hard = false; 
    easy = false;
    keyboard = false; 
    mouse = false;

    score = 0;
  }

  void setScore(int score) {
    this.score += score;
  }

  int getStartSecond() {
    return startSecond;
  }

  boolean getHard() {
    return hard;
  }

  boolean getKeyboard() {
    return keyboard;
  }
}
