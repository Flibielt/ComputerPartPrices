int selectedComponentCount = 0;

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
  // Manage component part types
  for (ComputerPartType computerPartType : computerPartTypes) {
    if (computerPartType.displayed && computerPartType.isHover()) {
      boolean selected = !computerPartType.selected;
      computerPartType.selected = selected;

      for (ComputerPart computerPart : computerParts) {
        if (computerPart.type.equals(computerPartType.name)) {
          if (selected) {
            // Selected the component group
            if (computerPart.selected) {
              // Was selected beforehand, no change needed
            } else {
              // Was NOT selected beforehand
              computerPart.selected = true;
              selectedComponentCount++;

              if (selectedComponentCount <= baseColors.length) {
                computerPart.displayedColor = baseColors[selectedComponentCount - 1];
              } else {
                computerPart.displayedColor = generateRandomColor();
              }
            }
          } else {
            // Deselected the component group
            computerPart.selected = false;
            computerPart.displayedColor = color(255);
            selectedComponentCount--;
          }
        }
      }
      
      findMaxComputerPartPrice();
      return;
    }
  }

  // Manage single component part
  for (ComputerPart computerPart : computerParts) {
    if (computerPart.displayed && computerPart.isHover()) {
      if (computerPart.selected) {
        // Deselect the computer part
        computerPart.selected = false;
        computerPart.displayedColor = color(255);
        selectedComponentCount--;
      } else {
        // Selected the computer part
        computerPart.selected = true;
        selectedComponentCount++;

        if (selectedComponentCount <= baseColors.length) {
          computerPart.displayedColor = baseColors[selectedComponentCount - 1];
        } else {
          computerPart.displayedColor = generateRandomColor();
        }
      }
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
  } else if (mouseY >= y + 2 * MARGIN && mouseY <= y + 2 * MARGIN + textAscent()) {
    if (mouseX >= MARGIN && mouseX <= MARGIN + textWidth(twoSliderText) + 2 * SMALL_MARGIN) {
      twoSilderWithLineDiagram = !twoSilderWithLineDiagram;
    }
  }
}
