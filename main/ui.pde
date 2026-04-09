void displayUI() {
  // Top left corner health bar
  drawHearts(20, 20, playerHealth);
  // Progress in the upper right corner
  drawKillProgress(width - 120, 18, 90, 14, killCount, winTarget);
  // Pause button in the lower left corner
  drawPauseButton();
}

// Update 3 hearts
void drawHearts(float startX, float y, float health) {
  for (int i = 0; i < 3; i++) {
    float x = startX + i * 28;
    
    // Full of heart
    if (health >= i + 1) {
      drawHeart(x, y, 18, 255, 60, 100);
    } 
    // Half Heart
    else if (health >= i + 0.5) {
      drawHalfHeart(x, y, 18);
    } 
    // Hollow hearts
    else {
      drawHeartOutline(x, y, 18);
    }
  }
}

// Draw 3 hearts
void drawHeart(float x, float y, float s, float r, float g, float b) {
  noStroke();
  fill(r, g, b);
  ellipse(x - s*0.25, y, s*0.55, s*0.55);
  ellipse(x + s*0.25, y, s*0.55, s*0.55);
  triangle(x - s*0.55, y + s*0.1, x + s*0.55, y + s*0.1, x, y + s*0.9);
}

// Draw three hollow hearts
void drawHeartOutline(float x, float y, float s) {
  stroke(180);
  strokeWeight(2);
  noFill();
  ellipse(x - s*0.25, y, s*0.55, s*0.55);
  ellipse(x + s*0.25, y, s*0.55, s*0.55);
  triangle(x - s*0.55, y + s*0.1, x + s*0.55, y + s*0.1, x, y + s*0.9);
}

// Draw a half-heart
void drawHalfHeart(float x, float y, float s) {
  drawHeartOutline(x, y, s);
  
  pushStyle();
  noStroke();
  fill(255, 60, 100);
  
  beginShape();
  vertex(x - s*0.55, y + s*0.1);
  vertex(x, y + s*0.1);
  vertex(x, y + s*0.9);
  endShape(CLOSE);
  
  ellipse(x - s*0.25, y, s*0.55, s*0.55);
  
  rectMode(CENTER);
  rect(x - s*0.08, y + s*0.3, s*0.18, s*0.7);
  rectMode(CORNER);
  popStyle();
}

void drawPauseButton() {
  stroke(0);
  noFill();
  rect(20, 350, 30, 30, 6);
  
  noStroke();
  fill(0);
  rect(28, 357, 4, 16);
  rect(38, 357, 4, 16);
}

void drawKillProgress(float x, float y, float w, float h, int current, int target) {
  float progress = constrain((float)current / target, 0, 1);
  
  stroke(0);
  fill(255);
  rect(x, y, w, h, 6);
  
  noStroke();
  fill(100, 200, 120);
  rect(x, y, w * progress, h, 6);
  
  drawEnemyIcon(x - 12, y + h/2, 12);
}

void drawEnemyIcon(float x, float y, float s) {
  pushMatrix();
  translate(x, y);
  
  fill(255);
  stroke(0);
  strokeWeight(1);
  
  beginShape();
  vertex(0, -s/2);
  vertex(s/2, -s/4);
  vertex(s/3, s/6);
  vertex(s/2, s/2);
  vertex(0, s/3);
  vertex(-s/3, s/2);
  vertex(-s/4, s/6);
  vertex(-s/2, -s/4);
  endShape(CLOSE);
  
  noStroke();
  fill(0);
  ellipse(-s*0.15, -s*0.1, s*0.2, s*0.35);
  ellipse(s*0.15, 0, s*0.2, s*0.35);
  
  popMatrix();
}
