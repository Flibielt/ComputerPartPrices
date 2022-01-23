/**
 * Scrollbar.
 * 
 * Source: https://processing.org/examples/scrollbar.html
 */
class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  int daysBetween;
  LocalDate date;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    loose = l;

    reset();
  }

  void reset() {
    int plusDay;

    spos = xpos + swidth / 2 - sheight / 2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;

    daysBetween = int(getDaysBetween(globalMinDate, globalMaxDate));
    plusDay = int(map(spos, xpos, xpos + swidth, 0, daysBetween));
    date = globalMinDate.plusDays(plusDay);
  }

  void update() {
    int plusDay;

    daysBetween = int(getDaysBetween(globalMinDate, globalMaxDate));
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }

    plusDay = int(map(spos, xpos, xpos + swidth - sheight, 0, daysBetween));
    date = globalMinDate.plusDays(plusDay);
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    rectMode(CORNER);
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);

    fill(0);
    if (columnDiagram) {
      textSize(15);
      textAlign(LEFT);
      text(globalMinDate.toString(), xpos, ypos + sheight + 20);

      textAlign(RIGHT);
      text(globalMaxDate.toString(), xpos + swidth, ypos + sheight + 20);
    }

    stroke(0);
    textAlign(LEFT);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
