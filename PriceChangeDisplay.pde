int MAX_TEXT_COUNT = 60;
int computerPartStartIndex = 0;

void displayComputerPartNames() {
  float textX = MARGIN + SMALL_MARGIN;
  float textY = MARGIN + MARGIN;

  noFill();
  rect(MARGIN, MARGIN, WINDOW_LEFT_COLUMN, COMPUTER_PARTS_HEIGHT);
  fill(0);
  textSize(NORMAL_TEXT_SIZE);
  text("Komponensek", textX, textY);

  String type = "";
  for (int i = computerPartStartIndex; i < computerParts.size(); i++) {
    ComputerPart c = computerParts.get(i);
    textY += MARGIN;

    if (textY + textAscent() >= COMPUTER_PARTS_HEIGHT) {
      break;
    }

    if (!type.equals(c.type)) {
      textSize(NORMAL_TEXT_SIZE);
      textY += SMALL_MARGIN;
      text(c.type + ":", textX, textY);
      textY += MARGIN;
      type = c.type;
    }

    if (textY + textAscent() >= COMPUTER_PARTS_HEIGHT) {
      break;
    }

    textSize(SMALL_TEXT_SIZE);
    int charCount = (c.name.length() >= MAX_TEXT_COUNT) ? MAX_TEXT_COUNT : c.name.length();
    text(c.name.toCharArray(), 0, charCount, textX + SMALL_MARGIN, textY);
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
  text("Tőzsde", textX, textY);

  textY += MARGIN;
  text("Arany", textX + SMALL_MARGIN, textY);

  textY += MARGIN;
  text("Szilícium", textX + SMALL_MARGIN, textY);

  textY += MARGIN;
  text("BitCoin", textX + SMALL_MARGIN, textY);
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

  textX += SMALL_MARGIN;
  for (GlobalEvent globalEvent : globalEvents) {
    String eventText = globalEvent.name + ": " + globalEvent.startDate.format(formatter);
    if (globalEvent.isPeriod()) {
      eventText = eventText + " - " + globalEvent.endDate.format(formatter);
    }

    textY += MARGIN;
    text(eventText, textX, textY);
  }
}

void displayLeftColumn() {
  displayComputerPartNames();
  displayStockData();
  displayEventList();
}
