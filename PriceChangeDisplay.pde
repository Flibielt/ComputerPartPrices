int MAX_TEXT_COUNT = 60;
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
            fill(green);
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

    textSize(SMALL_TEXT_SIZE);
    int charCount = (c.name.length() >= MAX_TEXT_COUNT) ? MAX_TEXT_COUNT : c.name.length();
    text(c.name.toCharArray(), 0, charCount, textX + SMALL_MARGIN + MARGIN, textY);

    if (c.selected) {
      fill(green);
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
    String name = stock.name;
    text(name, textX + CHECKBOX_WIDTH + SMALL_MARGIN / 2, textY);
    
    if (stock.selected) {
      fill(green);
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
      fill(green);
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

void displayLeftColumn() {
  displayComputerPartNames();
  displayStockData();
  displayEventList();
}
