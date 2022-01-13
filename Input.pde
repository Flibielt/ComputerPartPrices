void mouseWheel(MouseEvent event) {
  int count = event.getCount();

  if (mouseX >= MARGIN && mouseX <= WINDOW_LEFT_COLUMN + MARGIN && mouseY >= MARGIN && mouseY <= COMPUTER_PARTS_HEIGHT + MARGIN) {
    if ((count < 0 && computerPartStartIndex > 0) || (count > 0 && computerPartStartIndex < computerParts.size() - 1)) {
      computerPartStartIndex += count;
    }
  }
}

void mouseClicked() {
  if (mouseX < WINDOW_LEFT_COLUMN) {
    if (isMouseInComponentListArea()) {
      checkClickInComponentList();
    }
  }
}

void checkClickInComponentList() {
  for (ComputerPartType computerPartType : computerPartTypes) {
    if (computerPartType.displayed && computerPartType.isHover()) {
      computerPartType.selected = !computerPartType.selected;
      return;
    }
  }

  for (ComputerPart computerPart : computerParts) {
    if (computerPart.displayed && computerPart.isHover()) {
      computerPart.selected = !computerPart.selected;
      return;
    }
  }
}
