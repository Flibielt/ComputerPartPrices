enum PlotDataType {
  COMPUTER_PART,
  STOCK
}

class DataVisualization {
  int dataMin = 0, dataMax;
  float plotX1, plotX2, plotY1, plotY2;
  PlotDataType dataType = PlotDataType.COMPUTER_PART;

  void drawTimeLabel() {
    long dayPeriod;
    long daysBetween = getDaysBetween(globalMinDate, globalMaxDate);

    fill(0);
    textSize(NORMAL_TEXT_SIZE);
    textAlign(CENTER);
    stroke(224);

    dayPeriod = daysBetween / 4;
    for (int day = 0; day < daysBetween; day++) {
      if (day % dayPeriod == 0) {
        float x = map(day, 0, daysBetween, plotX1, plotX2);
        LocalDate date = globalMinDate.plusDays(day);
        text(date.toString(), x, plotY2 + textAscent() + 10);
        line(x, plotY1, x, plotY2);
      }
    }

    stroke(0);
  }

  void drawVolumeLabel() {
    int tickMark;
    float y;
    fill(0);
    textSize(NORMAL_TEXT_SIZE);
    textAlign(RIGHT);
    stroke(224);
    
    int volumeIntervalMinor = dataMax / 5; 

    for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
      y = map(v, dataMin, dataMax, plotY2, plotY1);  
      float textOffset = textAscent() / 2;  // Center vertically
      if (v == dataMin) {
        textOffset = 0;                   // Align by the bottom
      } else if (v == dataMax) {
        textOffset = textAscent();        // Align by the top
      }
      text(floor(v), plotX1 - 10, y + textOffset);
      line(plotX1 - 4, y, plotX1, y);     // Draw major tick
    }

    stroke(0);
  }
  
  void drawDataCurve() {
    if (this.dataType == PlotDataType.COMPUTER_PART) {
      for (ComputerPart computerPart : computerParts) {
        if (computerPart.selected) {
          drawDataCurve(computerPart);
        }
      }
    } else if (this.dataType == PlotDataType.STOCK) {
      for (Stock stock : stocks) {
        if (stock.selected) {
          drawDataCurve(stock);
        }
      }
    }
  }

  private void drawDataCurve(ComputerPart computerPart) {
    LocalDate minDate, maxDate;
    long daysBetween = 0;

    noFill();
    stroke(computerPart.displayedColor);
    beginShape();
    
    minDate = computerPart.minDate;
    maxDate = computerPart.maxDate;
    daysBetween = getDaysBetween(minDate, maxDate);
    for (int day = 0; day < daysBetween; day++) {
      LocalDate currentDate = minDate.plusDays(day);
      if (!computerPart.prices.containsKey(currentDate)) {
        continue;
      }

      int value = computerPart.prices.get(currentDate);
      
      float x = map(day, 0, daysBetween, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      curveVertex(x, y);
      // Double the curve points for the start and stop
      if ((day == 0) || (day == daysBetween - 1)) {
        curveVertex(x, y);
      }
    }

    endShape();
    stroke(0);
  }

  private void drawDataCurve(Stock stock) {
    LocalDate minDate, maxDate;
    long daysBetween = 0;

    noFill();
    stroke(stock.displayedColor);
    beginShape();
    
    minDate = stock.minDate;
    maxDate = stock.maxDate;
    daysBetween = getDaysBetween(minDate, maxDate);
    for (int day = 0; day < daysBetween; day++) {
      LocalDate currentDate = minDate.plusDays(day);
      if (!stock.prices.containsKey(currentDate)) {
        continue;
      }

      int value = stock.prices.get(currentDate).intValue();
      
      float x = map(day, 0, daysBetween, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      curveVertex(x, y);
      // Double the curve points for the start and stop
      if ((day == 0) || (day == daysBetween - 1)) {
        curveVertex(x, y);
      }
    }

    endShape();
    stroke(0);
  }
}
