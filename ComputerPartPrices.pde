import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import java.util.Optional;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeFormatter;

List<ComputerPart> computerParts;
List<ComputerPartType> computerPartTypes;
Set<String> computerPartNames;
List<GlobalEvent> globalEvents;
List<Stock> stocks;
List<CpuMarketShare> cpuMarketshareChanges;

int selectedMarketShare;
LocalDate selectedDate, dateFrom, dateTo;
boolean lineDiagram, columnDiagram, marketshareDiagram;

HScrollbar hs1;
HScrollbar hs2;
HScrollbarIndex hs3;
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
  cpuMarketshareChanges = new ArrayList();

  calculateElementSizes();
  globalMaxDate = parseDate("2000-01-01");
  globalMinDate = parseDate("2022-11-31");
  selectedDate = globalMinDate;
  lineDiagram = true;
  columnDiagram = false;

  computerPartPlot.dataType = PlotDataType.COMPUTER_PART;
  stockPlot.dataType = PlotDataType.STOCK;
  initScrollbar();

  loadData();
  loadStockData();
  loadGlobalEvents();
  loadCpuMarketShare();
}

void draw() {
  background(255);
  dateTo = hs1.date;
  dateFrom = hs2.date;
  displayComputerPartNames();
  displayStockData();
  displayEventList();
  displayControls();
  if (lineDiagram) {
    displayPlots();
    displayScrollbar();
  } else if(columnDiagram) {
    displayColumnDiagrams();
    displayTwoScrollbar();
  } else if (marketshareDiagram) {
    displayMarketShareScrollbar();
    displayMarketSharePieChart();
  }

  // Description with pop up hover, should be called at the end
  displayGlobalEventDescription();
}
