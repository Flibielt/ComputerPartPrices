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

void displayMarketShareScrollbar() {
  hs3.update();
  hs3.display();
  selectedMarketShare = hs3.index;
}
