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
float PLOT_HEIGHT = 0;
float PLOT_WIDTH = 0;
float DATE_PICKER_HEIGHT = 0;
float PRODUCT_PLOT_Y = 0;
float STOCK_PLOT_Y = 0;
float DATE_PICKER_Y = 0;
float COLUMN_DIAGRAM_HEIGHT = 0;
float COLUMN_DIAGRAM_WIDTH = 0;
float GLOBAL_EVENT_ONE_DAY_DEFAULT_WIDTH;
float GLOBAL_EVENT_ONE_DAY_THICKER_WIDTH;

// Selected data limits
double stockMaxPrice = 0;
int computerPartMaxPrice = 0;
LocalDate globalMinDate, globalMaxDate;
boolean computerPartSelected, stockSelected;
int MAX_DAY_DIFFERENCE = 7;
int VOLUME_COUNT = 5;
int TIME_LABEL_COUNT = 8;

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DateTimeFormatter dateDisplayFormatter = DateTimeFormatter.ofPattern("yyyy. MM. dd.");

// Colors
color GREEN_COLOR = color(124,252,0);
color GOLD_COLOR = color(255,215,0);
color SILICON_COLOR = color(192,192,192);
color ETHEREUM_COLOR = color(54,117,136);
color BITCOIN_COLOR = color(255,165,0);
color EVENT_RED = color(220,20,60);
color PERIOD_RED = color(250,128,114);
color[] baseColors = {color(255,0,0), color(0,255,0), color(0,0,255), color(0,100,0), color(0,255,255), color(255,0,255)};
int DEFAULT_STROKE = 224;
int DEFAULT_STROKE_WIDTH = 1;
int THICKER_STROKE = 3;

LocalDate parseDate(String s) {
  return LocalDate.parse(s, formatter);
}

color generateRandomColor() {
  return color(random(255), random(255), random(255));
}

void calculateElementSizes() {
  MARGIN = width / 100;
  SMALL_MARGIN = MARGIN / 2;
  WINDOW_LEFT_COLUMN =  width / 4;
  WINDOW_RIGHT_COLUMN = width - WINDOW_LEFT_COLUMN - 7 * MARGIN;
  COMPUTER_PARTS_HEIGHT = height / 2.25;
  STOCK_DATA_HEIGHT = height / 5;
  EVENT_LIST_HEIGHT = height / 7;
  CHECKBOX_WIDTH = height / 100;
  DATE_PICKER_HEIGHT = height / 75;
  PLOT_HEIGHT = ((height - DATE_PICKER_HEIGHT - 6 * MARGIN) / 2) - 2 * MARGIN;
  PRODUCT_PLOT_Y = MARGIN;
  STOCK_PLOT_Y = MARGIN + PLOT_HEIGHT + 3 * MARGIN;
  DATE_PICKER_Y = MARGIN + PLOT_HEIGHT + MARGIN + PLOT_HEIGHT + 4 * MARGIN;
  COLUMN_DIAGRAM_HEIGHT = height / 4;
  COLUMN_DIAGRAM_WIDTH = width / 6;

  GLOBAL_EVENT_ONE_DAY_DEFAULT_WIDTH = 1;
  GLOBAL_EVENT_ONE_DAY_THICKER_WIDTH = 3;

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

void findMaxStockPrice() {
  stockMaxPrice = 0;
  stockSelected = false;
  if (!computerPartSelected) {
    globalMaxDate = parseDate("2000-01-01");
    globalMinDate = parseDate("2022-11-31");
  }

  for (Stock stock : stocks) {
    if (stock.selected) {
      stockSelected = true;
      if (stock.maxPrice > stockMaxPrice) {
        stockMaxPrice = stock.maxPrice;
      }
      
      if (stock.maxDate.isAfter(globalMaxDate)) {
        globalMaxDate = stock.maxDate;
      }
      if (stock.minDate.isBefore(globalMinDate)) {
        globalMinDate = stock.minDate;
      }
    }
  }

  // Default values, so the plot can be drawn
  if (stockMaxPrice < 1) {
    stockMaxPrice = 100;
  }

  if (computerPartSelected && !stockSelected) {
    findMaxComputerPartPrice();
  }
}

void findMaxComputerPartPrice() {
  computerPartMaxPrice = 0;
  computerPartSelected = false;
  if (!stockSelected) {
    globalMaxDate = parseDate("2000-01-01");
    globalMinDate = parseDate("2022-11-31");
  }

  for (ComputerPart computerPart : computerParts) {
    if (computerPart.selected) {
      computerPartSelected = true;
      if (computerPart.maxPrice > computerPartMaxPrice) {
        computerPartMaxPrice = computerPart.maxPrice;
      }
      
      if (computerPart.maxDate.isAfter(globalMaxDate)) {
        globalMaxDate = computerPart.maxDate;
      }
      if (computerPart.minDate.isBefore(globalMinDate)) {
        globalMinDate = computerPart.minDate;
      }
    }
  }

  // Default values, so the plot can be drawn
  if (computerPartMaxPrice < 1) {
    computerPartMaxPrice = 100000;
  }

  if (stockSelected && !computerPartSelected) {
    findMaxStockPrice();
  }
}

long getDaysBetween(LocalDate date1, LocalDate date2) {
  if (date1.isBefore(date2)) {
    return ChronoUnit.DAYS.between(date1, date2);
  }
  return ChronoUnit.DAYS.between(date2, date1);
}

boolean isDayBetweenSelectedDates(LocalDate date) {
  if (globalMinDate.isBefore(date) || globalMinDate.equals(date)) {
    if (globalMaxDate.isAfter(date) || globalMaxDate.equals(date)) {
      return true;
    }
  }

  return false;
}

String formatNumber(int number) {
  return String.format("%,d %n", number);
}

String formatNumber(float number) {
  return formatNumber(floor(number));
}

String formatNumber(double number) {
  return formatNumber((int)number);
}
