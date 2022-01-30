color AMD_RED = color(220, 20, 60);
color INTEL_BLUE = color(30, 144, 255);

class CpuMarketShare {
  String date;
  float amdMarketShare;
  float intelMarkerShare;

  CpuMarketShare() {
  }

  CpuMarketShare(String date, float amdMarketShare, float intelMarkerShare) {
    this.date = date;
    this.amdMarketShare = amdMarketShare;
    this.intelMarkerShare = intelMarkerShare;
  }
}

void loadCpuMarketShare() {
  Table markteShare;
  markteShare = loadTable("intel-amd-marketshare.csv", "header");

  for (TableRow row : markteShare.rows()) {
    String date = row.getString("Date");
    float intelMarkerShare = row.getFloat("Intel");
    float amdMarketShare = row.getFloat("AMD");

    cpuMarketshareChanges.add(new CpuMarketShare(date, amdMarketShare, intelMarkerShare));
  }
}

void displayMarketSharePieChart() {
  float pieChartDiameter = height / 1.25;
  float lastAngle = 0;
  float degree;
  float x, y;

  x = width / 2 + 6 * MARGIN;
  y = height / 2 - 3 * MARGIN;
  
  degree = map(cpuMarketshareChanges.get(selectedMarketShare).amdMarketShare, 0, 100, 0, 360);
  fill(AMD_RED);
  arc(x, y, pieChartDiameter, pieChartDiameter, lastAngle, lastAngle + radians(degree));
  lastAngle += radians(degree);

  degree = map(cpuMarketshareChanges.get(selectedMarketShare).intelMarkerShare, 0, 100, 0, 360);
  fill(INTEL_BLUE);
  arc(x, y, pieChartDiameter, pieChartDiameter, lastAngle, lastAngle + radians(degree));
  
  textSize(1.5 * NORMAL_TEXT_SIZE);
  fill(AMD_RED);
  rect(width - 16 * MARGIN, 6 * MARGIN - 1.2 * SMALL_MARGIN, CHECKBOX_WIDTH, CHECKBOX_WIDTH);

  fill(INTEL_BLUE);
  rect(width - 16 * MARGIN, 7 * MARGIN + SMALL_MARGIN - 1.2 * SMALL_MARGIN, CHECKBOX_WIDTH, CHECKBOX_WIDTH);
  
  fill(0);
  text("Dátum: " + cpuMarketshareChanges.get(selectedMarketShare).date, width - 16 * MARGIN, 4 * MARGIN);
  text("AMD: " + cpuMarketshareChanges.get(selectedMarketShare).amdMarketShare + "%", width - 15 * MARGIN, 6 * MARGIN);
  text("Intel: " + cpuMarketshareChanges.get(selectedMarketShare).intelMarkerShare + "%", width - 15 * MARGIN, 7 * MARGIN + SMALL_MARGIN);

  textSize(NORMAL_TEXT_SIZE);
}

void displayMarketShareScrollbar() {
  hs3.update();
  hs3.display();
  selectedMarketShare = hs3.index;
}
