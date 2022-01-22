int MAX_TEXT_COUNT = 50;
int computerPartStartIndex = 0;

void displayComputerPartNames() {
  float textX = MARGIN + SMALL_MARGIN;
  float textY = MARGIN + MARGIN;

  noFill();
  rect(MARGIN, MARGIN, WINDOW_LEFT_COLUMN, COMPUTER_PARTS_HEIGHT);
  fill(0);
  textSize(NORMAL_TEXT_SIZE);
  text("Komponensek (Forint)", textX, textY);

  for (ComputerPart computerPart : computerParts) {
    computerPart.displayed = false;
  }

  for (ComputerPartType computerPartType : computerPartTypes) {
    computerPartType.displayed = false;
  }

  String type = "";
  for (int i = computerPartStartIndex; i < computerParts.size(); i++) {
    ComputerPart c = computerParts.get(i);
    textY += MARGIN;

    if (textY + textAscent() >= COMPUTER_PARTS_HEIGHT) {
      break;
    }

    if (!type.equals(c.type)) {
      // Display component type
      type = c.type;
      textSize(NORMAL_TEXT_SIZE);
      textY += SMALL_MARGIN;
      text(c.type + ":", textX + CHECKBOX_WIDTH + SMALL_MARGIN / 2, textY);

      for (ComputerPartType computerPartType : computerPartTypes) {
        if (computerPartType.name.equals(type)) {
          computerPartType.displayed = true;
          computerPartType.x = textX;
          computerPartType.y = textY - NORMAL_TEXT_SIZE / 2;

          if (computerPartType.selected) {
            fill(GREEN_COLOR);
          } else {
            fill(255);
          }
          rect(textX, textY - NORMAL_TEXT_SIZE / 2, CHECKBOX_WIDTH, CHECKBOX_WIDTH);
          fill(0);
          break;
        }
      }

      textY += MARGIN;
    }

    if (textY + textAscent() >= COMPUTER_PARTS_HEIGHT) {
      break;
    }

    int charCount = (c.name.length() >= MAX_TEXT_COUNT) ? MAX_TEXT_COUNT : c.name.length();
    String name = "";
    noFill();
    if (c.selected) {
      name = c.name.substring(0, charCount) + ": " + formatNumber(c.getPrice(selectedDate));
      fill(c.displayedColor);
    } else {
      name = c.name.substring(0, charCount);
      noFill();
    }
    textSize(NORMAL_TEXT_SIZE);
    circle(textX + SMALL_MARGIN + MARGIN + textAscent() / 9, textY - textAscent() / 4, textAscent() / 2);
    fill(0);
    textSize(SMALL_TEXT_SIZE);
    text(name, textX + SMALL_MARGIN + MARGIN + textAscent() / 2, textY);

    if (c.selected) {
      fill(GREEN_COLOR);
    } else {
      fill(255);
    }
    rect(textX + SMALL_MARGIN, textY - NORMAL_TEXT_SIZE / 2, CHECKBOX_WIDTH, CHECKBOX_WIDTH);
    fill(0);

    c.x = textX + SMALL_MARGIN;
    c.y = textY - NORMAL_TEXT_SIZE / 2;
    c.displayed = true;
  }
}

void displayStockData() {
  float y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN;
  float textX = MARGIN + SMALL_MARGIN;
  float textY = y + MARGIN;

  noFill();
  rect(MARGIN, y, WINDOW_LEFT_COLUMN, STOCK_DATA_HEIGHT);
  
  fill(0);
  textSize(NORMAL_TEXT_SIZE);
  text("Tőzsde (Dollár)", textX, textY);
  textY += MARGIN + SMALL_MARGIN;

  for (Stock stock : stocks) {
    String name = "";
    noFill();
    if (stock.selected) {
      name = stock.name + ": " + formatNumber(stock.getPrice(selectedDate));
      fill(stock.displayedColor);
    } else {
      name = stock.name;
      noFill();
    }
    circle(textX + CHECKBOX_WIDTH + SMALL_MARGIN / 2 + textAscent() / 7.5, textY - textAscent() / 4, textAscent() / 2);
    fill(0);
    text(name, textX + CHECKBOX_WIDTH + SMALL_MARGIN / 2 + textAscent() / 2, textY);
    
    if (stock.selected) {
      fill(GREEN_COLOR);
    } else {
      fill(255);
    }
    rect(textX, textY - NORMAL_TEXT_SIZE / 2, CHECKBOX_WIDTH, CHECKBOX_WIDTH);
    stock.x = textX;
    stock.y = textY - NORMAL_TEXT_SIZE / 2;

    fill(0);
    textY += MARGIN;
  }
}

void displayEventList() {
  float y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN + STOCK_DATA_HEIGHT + MARGIN;
  float textX = MARGIN + SMALL_MARGIN;
  float textY = y + MARGIN;
  
  noFill();
  rect(MARGIN, y, WINDOW_LEFT_COLUMN, EVENT_LIST_HEIGHT);
  fill(0);
  textSize(NORMAL_TEXT_SIZE);
  text("Események", textX, textY);

  textY += MARGIN + SMALL_MARGIN;
  for (GlobalEvent globalEvent : globalEvents) {
    String eventText = globalEvent.name + ": " + globalEvent.startDate.format(formatter);
    if (globalEvent.isPeriod()) {
      eventText = eventText + " - " + globalEvent.endDate.format(formatter);
    }

    text(eventText, textX + CHECKBOX_WIDTH + SMALL_MARGIN / 2, textY);

    if (globalEvent.selected) {
      fill(GREEN_COLOR);
    } else {
      fill(255);
    }
    rect(textX, textY - NORMAL_TEXT_SIZE / 2, CHECKBOX_WIDTH, CHECKBOX_WIDTH);
    globalEvent.x = textX;
    globalEvent.y = textY - NORMAL_TEXT_SIZE / 2;

    fill(0);
    textY += MARGIN;
  }
}

void displayGlobalEventDescription() {
  float y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN + STOCK_DATA_HEIGHT + MARGIN;
  float textY = y + MARGIN + MARGIN + SMALL_MARGIN;
  float textX = MARGIN + SMALL_MARGIN;

  for (GlobalEvent globalEvent : globalEvents) {
    if (globalEvent.isHover()) {
      float descriptionTipWidth = WINDOW_LEFT_COLUMN - (textX + CHECKBOX_WIDTH + SMALL_MARGIN / 2);
      fill(255);
      rect(textX + CHECKBOX_WIDTH + SMALL_MARGIN / 2, textY + SMALL_MARGIN, textWidth(globalEvent.description) + 2 * SMALL_MARGIN, NORMAL_TEXT_SIZE  + SMALL_TEXT_SIZE);
      fill(0);
      text(globalEvent.description, textX + CHECKBOX_WIDTH + SMALL_MARGIN, textY + SMALL_MARGIN + MARGIN);
    }
    textY += MARGIN;
  }
}

void displayLeftColumn() {
  displayComputerPartNames();
  displayStockData();
  displayEventList();
}
