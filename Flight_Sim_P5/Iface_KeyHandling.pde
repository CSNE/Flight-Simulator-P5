HashMap<Integer, Boolean> codedKeys = new HashMap<Integer, Boolean>();
HashMap<Character, Boolean> keys = new HashMap<Character, Boolean>();

void keyAction() {
  if (keyDown('q')) {
    ap.changeThrust(0.1);
  } else if (keyDown('a')) {
    ap.changeThrust(-0.1);
  }
  if (keyDown(LEFT)) {
    ap.changeRotation(0.01);
  } else if (keyDown(RIGHT)) {
    ap.changeRotation(-0.01);
  }

  if (keyDown(UP)) {
    ap.changePitch(0.01);
  } else if (keyDown(DOWN)) {
    ap.changePitch(-0.01);
  }

  if (keyDown('z')) {
    ap.changeYaw(-0.01);
  } else if (keyDown('x')) {
    ap.changeYaw(0.01);
  }

  if (keyDown('w')) {
    ap.getWings().changeFlaps(0.01);
  } else if (keyDown('s')) {
    ap.getWings().changeFlaps(-0.01);
  }


  ap.turbo(keyDown('3'));

  if (keyDown('2')) ap.setThrust(0);

  if (keyDown('1')) ap.reset();
} /* keyAction */

boolean keyDown(int charCode) {
  if (codedKeys.get(charCode) == null) return false;
  else return codedKeys.get(charCode);
}
boolean keyDown(char chr) {
  if (keys.get(Character.toUpperCase(chr)) == null) return false;
  else return keys.get(Character.toUpperCase(chr));
}

void keyPressed() {
  if (key == CODED) {
    if (!codedKeys.containsKey(keyCode)) { // Doesn't contain the key -- create a new entry.
    }
    codedKeys.put(keyCode, true);
  } else {
    if (!keys.containsKey(Character.toUpperCase(key))) { // Doesn't contain the key -- create a new entry.
    }
    keys.put(Character.toUpperCase(key), true);
  }
}

void keyReleased() {
  if (key == CODED) {
    codedKeys.put(keyCode, false);
  } else {
    keys.put(Character.toUpperCase(key), false);
  }
}