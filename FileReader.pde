import ddf.minim.*;

class FileReader {
  BufferedReader reader;

  
  //OBSTACLES
  StringList obstacleOrSpeed = new StringList();
  StringList obstacleOrSpeedType = new StringList();
  IntList typeTime = new IntList();
  
  //BEATS
  StringList beatType = new StringList();
  IntList beatTime = new IntList();
  
  void loadObstaclesFromFile(String file) {
    reader = createReader(file);
    String line = null;
    try {
      while ((line = reader.readLine()) != null) {
        String[] pieces = split(line, ',');
        if(pieces[0].equals("end")) {
          obstacleOrSpeed.append("end");
          obstacleOrSpeedType.append("end");
          typeTime.append(-2);
          break;
        }
        obstacleOrSpeed.append(pieces[0]);
        obstacleOrSpeedType.append(pieces[1]);
        typeTime.append(int(pieces[2]));
        println(pieces[0], pieces[1], int(pieces[2]));
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  
  void loadBeatsFromFile(String file) {
    reader = createReader(file);
    String line = null;
    try {
      while ((line = reader.readLine()) != null) {
        String[] pieces = split(line, ',');
        if(pieces[0].equals("end")) {
          beatType.append("end");
          beatTime.append(-2);
          break;
        }
        beatType.append(pieces[0]);
        beatTime.append(int(pieces[1]));
        println(pieces[0], int(pieces[1]));
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  StringList getBeatType() {
    return beatType;
  }
  
  IntList getBeatTime() {
    return beatTime;
  }
  
  StringList getObstacleOrSpeed() {
    return obstacleOrSpeed;
  }
  
  StringList getObstacleOrSpeedType() {
    return obstacleOrSpeedType;
  }
  
  IntList getTypeTime() {
    return typeTime;
  }
  
}
