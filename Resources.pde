class Stock {
  String name;
  HashMap<LocalDate, Double> prices;

  Stock() {
    prices = new HashMap();
  }

  Stock(String name) {
    this.name = name;
    prices = new HashMap();
  }
}

void loadGoldData() {
  Stock stock = new Stock("Arany");
  DateTimeFormatter formatterMonthName = DateTimeFormatter.ofPattern("MM dd, yyyy");
  Table table = loadTable("gold.tsv", "header, tsv");

  for (TableRow row : table.rows()) {
    String dateStr = row.getString("Date");
    LocalDate date = LocalDate.parse(dateStr, formatterMonthName);
    Double price = Double.parseDouble(row.getString("Adj Close"));
    stock.prices.put(date, price);
  }

  stocks.add(stock);
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
  loadGoldData();
  loadStockData("SLAB.csv", "Szilícium");
  loadStockData("ETH-USD.csv", "Ethereum");
  loadStockData("BTC-USD.csv", "BitCoin");
}
