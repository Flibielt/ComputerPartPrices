void displayColumnDiagrams() {
  float x, y;
  int diagramInRow = 0;
  x = MARGIN + WINDOW_LEFT_COLUMN + 5 * MARGIN;
  y = MARGIN;

  for (Stock stock : stocks) {
    if (y + COLUMN_DIAGRAM_HEIGHT > DATE_PICKER_Y) {
      break;
    }

    if (stock.selected && stock.isSelectedDateInDataset()) {
      displayColumnDiagram(x, y, stock);
      x += COLUMN_DIAGRAM_WIDTH + 5 * MARGIN;
      diagramInRow++;

      if (diagramInRow > 2) {
        x = MARGIN + WINDOW_LEFT_COLUMN + 5 * MARGIN;
        y += MARGIN + COLUMN_DIAGRAM_HEIGHT + MARGIN;
        diagramInRow = 0;
      }
    }
  }

  for (ComputerPart computerPart : computerParts) {
    if (y + COLUMN_DIAGRAM_HEIGHT > DATE_PICKER_Y) {
      break;
    }

    if (computerPart.selected && computerPart.isSelectedDateInDataset()) {
      displayColumnDiagram(x, y, computerPart);

      x += COLUMN_DIAGRAM_WIDTH + 5 * MARGIN;
      diagramInRow++;

      if (diagramInRow > 2) {
        x = MARGIN + WINDOW_LEFT_COLUMN + 5 * MARGIN;
        y += MARGIN + COLUMN_DIAGRAM_HEIGHT + MARGIN;
        diagramInRow = 0;
      }
    }
  }
}

void displayColumnDiagram(float x, float y, Stock stock) {
  float columnHeight = 0;
  double maxPrice;
  maxPrice = stock.getPrice(dateFrom) > stock.getPrice(selectedDate) ? stock.getPrice(dateFrom) : stock.getPrice(selectedDate);

  noFill();
  drawVolumeLabel(x, y, (int)maxPrice);
  line(x, y + COLUMN_DIAGRAM_HEIGHT, x + COLUMN_DIAGRAM_WIDTH, y + COLUMN_DIAGRAM_HEIGHT);

  fill(stock.displayedColor);
  columnHeight = map((float)stock.getPrice(dateFrom), (float)0, (float)maxPrice, (float)0, COLUMN_DIAGRAM_HEIGHT);
  rect(x + COLUMN_DIAGRAM_WIDTH / 5, y + COLUMN_DIAGRAM_HEIGHT - columnHeight, COLUMN_DIAGRAM_WIDTH / 5, columnHeight);

  columnHeight = map((float)stock.getPrice(selectedDate), (float)0, (float)maxPrice, (float)0, COLUMN_DIAGRAM_HEIGHT);
  rect(x + COLUMN_DIAGRAM_WIDTH / 5 * 3, y + COLUMN_DIAGRAM_HEIGHT - columnHeight, COLUMN_DIAGRAM_WIDTH / 5, columnHeight);

  fill(0);
  textAlign(CENTER);
  text(stock.name, x + COLUMN_DIAGRAM_WIDTH / 2, y + COLUMN_DIAGRAM_HEIGHT + MARGIN);
  textAlign(LEFT);
}

void displayColumnDiagram(float x, float y, ComputerPart computerPart) {
  float columnHeight = 0;
  double maxPrice;
  maxPrice = computerPart.getPrice(dateFrom) > computerPart.getPrice(selectedDate) ? computerPart.getPrice(dateFrom) : computerPart.getPrice(selectedDate);

  noFill();
  drawVolumeLabel(x, y, (int)maxPrice);
  line(x, y + COLUMN_DIAGRAM_HEIGHT, x + COLUMN_DIAGRAM_WIDTH, y + COLUMN_DIAGRAM_HEIGHT);

  fill(computerPart.displayedColor);
  columnHeight = map((float)computerPart.getPrice(dateFrom), (float)0, (float)maxPrice, (float)0, COLUMN_DIAGRAM_HEIGHT);
  rect(x + COLUMN_DIAGRAM_WIDTH / 5, y + COLUMN_DIAGRAM_HEIGHT - columnHeight, COLUMN_DIAGRAM_WIDTH / 5, columnHeight);

  columnHeight = map((float)computerPart.getPrice(selectedDate), (float)0, (float)maxPrice, (float)0, COLUMN_DIAGRAM_HEIGHT);
  rect(x + COLUMN_DIAGRAM_WIDTH / 5 * 3, y + COLUMN_DIAGRAM_HEIGHT - columnHeight, COLUMN_DIAGRAM_WIDTH / 5, columnHeight);

  fill(0);
  textAlign(CENTER);
  int textCount = computerPart.name.length() >= MAX_TEXT_COUNT ? MAX_TEXT_COUNT : computerPart.name.length();
  text(computerPart.name.substring(0, textCount), x + COLUMN_DIAGRAM_WIDTH / 2, y + COLUMN_DIAGRAM_HEIGHT + MARGIN);
  textAlign(LEFT);
}

void drawVolumeLabel(float x, float y, int maxPrice) {
  fill(0);
  textSize(SMALL_TEXT_SIZE);
  textAlign(RIGHT);
  
  text(String.format("%,d %n", maxPrice), x - 10, y + textAscent());
  line(x - 4, y, x, y);

  text(String.format("%,d %n", 0), x - 10, y + COLUMN_DIAGRAM_HEIGHT);
  line(x - 4, y, x, y + COLUMN_DIAGRAM_HEIGHT);

  textAlign(LEFT);
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
