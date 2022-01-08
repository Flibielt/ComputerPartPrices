void loadGoldData() {
  DateTimeFormatter formatterMonthName = DateTimeFormatter.ofPattern("MM dd, yyyy");
  Table table = loadTable("gold.tsv", "header, tsv");

  for (TableRow row : table.rows()) {
    String dateStr = row.getString("Date");
    LocalDate date = LocalDate.parse(dateStr, formatterMonthName);
    Double price = Double.parseDouble(row.getString("Adj Close"));
    goldPrices.put(date, price);
  }
}

void loadSiliconData() {
  Table table = loadTable("SLAB.csv", "header");

  for (TableRow row : table.rows()) {
    String dateStr = row.getString("Date");
    LocalDate date = parseDate(dateStr);
    Double price = Double.parseDouble(row.getString("Adj Close"));
    siliconPrices.put(date, price);
  }
}

void loadBitCoinData() {
  Table table = loadTable("BTC-USD.csv", "header");

  for (TableRow row : table.rows()) {
    String dateStr = row.getString("Date");
    LocalDate date = parseDate(dateStr);
    Double price = Double.parseDouble(row.getString("Adj Close"));
    bitCoinPrices.put(date, price);
  }
}

void loadStockData() {
  loadGoldData();
  loadSiliconData();
  loadBitCoinData();
}
