class Player {
  boolean playerStateX = false;
  boolean playerStateY = false;
  boolean isAlive = true;
  boolean firstTime = true;

  float xSize = 250;
  float ySize = 200;
  float zSize = 200;
  float playerX = width/2 - xSize;
  float playerY = height/2 - ySize;
  float playerZ = 150;
  float playerSpeed = (2*xSize*20)/frameRate;

  float health = 1;

  int timesHit = 0;

  Player() {
  }


  void display() {
    if (isAlive) {
      push();
      translate(playerX, playerY, playerZ);
      fill(255);
      stroke(0);
      strokeWeight(10);
      box(xSize, ySize, zSize);
      pop();
    }
    noStroke();
    fill(#DE69D8);
    rect(width/2, height - 100, 700, 30, 3, 3, 3, 3);
    rectMode(CORNER);
    fill(255);
    rect((width/2) - 350, height - 115, health*700, 30, 3, 3, 3, 3);
    rectMode(CENTER);

    if (isAlive) {
      health += 0.05/frameRate;
    }
    health = constrain(health, 0, 1);
  }

  void movement() {
    if (isAlive) {
      if (!playerStateX) {
        playerX -= playerSpeed;
      } else {
        playerX += playerSpeed;
      }
      if (!playerStateY) {
        playerY -= playerSpeed;
      } else {
        playerY += playerSpeed;
      }

      playerX = constrain(playerX, width/2 - xSize, width/2 + xSize);
      playerY = constrain(playerY, height/2 - ySize, height/2 + ySize);
    }
  }

  void collision(ArrayList<Obstacle> obstacles) {
    if (isAlive) {
      for (int i = 0; i < obstacles.size(); i++) {
        if (obstacles.get(i) != null) {

          if (playerZ + zSize/2 > obstacles.get(i).z - obstacles.get(i).zSize/2 && playerZ - zSize/2 < obstacles.get(i).z + obstacles.get(i).zSize/2) {
            if (playerX + xSize/2 > obstacles.get(i).x - obstacles.get(i).xSize/2 && playerX - xSize/2 < obstacles.get(i).x + obstacles.get(i).xSize/2 &&
              playerY + ySize/2 > obstacles.get(i).y - obstacles.get(i).ySize/2 && playerY - ySize/2 < obstacles.get(i).y + obstacles.get(i).ySize/2) {

              timesHit++;
              health -= 0.34;
              obstacles.remove(i);
              if (health <= 0) {
                isAlive = false;
                scoreboard.inputRecorded = false;
                music.stopGameMusic(creo_Mantarave);
              }
            }
          }
        }
      }
    }
  }
}
