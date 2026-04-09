void drawTargetButton(float x, float y, int value) {
  if (winTarget == value) {
    fill(120, 220, 140);
  } else {
    fill(245);
  }

  stroke(0);
  strokeWeight(2);
  rect(x, y, 120, 70, 12);

  int iconCount = value / 5;

  for (int i = 0; i < iconCount; i++) {
    drawEnemyIcon(x + 22 + i * 24, y + 35, 18);
  }
}

void drawPlusIcon(float x, float y, float s) {
  stroke(255);
  strokeWeight(4);
  line(x - s/2, y, x + s/2, y);
  line(x, y - s/2, x, y + s/2);
}

void drawMinusIcon(float x, float y, float s) {
  stroke(255);
  strokeWeight(4);
  line(x - s/2, y, x + s/2, y);
}

void drawBackIcon(float x, float y, float s) {
  stroke(0);
  strokeWeight(4);
  noFill();
  line(x + s/2, y - s/2, x - s/2, y);
  line(x - s/2, y, x + s/2, y + s/2);
}

void drawHomeIcon(float x, float y, float s) {
  stroke(255);
  strokeWeight(3);
  fill(255);
  triangle(x - s, y - 2, x, y - s, x + s, y - 2);
  rectMode(CENTER);
  rect(x, y + s*0.45, s*1.2, s);
  rectMode(CORNER);
}

void drawRestartIcon(float x, float y, float s, float c) {
  noFill();
  stroke(c);
  strokeWeight(3);
  arc(x, y, s*2, s*2, PI*0.2, PI*1.7);
  line(x + s*0.6, y - s*0.9, x + s*0.2, y - s*1.2);
  line(x + s*0.6, y - s*0.9, x + s*0.2, y - s*0.6);
}

void drawGearIcon(float x, float y, float r) {
  pushMatrix();
  translate(x, y);

  stroke(255);
  strokeWeight(3);
  noFill();

  for (int i = 0; i < 8; i++) {
    float a = TWO_PI / 8 * i;
    line(cos(a) * (r + 4), sin(a) * (r + 4), cos(a) * (r + 10), sin(a) * (r + 10));
  }

  ellipse(0, 0, r * 2, r * 2);
  ellipse(0, 0, r * 0.8, r * 0.8);
  popMatrix();
}

void drawPlayerIcon(float x, float y, float s) {
  rectMode(CENTER);
  fill(255);
  stroke(0);
  rect(x, y, s, s);

  fill(0);
  rect(x + s*0.65, y, s*0.45, s*0.18);
  rectMode(CORNER);
}
