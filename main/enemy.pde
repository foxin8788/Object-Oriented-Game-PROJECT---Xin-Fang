class Enemy {
  PVector pos; // Enemy position
  PVector vel; // Enemy speed
  PVector acc; // Enemy acceleration
  
  float maxSpeed = 1.6; // Enemy maximum speed
  float size = 20; // Enemy size
  
  Enemy(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  // Update enemies
  void update(PVector target) {
    // Calculate player direction
    PVector desired = PVector.sub(target, pos);
    desired.normalize(); // Unit vector
    desired.mult(0.08); // Controls the magnitude of acceleration
    
    acc = desired; // Set acceleration
    vel.add(acc); // Velocity += Acceleration
    vel.limit(maxSpeed); // Limit speed
    pos.add(vel); // Update position
  }
  // Calculate player direction
  void display() {
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y);
    
    // body
    fill(255);
    stroke(0);
    strokeWeight(2);
    beginShape();
    vertex(0, -size/2);
    vertex(size/2, -size/4);
    vertex(size/3, size/6);
    vertex(size/2, size/2);
    vertex(0, size/3);
    vertex(-size/3, size/2);
    vertex(-size/4, size/6);
    vertex(-size/2, -size/4);
    endShape(CLOSE);
    
    // eyes
    noStroke();
    fill(0);
    ellipse(-size*0.15, -size*0.1, size*0.2, size*0.35);
    ellipse(size*0.15, 0, size*0.2, size*0.35);
    
    popMatrix();
  }
}
