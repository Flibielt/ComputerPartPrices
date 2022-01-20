import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeFormatter;

List<ComputerPart> computerParts;
List<ComputerPartType> computerPartTypes;
Set<String> computerPartNames;
List<GlobalEvent> globalEvents;
List<Stock> stocks;

DataVisualization computerPartPlot = new DataVisualization();
DataVisualization stockPlot = new DataVisualization();

void setup() {
  fullScreen();
  surface.setTitle("Computer part prices");

  computerParts = new ArrayList();
  computerPartTypes = new ArrayList();
  computerPartNames = new HashSet();
  globalEvents = new ArrayList();
  stocks = new ArrayList();

  calculateElementSizes();
  globalMaxDate = parseDate("2000-01-01");
  globalMinDate = parseDate("2022-11-31");

  computerPartPlot.dataType = PlotDataType.COMPUTER_PART;
  stockPlot.dataType = PlotDataType.STOCK;

  loadData();
  loadStockData();
  loadGlobalEvents();
}

void draw() {
  background(255);
  displayComputerPartNames();
  displayStockData();
  displayEventList();
  displayPlots();
}
