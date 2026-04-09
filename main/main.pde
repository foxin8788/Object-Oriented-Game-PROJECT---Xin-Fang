int gameState = 0;  
// 0 = start menu
// 1 = settings
// 2 = playing
// 3 = paused
// 4 = end screen

int killCount = 0; // Player kill count
int winTarget = 15; // How many kills do the player need to win?
float playerHealth = 3.0; // Player's health

// Determine if the game has ended
boolean gameOver = false;
boolean gameWon = false;

// Press and hold to move (Using the keyboard directly to determine if a key is pressed results in a bug where movement in two directions cannot occur simultaneously.)
boolean holdW, holdA, holdS, holdD;

Player p;

// Bullet and Enemy List
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;

void setup() {
  size(400, 400);
  restartGame();
}

void restartGame() {
  // Create a player, place it in the center of the screen
  p = new Player(width/2, height/2);
  
  // Clear bullets and enemies
  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  
  // Clear bullets and enemies
  killCount = 0;
  playerHealth = 3.0;
  gameOver = false;
  gameWon = false;
  
  // Clear bullets and enemies
  holdW = false;
  holdA = false;
  holdS = false;
  holdD = false;
}

void draw() {
  background(220);
  
  // Switch interface according to game status
  if (gameState == 0) {
    displayStartMenu();
  } 
  else if (gameState == 1) {
    displaySettingsMenu();
  } 
  else if (gameState == 2) {
    runGame();
  } 
  else if (gameState == 3) {
    displayGameScene();
    displayPauseMenu();
  } 
  else if (gameState == 4) {
    displayGameScene();
    displayEndScreen();
  }
}

void runGame() {
  // Only execute if the game is not over
  if (!gameOver && !gameWon) {
    // Update player movement
    p.update();
    
    // Update bullets
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.update();
      
      // Delete if it flies off-screen
      if (b.isOffScreen()) {
        bullets.remove(i);
      }
    }
    
    // Spawn enemies
    if (frameCount % 60 == 0) {
      spawnEnemy();
    }
    
    // Enemies + Collision
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy e = enemies.get(i);
      
      // Enemy tracking player
      e.update(p.pos);
      
      boolean enemyRemoved = false;
      
      // Bullet hits enemy
      for (int j = bullets.size() - 1; j >= 0; j--) {
        Bullet b = bullets.get(j);
        
        // Distance detection
        if (PVector.dist(e.pos, b.pos) < e.size/2 + b.size/2) {
          
          // Delete enemies and bullets
          enemies.remove(i);
          bullets.remove(j);
          
          killCount++;
          enemyRemoved = true;
          
          // Achieve the goal
          if (killCount >= winTarget) {
            gameWon = true;
            gameState = 4;
          }
          break;
        }
      }
      
      // If the enemy has already been deleted, do not continue the detection.
      if (enemyRemoved) continue;
      
      // Enemy hits player
      if (PVector.dist(e.pos, p.pos) < e.size/2 + p.size/2) {
        enemies.remove(i);
        
        // Deduct half a drop of blood
        playerHealth -= 0.5;
        
        // Death determination
        if (playerHealth <= 0) {
          playerHealth = 0;
          gameOver = true;
          gameState = 4;
        }
      }
    }
  }
  
  displayGameScene();
}

void displayGameScene() {
  p.display();
  
  for (Bullet b : bullets) {
    b.display();
  }
  
  for (Enemy e : enemies) {
    e.display();
  }
  
  displayUI();
}

void mousePressed() {
  // Start mune
  if (gameState == 0) {
    
    // Play button
    if (mouseX > 120 && mouseX < 280 && mouseY > 150 && mouseY < 210) {
      restartGame();
      gameState = 2;
      return;
    }
    
    // Settings button
    if (mouseX > 120 && mouseX < 280 && mouseY > 240 && mouseY < 300) {
      gameState = 1;
      return;
    }
  }
  
  //Setting
  else if (gameState == 1) {
    
  // 5 enemies need to be killed
    if (mouseX > 70 && mouseX < 190 && mouseY > 130 && mouseY < 200) {
      winTarget = 5;
      return;
    }
  // 10 enemies need to be killed
    if (mouseX > 210 && mouseX < 330 && mouseY > 130 && mouseY < 200) {
      winTarget = 10;
      return;
    }
  // 15 enemies need to be killed
    if (mouseX > 70 && mouseX < 190 && mouseY > 220 && mouseY < 290) {
      winTarget = 15;
      return;
    }
  // 20 enemies need to be killed
    if (mouseX > 210 && mouseX < 330 && mouseY > 220 && mouseY < 290) {
      winTarget = 20;
      return;
    }
  // Back
    if (mouseX > 120 && mouseX < 280 && mouseY > 320 && mouseY < 370) {
      gameState = 0;
      return;
    }
  }
  
  //Playing
  else if (gameState == 2) {
    // Pause button
    if (mouseX > 20 && mouseX < 50 && mouseY > 350 && mouseY < 380) {
      gameState = 3;
    } else {
      // Fire bullets in the direction of the mouse
      bullets.add(new Bullet(p.pos.copy(), new PVector(mouseX, mouseY)));
    }
  }
  
  //Paused
  else if (gameState == 3) {
    // Continue
    if (mouseX > 130 && mouseX < 190 && mouseY > 200 && mouseY < 260) {
      gameState = 2;
      return;
    }
    
    // Restart
    if (mouseX > 210 && mouseX < 270 && mouseY > 200 && mouseY < 260) {
      restartGame();
      gameState = 2;
      return;
    }
    
    // Home
    if (mouseX > 170 && mouseX < 230 && mouseY > 280 && mouseY < 340) {
      gameState = 0;
      return;
    }
  }
  
  // End
  else if (gameState == 4) {
    gameState = 0;
  }
}

void keyPressed() {
  if (gameState == 2) {
    if (key == 'w' || key == 'W') holdW = true;
    if (key == 'a' || key == 'A') holdA = true;
    if (key == 's' || key == 'S') holdS = true;
    if (key == 'd' || key == 'D') holdD = true;
    
    // Press P to pause
    if (key == 'p' || key == 'P') {
      gameState = 3;
    }
  } 
  // Press P again to continue
  else if (gameState == 3) {
    if (key == 'p' || key == 'P') {
      gameState = 2;
    }
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') holdW = false;
  if (key == 'a' || key == 'A') holdA = false;
  if (key == 's' || key == 'S') holdS = false;
  if (key == 'd' || key == 'D') holdD = false;
}

void spawnEnemy() {
  float ex, ey;
  // Randomly select one side
  int side = (int)random(4);

  if (side == 0) {
    ex = random(width);
    ey = -20;
  } 
  else if (side == 1) {
    ex = random(width);
    ey = height + 20;
  } 
  else if (side == 2) {
    ex = -20;
    ey = random(height);
  } 
  else {
    ex = width + 20;
    ey = random(height);
  }
  
  enemies.add(new Enemy(ex, ey));
}
