class GlobalEvent {
  String name;
  String description;
  float x, y;
  LocalDate startDate;
  LocalDate endDate;
  boolean selected;
  color c;

  boolean isPeriod() {
    return ChronoUnit.DAYS.between(startDate, endDate) > 0;
  }

  GlobalEvent(String name, String description, LocalDate date) {
    this.name = name;
    this.description = description;
    this.startDate = date;
    this.endDate = date;
  }

  GlobalEvent(String name, String description, LocalDate startDate, LocalDate endDate) {
    this.name = name;
    this.description = description;
    this.startDate = startDate;
    this.endDate = endDate;
  }

  boolean isHover() {
    return mouseX >= x && mouseX <= x + CHECKBOX_WIDTH && mouseY >= y && mouseY <= y + CHECKBOX_WIDTH;
  }
}

void loadGlobalEvents() {
  Table events = loadTable("events.csv", "header");

  for (TableRow row : events.rows()) {
    String name;
    String description;
    LocalDate date;

    name = row.getString("event");
    description = row.getString("info");
    date = parseDate(row.getString("date"));

    GlobalEvent globalEvent = new GlobalEvent(name, description, date);
    globalEvents.add(globalEvent);
  }

  Table periods = loadTable("periods.csv", "header");

  for (TableRow row : periods.rows()) {
    String name;
    String description;
    LocalDate startDate;
    LocalDate endDate;

    name = row.getString("period");
    description = row.getString("info");
    startDate = parseDate(row.getString("start_date"));
    endDate = parseDate(row.getString("end_date"));

    GlobalEvent globalEvent = new GlobalEvent(name, description, startDate, endDate);
    globalEvents.add(globalEvent);
  }
}
