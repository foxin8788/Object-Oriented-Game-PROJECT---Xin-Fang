void displayStartMenu() {
  drawMenuBackground();
  
  // player icon
  pushMatrix();
  translate(width/2, 90);
  drawPlayerIcon(0, 0, 40);
  popMatrix();
  
  // play button
  fill(100, 220, 120);
  stroke(0);
  rect(120, 150, 160, 60, 12);
  fill(255);
  noStroke();
  triangle(190, 165, 190, 195, 220, 180);
  
  // settings button
  fill(120, 180, 255);
  stroke(0);
  rect(120, 240, 160, 60, 12);
  drawGearIcon(200, 270, 18);
}

// Setting page
void displaySettingsMenu() {
  drawMenuBackground();
  
  // Four target selection buttons
  drawTargetButton(70, 130, 5);
  drawTargetButton(210, 130, 10);
  drawTargetButton(70, 220, 15);
  drawTargetButton(210, 220, 20);
  
  // Back
  fill(230);
  stroke(0);
  rect(120, 320, 160, 50, 12);
  drawBackIcon(200, 345, 22);
}

//Pause page
void displayPauseMenu() {
  fill(0, 150);
  noStroke();
  rect(0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(28);
  text("PAUSED", width/2, 130);

  // Continue
  fill(100, 255, 100);
  stroke(0);
  rect(130, 200, 60, 60, 10);
  fill(255);
  noStroke();
  triangle(152, 215, 152, 245, 175, 230);

  // Restart
  fill(255, 140, 140);
  stroke(0);
  rect(210, 200, 60, 60, 10);
  drawRestartIcon(240, 230, 16, 255);

  // Home
  fill(240);
  stroke(0);
  rect(170, 280, 60, 60, 10);
  drawHomeIcon(200, 310, 18);
}

//End Page
void displayEndScreen() {
  fill(0, 180);
  noStroke();
  rect(0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(30);
  text(gameWon ? "YOU WIN" : "GAME OVER", width/2, height/2 - 20);

  drawRestartIcon(width/2, height/2 + 45, 20, 255);
}


void drawMenuBackground() {
  background(235, 240, 245);

  for (int i = 0; i < width; i += 40) {
    for (int j = 0; j < height; j += 40) {
      noStroke();
      fill(220, 228, 235, 120);
      ellipse(i + 8, j + 8, 4, 4);
    }
  }
}
