class Player {
  PVector pos; // Player position
  PVector vel; // Player speed
  PVector acc; // Player acceleration
  
  float maxSpeed = 3; // Maximum speed limit
  float size = 30; 
  
  Player(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
// Update player movement
  void update() {
    acc.set(0, 0); // Clear acceleration
    
    if (holdW) acc.y = -0.4;
    if (holdS) acc.y = 0.4;
    if (holdA) acc.x = -0.4;
    if (holdD) acc.x = 0.4;
    
    vel.add(acc); //Velocity += Acceleration
    
    // If no button is pressed, decelerate (simulate inertia after movement).
    if (!holdW && !holdS) vel.y *= 0.8;
    if (!holdA && !holdD) vel.x *= 0.8;
    
    vel.limit(maxSpeed); // Limit maximum speed
    pos.add(vel); // Update position
    
    // Prevent players from running off-screen
    pos.x = constrain(pos.x, size/2, width - size/2);
    pos.y = constrain(pos.y, size/2, height - size/2);
  }
  
  // Draw the player
  void display() {
    rectMode(CENTER);
    
    //body
    fill(255);
    stroke(0);
    rect(pos.x, pos.y, size, size);
    
    // eyes
    fill(0);
    ellipse(pos.x - 5, pos.y - 5, 4, 4);
    ellipse(pos.x + 5, pos.y - 5, 4, 4);
    
    // gun
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(mouseY - pos.y, mouseX - pos.x));
    fill(0);
    rect(18, 0, 15, 6);
    popMatrix();
    
    rectMode(CORNER);
  }
}
