float pieChartDiameter = height * 8;
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

    cpuMarketshareChanges.add(new CpuMarketShare(date, intelMarkerShare, amdMarketShare));
  }
}

void displayMarketSharePieChart() {
  float lastAngle = 0;
  float degree;
  float x, y;

  x = width / 2 + 6 * MARGIN;
  y = height / 2 - 3 * MARGIN;
  
  degree = 360 - map(cpuMarketshareChanges.get(selectedMarketShare).amdMarketShare, 0, 100, 0, 360);
  fill(AMD_RED);
  arc(x, y, pieChartDiameter, pieChartDiameter, lastAngle, lastAngle + radians(degree));
  lastAngle += radians(degree);

  degree = 360 - map(cpuMarketshareChanges.get(selectedMarketShare).intelMarkerShare, 0, 100, 0, 360);
  fill(INTEL_BLUE);
  arc(x, y, pieChartDiameter, pieChartDiameter, lastAngle, lastAngle + radians(degree));
  
}

void displayMarketShareScrollbar() {
  hs3.update();
  hs3.display();
  selectedMarketShare = hs3.index;
}
