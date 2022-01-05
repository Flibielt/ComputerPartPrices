import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

List<ComputerPart> computerParts;
Set<String> computerPartNames;

void setup() {
  fullScreen();
  surface.setTitle("Computer part prices");

  computerParts = new ArrayList();
  computerPartNames = new HashSet();

  loadData();
}

void draw() {
  background(255);
}
