class ComputerPart {
  String name;
  String type;
  float x, y;
  boolean displayed;
  boolean selected;
  color displayedColor = color(0);
  LocalDate minDate, maxDate;
  int maxPrice;
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

  boolean isHover() {
    float elementWidth = WINDOW_LEFT_COLUMN - x;

    return mouseX >= x && mouseX <= x + elementWidth && mouseY >= y && mouseY <= y + CHECKBOX_WIDTH;
  }

  int getPrice(LocalDate date) {
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

  boolean isSelectedDateInDataset() {
    return !isSelectedDateTooOld();
  }

  boolean isSelectedDateTooOld() {
    if (lineDiagram) {
      return selectedDate.isBefore(minDate) && getDaysBetween(selectedDate, minDate) > MAX_DAY_DIFFERENCE;
    } else {
      return dateFrom.isBefore(minDate) && getDaysBetween(dateFrom, minDate) > MAX_DAY_DIFFERENCE;
    }
  }

  void findDataLimits() {
    LocalDate minDate, maxDate;
    int max;

    max = 0;
    minDate = parseDate("2022-01-19");
    maxDate = parseDate("2000-01-01");

    for (LocalDate date : prices.keySet()) {
      int price = prices.get(date);

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

  boolean isHover() {
    float elementWidth = WINDOW_LEFT_COLUMN - x;

    return mouseX >= x && mouseX <= x + elementWidth && mouseY >= y && mouseY <= y + CHECKBOX_WIDTH;
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

  for (ComputerPart c : computerParts) {
    c.findDataLimits();
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
