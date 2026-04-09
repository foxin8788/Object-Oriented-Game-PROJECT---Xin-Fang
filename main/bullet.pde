class Bullet {
  PVector pos; // Bullet position
  PVector vel; // Bullet velocity
  PVector acc; // Bullet acceleration
  
  float size = 8; // Bullet size
  float speed = 8;
  
  // Let the bullets be fired from the player and aimed at the mouse.
  Bullet(PVector startPos, PVector targetPos) {
    pos = startPos.copy();
    
    // Direction = Goal - Starting Point
    vel = PVector.sub(targetPos, startPos);
    vel.normalize(); // Keep only the direction
    vel.mult(speed); // Set the speed
    acc = new PVector(0, 0);
  }
  
  // Update bullets
  void update() {
    vel.add(acc);
    pos.add(vel);
  }
  
  // Draw the bullet
  void display() {
    noStroke();
    fill(0);
    ellipse(pos.x, pos.y, size, size);
  }
  
  // Determine if the character has flown off-screen
  boolean isOffScreen() {
    return pos.x < -10 || pos.x > width + 10 || pos.y < -10 || pos.y > height + 10;
  }
}
