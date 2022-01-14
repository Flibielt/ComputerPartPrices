// Scales
float MARGIN = 0;
float SMALL_MARGIN = 0;
float WINDOW_LEFT_COLUMN = 0;
float WINDOW_RIGHT_COLUMN = 0;
float COMPUTER_PARTS_HEIGHT = 0;
float STOCK_DATA_HEIGHT = 0;
float EVENT_LIST_HEIGHT = 0;
float SMALL_TEXT_SIZE = 0;
float NORMAL_TEXT_SIZE = 0;
float CHECKBOX_WIDTH = 0;

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

// Colors
color green = color(124,252,0);

LocalDate parseDate(String s) {
  return LocalDate.parse(s, formatter);
}

void calculateElementSizes() {
  MARGIN = width / 100;
  SMALL_MARGIN = MARGIN / 2;
  WINDOW_LEFT_COLUMN =  width / 4;
  WINDOW_RIGHT_COLUMN = width - WINDOW_LEFT_COLUMN;
  COMPUTER_PARTS_HEIGHT = height / 2.25;
  STOCK_DATA_HEIGHT = height / 5;
  EVENT_LIST_HEIGHT = height / 4;
  CHECKBOX_WIDTH = height / 100;

  SMALL_TEXT_SIZE = width / 125;
  NORMAL_TEXT_SIZE = width / 100;
}

boolean isMouseInComponentListArea() {
  return mouseX > MARGIN && mouseX < MARGIN + COMPUTER_PARTS_HEIGHT && mouseY > MARGIN && mouseY < MARGIN + WINDOW_LEFT_COLUMN;
}

boolean isMouseInStockListArea() {
  float stockY = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN;
  return mouseX > MARGIN && mouseX < WINDOW_LEFT_COLUMN && mouseY > stockY && mouseY < stockY + STOCK_DATA_HEIGHT;
}

boolean isMouseInEventListArea() {
  float eventY = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN + STOCK_DATA_HEIGHT + MARGIN;
  return mouseX > MARGIN && mouseX < WINDOW_LEFT_COLUMN && mouseY > eventY && mouseY < eventY + EVENT_LIST_HEIGHT;
}
