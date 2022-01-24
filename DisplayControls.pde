String lineDiagramText = "Vonaldiagram";
String columnDiagramText = "Oszlopdiagram";
String twoSliderText = "2 csúszka";
boolean twoSilderWithLineDiagram = false;

void displayControls() {
  float y, buttonHeight;

  textSize(NORMAL_TEXT_SIZE);

  buttonHeight = textAscent() + SMALL_MARGIN;
  y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN + STOCK_DATA_HEIGHT + MARGIN + EVENT_LIST_HEIGHT + MARGIN + MARGIN;

  if (lineDiagram) {
    fill(GREEN_COLOR);
  } else {
    noFill();
  }
  rect(MARGIN, y - 2 * SMALL_MARGIN, textWidth(lineDiagramText) + 2 * SMALL_MARGIN, buttonHeight);

  if (columnDiagram) {
    fill(GREEN_COLOR);
  } else {
    noFill();
  }
  rect(MARGIN + SMALL_MARGIN + textWidth(lineDiagramText) + SMALL_MARGIN, y - 2 * SMALL_MARGIN, textWidth(columnDiagramText) + 2 * SMALL_MARGIN, buttonHeight);

  fill(0);
  text(lineDiagramText, MARGIN + SMALL_MARGIN, y);
  text(columnDiagramText, MARGIN + SMALL_MARGIN + textWidth(lineDiagramText) + 2 * SMALL_MARGIN, y);

  if (lineDiagram) {
    if (twoSilderWithLineDiagram) {
      fill(GREEN_COLOR);
    } else {
      noFill();
    }
    rect(MARGIN, y + MARGIN + SMALL_MARGIN, CHECKBOX_WIDTH, CHECKBOX_WIDTH);

    fill(0);
    text(twoSliderText, MARGIN + CHECKBOX_WIDTH + SMALL_MARGIN, y + 2 * MARGIN);
    if (twoSilderWithLineDiagram) {
      text("Dátumtól: " + dateFrom.format(dateDisplayFormatter), MARGIN, y + 3 * MARGIN);
      text("Dátumig: " + selectedDate.format(dateDisplayFormatter), MARGIN, y + 4 * MARGIN);
    } else {
      text("Dátum: " + selectedDate.format(dateDisplayFormatter), MARGIN, y + 3 * MARGIN);
    }
  } else {
    text("Dátumtól: " + dateFrom.format(dateDisplayFormatter), MARGIN, y + 2 * MARGIN);
    text("Dátumig: " + selectedDate.format(dateDisplayFormatter), MARGIN, y + 3 * MARGIN);
  }
}
