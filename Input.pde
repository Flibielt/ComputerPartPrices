void mouseWheel(MouseEvent event) {
  int count = event.getCount();

  if (isMouseInComponentListArea()) {
    if ((count < 0 && computerPartStartIndex > 0) || (count > 0 && computerPartStartIndex < computerParts.size() - 1)) {
      computerPartStartIndex += count;
    }
  }
}

void mouseClicked() {
  if (mouseX < WINDOW_LEFT_COLUMN) {
    if (isMouseInComponentListArea()) {
      checkClickInComponentList();
    } else if(isMouseInStockListArea()) {
      checkClickInStockList();
    } else if(isMouseInEventListArea()) {
      checkClickOnEventList();
    } else {
      checkClickOnControlButtons();
    }
  }

  if (!computerPartSelected && !stockSelected) {
    hs1.reset();
  }
}

void checkClickInComponentList() {
  for (ComputerPartType computerPartType : computerPartTypes) {
    if (computerPartType.displayed && computerPartType.isHover()) {
      computerPartType.selected = !computerPartType.selected;

      for (ComputerPart computerPart : computerParts) {
        if (computerPart.type.equals(computerPartType.name)) {
          computerPart.selected = computerPartType.selected;
        }
      }
      
      findMaxComputerPartPrice();
      return;
    }
  }

  for (ComputerPart computerPart : computerParts) {
    if (computerPart.displayed && computerPart.isHover()) {
      computerPart.selected = !computerPart.selected;
      findMaxComputerPartPrice();
      return;
    }
  }
}

void checkClickInStockList() {
  for (Stock stock : stocks) {
    if (stock.isHover()) {
      stock.selected = !stock.selected;
      findMaxStockPrice();
      return;
    }
  }
}

void checkClickOnEventList() {
  for (GlobalEvent event : globalEvents) {
    if (event.isHover()) {
      event.selected = !event.selected;
      return;
    }
  }
}

void checkClickOnControlButtons() {
  float y, buttonHeight;

  textSize(NORMAL_TEXT_SIZE);
  buttonHeight = textAscent() + SMALL_MARGIN;
  y = MARGIN + COMPUTER_PARTS_HEIGHT + MARGIN + STOCK_DATA_HEIGHT + MARGIN + EVENT_LIST_HEIGHT + MARGIN + MARGIN - 2 * SMALL_MARGIN;

  if (mouseY >= y && mouseY <= y + buttonHeight) {
    if (mouseX >= MARGIN && mouseX <= MARGIN + textWidth(lineDiagramText) + 2 * SMALL_MARGIN) {
      lineDiagram = true;
      columnDiagram = false;
    } else if (mouseX >= MARGIN + textWidth(lineDiagramText) + 2 * SMALL_MARGIN && mouseX <= MARGIN + textWidth(lineDiagramText) + textWidth(columnDiagramText) + 4 * SMALL_MARGIN) {
      lineDiagram = false;
      columnDiagram = true;
    }
  }
}
