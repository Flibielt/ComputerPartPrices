import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

List<ComputerPart> computerParts;
Set<String> computerPartNames;
HashMap<LocalDate, Double> goldPrices;
HashMap<LocalDate, Double> siliconPrices;
HashMap<LocalDate, Double> bitCoinPrices;

void setup() {
  fullScreen();
  surface.setTitle("Computer part prices");

  computerParts = new ArrayList();
  computerPartNames = new HashSet();
  goldPrices = new HashMap();
  siliconPrices = new HashMap();
  bitCoinPrices = new HashMap();

  loadData();
  loadStockData();
}

void draw() {
  background(255);
}
