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
    }
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
