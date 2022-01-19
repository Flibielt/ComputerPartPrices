class Stock {
  String name;
  float x, y;
  boolean selected;
  color c;
  LocalDate minDate, maxDate;
  HashMap<LocalDate, Double> prices;

  Stock() {
    prices = new HashMap();
  }

  Stock(String name) {
    this.name = name;
    prices = new HashMap();
  }

  boolean isHover() {
    return mouseX >= x && mouseX <= x + CHECKBOX_WIDTH && mouseY >= y && mouseY <= y + CHECKBOX_WIDTH;
  }
}

void loadStockData(String csv, String name) {
  Stock stock = new Stock(name);
  Table table = loadTable(csv, "header");

  for (TableRow row : table.rows()) {
    String dateStr = row.getString("Date");
    LocalDate date = parseDate(dateStr);
    Double price = Double.parseDouble(row.getString("Adj Close"));
    stock.prices.put(date, price);
  }

  stocks.add(stock);
}

void loadStockData() {
  loadStockData("GOLD.csv", "Arany");
  loadStockData("SLAB.csv", "Szilícium");
  loadStockData("ETH-USD.csv", "Ethereum");
  loadStockData("BTC-USD.csv", "BitCoin");
}
