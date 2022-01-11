import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeFormatter;

List<ComputerPart> computerParts;
Set<String> computerPartNames;
List<GlobalEvent> globalEvents;
List<Stock> stocks;

void setup() {
  fullScreen();
  surface.setTitle("Computer part prices");

  computerParts = new ArrayList();
  computerPartNames = new HashSet();
  globalEvents = new ArrayList();
  stocks = new ArrayList();

  calculateElementSizes();

  loadData();
  loadStockData();
  loadGlobalEvents();
}

void draw() {
  background(255);
  displayComputerPartNames();
  displayStockData();
  displayEventList();
}
