class ComputerPart {
  String name;
  String type;
  HashMap<LocalDate, Integer> prices;

  ComputerPart() {
    prices = new HashMap();
  }

  ComputerPart(String name, String type) {
    this.name = name;
    this.type = type;
    prices = new HashMap();
  }

  @Override
  public String toString() {
    return "name: " + name + "\ntype: " + type + "\n prices: " + prices;
  }
}

void loadData() {
  Table partPrices;
  partPrices = loadTable("data.csv", "header");

  ComputerPart computerPart = null;
  for (TableRow row : partPrices.rows()) {
    String name = row.getString("product");

    if (!computerPartNames.contains(name)) {
      String productType = row.getString("type");
      computerPart = new ComputerPart(name, productType);

      computerParts.add(computerPart);
      computerPartNames.add(name);
    }

    LocalDate date = parseDate(row.getString("date"));
    Double price = Double.parseDouble(row.getString("price"));
    computerPart.prices.put(date, price.intValue());
  }
}

ComputerPart getComputerPart(String name) {
  for (ComputerPart c : computerParts) {
    if (c.name.equals(name)) {
      return c;
    }
  }

  return null;
}
