class Stock {
  String name;
  float x, y;
  boolean selected;
  color displayedColor;
  LocalDate minDate, maxDate;
  double maxPrice;
  HashMap<LocalDate, Double> prices;

  Stock() {
    prices = new HashMap();
  }

  Stock(String name) {
    this.name = name;
    prices = new HashMap();
  }

  Stock(String name, color displayedColor) {
    this.name = name;
    this.displayedColor = displayedColor;
    prices = new HashMap();
  }

  boolean isHover() {
    return mouseX >= x && mouseX <= x + CHECKBOX_WIDTH && mouseY >= y && mouseY <= y + CHECKBOX_WIDTH;
  }

  double getPrice(LocalDate date) {
    LocalDate nearestDate = minDate;
    long minDayDifference = Long.MAX_VALUE;

    for (LocalDate d : prices.keySet()) {
      long dayDifference = getDaysBetween(d, date);

      if (dayDifference < minDayDifference) {
        minDayDifference = dayDifference;
        nearestDate = d;
      }
    }

    if (nearestDate == null) {
      return 0;
    }

    return prices.get(nearestDate);
  }

  void findDataLimits() {
    LocalDate minDate, maxDate;
    double max;

    max = 0;
    minDate = parseDate("2022-01-19");
    maxDate = parseDate("2000-01-01");

    for (LocalDate date : prices.keySet()) {
      double price = prices.get(date);

      if (price > max) {
        max = price;
      }

      if (date.isBefore(minDate)) {
        minDate = date;
      } else if (date.isAfter(maxDate)) {
        maxDate = date;
      }
    }

    this.minDate = minDate;
    this.maxDate = maxDate;
    this.maxPrice = max;
  }
}

void loadStockData(String csv, String name, color displayedColor) {
  Stock stock = new Stock(name, displayedColor);
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
  loadStockData("GOLD.csv", "Arany", GOLD_COLOR);
  loadStockData("SLAB.csv", "Szilícium", SILICON_COLOR);
  loadStockData("ETH-USD.csv", "Ethereum", ETHEREUM_COLOR);
  loadStockData("BTC-USD.csv", "BitCoin", BITCOIN_COLOR);

  for (Stock stock : stocks) {
    stock.findDataLimits();
  }
}
