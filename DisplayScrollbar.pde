void initScrollbar() {
  float x = WINDOW_LEFT_COLUMN + 5 * MARGIN;
  float y = DATE_PICKER_Y;

  hs1 = new HScrollbar(x, y, int(WINDOW_RIGHT_COLUMN), int(DATE_PICKER_HEIGHT), 1);
}

void displayScrollbar() {
  hs1.update();
  hs1.display();
}
