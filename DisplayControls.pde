void displayControls() {
  float y, buttonHeight;
  String lineDiagramText = "Vonaldiagram";
  String columnDiagramText = "Oszlopdiagram";

  textSize(NORMAL_TEXT_SIZE);

  buttonHeight = textAscent() + SMALL_MARGIN;
  y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN + STOCK_DATA_HEIGHT + MARGIN + EVENT_LIST_HEIGHT + MARGIN + MARGIN;

  if (lineDiagram) {
    fill(GREEN_COLOR);
  } else {
    noFill();
  }
  rect(MARGIN + SMALL_MARGIN - SMALL_MARGIN, y - 2 * SMALL_MARGIN, textWidth(lineDiagramText) + 2 * SMALL_MARGIN, buttonHeight);

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
    text("Dátum: " + selectedDate, MARGIN, y + 2 * MARGIN);
  } else if (columnDiagram) {
    text("Dátumtól: " + selectedDate, MARGIN, y + 2 * MARGIN);
    text("Dátumig: " + selectedDate, MARGIN, y + 3 * MARGIN);
  }
}
