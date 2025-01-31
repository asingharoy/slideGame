class Scoreboard {
  JSONArray scores;
  JSONObject scoreObject;
  int lowestScoreIndex;
  int lowestScore;

  String chooseAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ<>-+=?/\\|";
  String text = "ABCDE";
  boolean sameName = false;

  int textI = 0;

  int chooserI1 = 0;
  int chooserI2 = 1;
  int chooserI3 = 2;
  int chooserI4 = 3;
  int chooserI5 = 4;

  float pointerX = width/2;
  float pointerY = height/2;

  boolean inputRecorded = false;

  IntDict scoreIntDict;
  IntList scoreInt;
  StringList scoreName;

  Scoreboard() {
    scores = loadJSONArray("data/scoreMap.json");
    scoreObject = new JSONObject();
    scoreIntDict = new IntDict();

    for (int i = 0; i < scores.size(); i++) {
      scoreIntDict.set(scores.getJSONObject(i).getString("name"), scores.getJSONObject(i).getInt("score"));
    }
    scoreIntDict.sortValuesReverse();
    scoreInt = new IntList(scoreIntDict.valueArray());
    scoreName = new StringList(scoreIntDict.keyArray());
  }

  void display() {
    textAlign(LEFT);
    textSize(35);
    for (int i = 0; i < scoreName.size(); i++) {
      if (i > 9) break;
      text(scoreName.get(i) + "                        " + scoreInt.get(i), 150, 350 + 45*i);
    }
    textAlign(RIGHT);
    for (int i = 10; i < scoreName.size(); i++) {
      text(scoreName.get(i) + "                        " + scoreInt.get(i), width - 150, 350 + 45*(i-10));
    }
    textAlign(CENTER);
    text("TOP    10", 150, 305);
    text("11-20", width - 150, 305);
  }

  void input() {

    if (!inputRecorded) {

      textI = constrain(textI, 0, 4);
      chooserI1 = constrain(chooserI1, 0, 34);
      chooserI2 = constrain(chooserI2, 0, 34);
      chooserI3 = constrain(chooserI3, 0, 34);
      chooserI4 = constrain(chooserI4, 0, 34);
      chooserI5 = constrain(chooserI5, 0, 34);
      sameName = false;

      textAlign(CENTER);
      textSize(70);
      pointerX = (width/2)+(textI-2)*textWidth('B');
      pointerY = (height/2)-100;
      triangle(pointerX, pointerY + 10, pointerX - 10, pointerY - 10, pointerX + 10, pointerY - 10);
      fill(#DE69D8);
      text("" + (char) chooseAlphabet.charAt(chooserI1) + (char) chooseAlphabet.charAt(chooserI2) + (char) chooseAlphabet.charAt(chooserI3) + (char) chooseAlphabet.charAt(chooserI4) + (char) chooseAlphabet.charAt(chooserI5), width/2, height/2);


      if (key1) {
        textI = 0;
        text = "" + (char) chooseAlphabet.charAt(chooserI1) + (char) chooseAlphabet.charAt(chooserI2) + (char) chooseAlphabet.charAt(chooserI3) + (char) chooseAlphabet.charAt(chooserI4) + (char) chooseAlphabet.charAt(chooserI5);

        for (int i = 0; i < scores.size(); i++) {
          if (text.equals(scores.getJSONObject(i).getString("name"))) {
            sameName = true;
            if (score > scores.getJSONObject(i).getInt("score")) {
              scores.getJSONObject(i).setInt("score", score);
            }
            break;
          }
        }

        if (!sameName) {
          scoreObject.setInt("id", scores.size());
          scoreObject.setString("name", text);
          scoreObject.setInt("score", score);
          scores.setJSONObject(scores.size(), scoreObject);
        }

        saveJSONArray(scores, "data/scoreMap.json");

        for (int i = 0; i < scores.size(); i++) {
          scoreIntDict.set(scores.getJSONObject(i).getString("name"), scores.getJSONObject(i).getInt("score"));
        }
        scoreIntDict.sortValuesReverse();


        if (scores.size() > 20) {
          lowestScore = scoreIntDict.valueArray()[scoreIntDict.size()-1];

          for (int i = 0; i < scores.size(); i++) {
            if (scores.getJSONObject(i).getInt("score") == lowestScore) {
              scores.remove(i);
              break;
            }
          }

          saveJSONArray(scores, "data/scoreMap.json");
        }

        scoreInt = new IntList(scoreIntDict.valueArray());
        scoreName = new StringList(scoreIntDict.keyArray());

        inputRecorded = true;
      }
      
      if (key2) {
        inputRecorded = true;
      }

      if (keyA) {
        textI--;
        keyA = false;
      }
      if (keyD) {
        textI++;
        keyD = false;
      }

      if (keyW) {
        switch(textI) {
        case 0:
          chooserI1--;
          break;
        case 1:
          chooserI2--;
          break;
        case 2:
          chooserI3--;
          break;
        case 3:
          chooserI4--;
          break;
        case 4:
          chooserI5--;
          break;
        default:
          break;
        }
        keyW = false;
      }
      if (keyS) {
        switch(textI) {
        case 0:
          chooserI1++;
          break;
        case 1:
          chooserI2++;
          break;
        case 2:
          chooserI3++;
          break;
        case 3:
          chooserI4++;
          break;
        case 4:
          chooserI5++;
          break;
        default:
          break;
        }
        keyS = false;
      }
    }
  }
}
