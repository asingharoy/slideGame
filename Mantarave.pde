class Mantarave {

  float pulsing = 0;
  boolean beforePulse = false;
  int i1 = 0;
  int timeOfArrival = 1000;
  boolean obstacleOrSpeed; //TRUE for obstacle, FALSE for speed

  int initialZ;
  int z;

  int millisPast;

  void display() {

    background(mantaraveBackground);


    for (int i = 0; i < obstacles.size(); i++) {
      if (obstacles.get(i) != null) {
        obstacles.get(i).display();
        obstacles.get(i).movement();
      }
    }

    for (int i = obstacles.size() - 1; i >= 0; i--) {
      if (obstacles.get(i) != null) {
        if (obstacles.get(i).used) {
          obstacles.remove(i);
        }
      }
    }
  }

  void update() {

    //UPDATE

    pulse = lerpColor(color(#DE69D8, 1), color(#DE69D8, 120), pulsing);

    if (!music.detectBeat(creo_Mantarave).equals("none") && music.positionGameMusic(creo_Mantarave) < 228000) {
      beforePulse = true;
    }

    if (beforePulse) {
      pulsing += 0.1;
      if (pulsing >= 1.0) {
        beforePulse = false;
      }
    }



    pulsing = constrain(pulsing*0.95, 0, 2);

    if (!detectBeat(music.positionGameMusic(creo_Mantarave) + timeOfArrival*1.5).equals("none") && music.positionGameMusic(creo_Mantarave) < 228000) {
      i1--;
      if (obstacleOrSpeed) {
        Obstacle newObstacle = new Obstacle();
        obstacles.add(newObstacle);

        newObstacle.initialZ = initialZ;
        newObstacle.z = z;

        switch(detectBeat(music.positionGameMusic(creo_Mantarave) + timeOfArrival*1.5)) {
        case "top-left":
          newObstacle.xSize = 250;
          newObstacle.ySize = 200;
          newObstacle.x = width/2 - 250;
          newObstacle.y = height/2 - 200;
          break;
        case "top-right":
          newObstacle.xSize = 250;
          newObstacle.ySize = 200;
          newObstacle.x = width/2 + 250;
          newObstacle.y = height/2 - 200;
          break;
        case "bottom-left":
          newObstacle.xSize = 250;
          newObstacle.ySize = 200;
          newObstacle.x = width/2 - 250;
          newObstacle.y = height/2 + 200;
          break;
        case "bottom-right":
          newObstacle.xSize = 250;
          newObstacle.ySize = 200;
          newObstacle.x = width/2 + 250;
          newObstacle.y = height/2 + 200;
          break;
        case "up":
          newObstacle.xSize = 750;
          newObstacle.ySize = 200;
          newObstacle.x = width/2;
          newObstacle.y = height/2 - 200;
          break;
        case "down":
          newObstacle.xSize = 750;
          newObstacle.ySize = 200;
          newObstacle.x = width/2;
          newObstacle.y = height/2 + 200;
          break;
        case "left":
          newObstacle.xSize = 250;
          newObstacle.ySize = 600;
          newObstacle.x = width/2 - 250;
          newObstacle.y = height/2;
          break;
        case "right":
          newObstacle.xSize = 250;
          newObstacle.ySize = 600;
          newObstacle.x = width/2 + 250;
          newObstacle.y = height/2;
          break;
        }
      } else {
        switch(detectBeat(music.positionGameMusic(creo_Mantarave) + timeOfArrival*1.5)) {
        case "slow":
          initialZ=-10000;
          z=-10000;
          timeOfArrival = 1000;
          break;
        case "medium":
          initialZ=-15000;
          z=-10000;
          timeOfArrival = 667;
          break;
        case "fast":
          initialZ=-20000;
          z=-10000;
          timeOfArrival = 500;
          break;
        }
      }
    }
  }

  void finishScreen() {
    if (music.positionGameMusic(creo_Mantarave) > 228000) {
      if (millis() < millisPast + 7000) {
        fill(#DE69D8);
        textSize(100);
        textAlign(CENTER);
        text("MANTARAVE\nSong by Creo", width/2, height/2);
      } else {
        player.isAlive = false;
        scoreboard.input();
      }
    } else {
      millisPast = millis();
    }
  }

  String detectBeat(float time) {
    if (Math.abs(fileReader.getTypeTime().get(i1) - time) <= 50) {
      i1++;
      println(i1);
      if (fileReader.getObstacleOrSpeed().get(i1 - 1).equals("obstacle")) {
        obstacleOrSpeed = true;
        println(fileReader.getObstacleOrSpeedType().get(i1 - 1));
        return fileReader.getObstacleOrSpeedType().get(i1 - 1);
      } else if (fileReader.getObstacleOrSpeed().get(i1 - 1).equals("speedCheckpoint")) {
        println("speed");
        obstacleOrSpeed = false;
        return fileReader.getObstacleOrSpeedType().get(i1 - 1);
      } else {
        return "none";
      }
    } else {
      return "none";
    }
  }
}
