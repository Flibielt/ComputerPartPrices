void displayColumnDiagram(float x, float y, Stock stock) {
}

void displayTwoScrollbar() {
  hs1.xpos = WINDOW_LEFT_COLUMN + 5 * MARGIN;
  hs1.ypos = DATE_PICKER_Y;

  hs2.xpos = WINDOW_LEFT_COLUMN + 5 * MARGIN;
  hs2.ypos = DATE_PICKER_Y - 3 * MARGIN;

  hs1.update();
  selectedDate = hs1.date;
  hs1.display();

  hs2.update();
  dateFrom = hs2.date;
  hs2.display();
}
