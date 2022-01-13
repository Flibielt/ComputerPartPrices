class ComputerPart {
  String name;
  String type;
  float x, y;
  boolean displayed;
  boolean selected;
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

class ComputerPartType {
  String name;
  float x, y;
  boolean displayed;
  boolean selected;

  ComputerPartType() {
    displayed = false;
    selected = false;
  }

  ComputerPartType(String name) {
    this.name = name;
    displayed = false;
    selected = false;
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

      ComputerPartType computerPartType = new ComputerPartType(productType);
      computerPartTypes.add(computerPartType);
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
