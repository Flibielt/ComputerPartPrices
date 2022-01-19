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

// Selected data limits
double stockMaxPrice = 0;
int computerPartMaxPrice = 0;
LocalDate globalMinDate, globalMaxDate;

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
  WINDOW_RIGHT_COLUMN = width - WINDOW_LEFT_COLUMN - 3 * MARGIN;
  COMPUTER_PARTS_HEIGHT = height / 2.25;
  STOCK_DATA_HEIGHT = height / 5;
  EVENT_LIST_HEIGHT = height / 4;
  CHECKBOX_WIDTH = height / 100;
  DATE_PICKER_HEIGHT = height / 14;
  PLOT_HEIGHT = (height - DATE_PICKER_HEIGHT - 6 * MARGIN) / 2;
  PRODUCT_PLOT_Y = MARGIN;
  STOCK_PLOT_Y = MARGIN + PLOT_HEIGHT + MARGIN;
  DATE_PICKER_Y = MARGIN + PLOT_HEIGHT + MARGIN + PLOT_HEIGHT + MARGIN;

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

  for (Stock stock : stocks) {
    if (stock.selected) {
      if (stock.maxPrice > stockMaxPrice) {
        stockMaxPrice = stock.maxPrice;
      }
      
      if (stock.maxDate.isAfter(globalMaxDate)) {
        globalMaxDate = stock.maxDate;
      } else if (stock.minDate.isBefore(globalMinDate)) {
        globalMinDate = stock.minDate;
      }
    }
  }

  // Default values, so the plot can be drawn
  if (stockMaxPrice < 1) {
    stockMaxPrice = 100;
  }
}

void findMaxComputerPartPrice() {
  computerPartMaxPrice = 0;
  for (ComputerPart computerPart : computerParts) {
    if (computerPart.selected) {
      if (computerPart.maxPrice > computerPartMaxPrice) {
        computerPartMaxPrice = computerPart.maxPrice;
      }
      
      if (computerPart.maxDate.isAfter(globalMaxDate)) {
        globalMaxDate = computerPart.maxDate;
      } else if (computerPart.minDate.isBefore(globalMinDate)) {
        globalMinDate = computerPart.minDate;
      }
    }
  }

  // Default values, so the plot can be drawn
  if (computerPartMaxPrice < 1) {
    computerPartMaxPrice = 100000;
  }
}

long getDaysBetween(LocalDate date1, LocalDate date2) {
  if (date1.isBefore(date2)) {
    return ChronoUnit.DAYS.between(date1, date2);
  }
  return ChronoUnit.DAYS.between(date2, date1);
}
