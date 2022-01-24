void initScrollbar() {
  float x = WINDOW_LEFT_COLUMN + 5 * MARGIN;
  float y = DATE_PICKER_Y;

  hs1 = new HScrollbar(x, y, int(WINDOW_RIGHT_COLUMN), int(DATE_PICKER_HEIGHT), 1);
  hs2 = new HScrollbar(x, y + SMALL_MARGIN + DATE_PICKER_HEIGHT, int(WINDOW_RIGHT_COLUMN), int(DATE_PICKER_HEIGHT), 1);
}

void displayScrollbar() {
  hs1.xpos = WINDOW_LEFT_COLUMN + 5 * MARGIN;
  hs1.ypos = DATE_PICKER_Y + DATE_PICKER_HEIGHT + MARGIN;

  hs1.update();
  hs1.display();
  
  if (twoSilderWithLineDiagram) {
    hs2.xpos = WINDOW_LEFT_COLUMN + 5 * MARGIN;
    hs2.ypos = DATE_PICKER_Y;

    hs2.update();
    hs2.display();
  }
}
