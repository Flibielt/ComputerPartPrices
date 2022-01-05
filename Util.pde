DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

LocalDate parseDate(String s) {
  return LocalDate.parse(s, formatter);
}
