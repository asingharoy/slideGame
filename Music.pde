import ddf.minim.*;

class Music {
  FileReader fileReader;
  boolean playingGameMusic = false;
  int i1 = 0;


  Music(FileReader fileReader) {
    this.fileReader = fileReader;
  }

  void playGameMusic(AudioPlayer file) {
    if (playingGameMusic) {
      return;
    }
    if (!playingGameMusic) {
      file.play(0);
      playingGameMusic = true;
    }
  }

  void stopGameMusic(AudioPlayer file) {
    if (!playingGameMusic) {
      return;
    }
    if (playingGameMusic) {
      file.pause();
      playingGameMusic = false;
    }
  }

  void toggleGameMusic(AudioPlayer file) {
    if (!playingGameMusic) {
      file.play(0);
      playingGameMusic = true;
    }

    if (playingGameMusic) {
      file.pause();
      playingGameMusic = false;
    }
  }
  
  void playSFX(AudioPlayer file) {
    file.play(0);
  }
  
  String detectBeat(AudioPlayer file) {
    if (Math.abs(fileReader.getBeatTime().get(i1) - music.positionGameMusic(file) - mantaraveLevel.timeOfArrival*0.75) <= 50) {
      i1++;
      if (fileReader.getBeatType().get(i1).equals("beat")) {
        return "beat";
      } else
      if (fileReader.getBeatType().get(i1).equals("checkpoint")) {
        return "checkpoint";
      } else {
        return "none";
      }
    } else {
      return "none";
    }
  }

  int returnBeatNum() {
    return i1;
  }

  int positionGameMusic(AudioPlayer file) { //Make sure to call only after playing the exact same file
    return file.position();
  }
  
  int musicLength(AudioPlayer file) {
    return file.length();
  }
}
