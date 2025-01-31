class Obstacle {
  float xSize = 250;
  float ySize = 200;
  float zSize = 200;
  float x = width/2 - xSize;
  float y = height/2 - ySize;
  float z = -5000;
  float speed = 70;

  float initialZ;

  boolean used = false;

  Obstacle() {
    initialZ = z;
  }

  void display() {
    push();
    translate(x, y, z);
    fill(255);
    stroke(255, 0, 0);
    strokeWeight(3);
    box(xSize, ySize, zSize);
    pop();
  }

  void movement() {
    if (z > 1000 || used == true) {
      y = -500;
      used = true;
    }
    z-=initialZ/frameRate;
  }
}
