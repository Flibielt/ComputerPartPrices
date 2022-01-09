void displayComputerPartNames() {
  noFill();
  rect(MARGIN, MARGIN, WINDOW_LEFT_COLUMN, COMPUTER_PARTS_HEIGHT);
  fill(0);
  textSize(NORMAL_TEXT_SIZE);
  text("Komponensek", MARGIN + SMALL_MARGIN, MARGIN + MARGIN);
}

void displayStockData() {
  float y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN;
  noFill();
  rect(MARGIN, y, WINDOW_LEFT_COLUMN, STOCK_DATA_HEIGHT);
  fill(0);
  textSize(NORMAL_TEXT_SIZE);
  text("Tőzsde", MARGIN + SMALL_MARGIN, y + MARGIN);
}

void displayEventList() {
  float y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN + STOCK_DATA_HEIGHT + MARGIN;
  noFill();
  rect(MARGIN, y, WINDOW_LEFT_COLUMN, EVENT_LIST_HEIGHT);
  fill(0);
  textSize(NORMAL_TEXT_SIZE);
  text("Események", MARGIN + SMALL_MARGIN, y + MARGIN);
}

void displayLeftColumn() {
  displayComputerPartNames();
  displayStockData();
  displayEventList();
}
