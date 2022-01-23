enum PlotDataType {
  COMPUTER_PART,
  STOCK
}

class DataVisualization {
  int dataMin = 0, dataMax;
  float plotX1, plotX2, plotY1, plotY2;
  PlotDataType dataType = PlotDataType.COMPUTER_PART;

  void setPosition(float plotX1, float plotX2, float plotY1, float plotY2) {
    this.plotX1 = plotX1;
    this.plotX2 = plotX2;
    this.plotY1 = plotY1;
    this.plotY2 = plotY2;
  }

  void display() {
    if (this.dataType == PlotDataType.COMPUTER_PART) {
      dataMax = computerPartMaxPrice;
    } else if (this.dataType == PlotDataType.STOCK) {
      dataMax = (int)stockMaxPrice;
    }

    if (dataMax > 0) {
      if (this.dataType == PlotDataType.COMPUTER_PART) {
        dataMax += 10000 - (dataMax % 10000);
      } else {
        if (dataMax > 100) {
          dataMax += 100 - (dataMax % 100);
        } else {
          dataMax += 10 - (dataMax % 10);
        }
      }
    } else {
      dataMax = 1000;
    }

    drawTimeLabel();
    drawVolumeLabel();
    drawEvents();
    displaySelectedDate();
    drawDataCurve();
  }

  void drawTimeLabel() {
    long dayPeriod;
    long daysBetween = getDaysBetween(globalMinDate, globalMaxDate);

    fill(0);
    textSize(SMALL_TEXT_SIZE);
    textAlign(CENTER);

    stroke(DEFAULT_STROKE);
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
    textAlign(LEFT);
  }

  void drawVolumeLabel() {
    int tickMark;
    float y;
    fill(0);
    textSize(SMALL_TEXT_SIZE);
    textAlign(RIGHT);
    stroke(DEFAULT_STROKE);
    
    int volumeIntervalMinor = dataMax / 5; 

    for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
      y = map(v, dataMin, dataMax, plotY2, plotY1);  
      float textOffset = textAscent() / 2;  // Center vertically
      if (v == dataMin) {
        textOffset = 0;                   // Align by the bottom
      } else if (v == dataMax) {
        textOffset = textAscent();        // Align by the top
      }
      text(String.format("%,d %n", floor(v)), plotX1 - 10, y + textOffset);
      line(plotX1 - 4, y, plotX1, y);     // Draw major tick
    }

    stroke(0);
    textAlign(LEFT);
  }

  void drawEvents() {
    // Global periods
    for (GlobalEvent globalEvent : globalEvents) {
      if (globalEvent.selected && globalEvent.isPeriod()) {
        if (isDayBetweenSelectedDates(globalEvent.startDate) && isDayBetweenSelectedDates(globalEvent.endDate)) {
          float x1 = 0, x2 = 0;

          x1 = map(getDaysBetween(globalMinDate, globalEvent.startDate), 0, getDaysBetween(globalMinDate, globalMaxDate), plotX1, plotX2);
          x2 = map(getDaysBetween(globalMinDate, globalEvent.endDate), 0, getDaysBetween(globalMinDate, globalMaxDate), plotX1, plotX2);

          if (globalEvent.isHover()) {
            strokeWeight(THICKER_STROKE);
            stroke(EVENT_RED);
          } else {
            noStroke();
          }

          fill(PERIOD_RED);
          rect(x1, plotY1, x2 - x1, plotY2 - plotY1);
          fill(0);
          stroke(DEFAULT_STROKE);
        }
      }
    }

    // Global event
    for (GlobalEvent globalEvent : globalEvents) {
      if (globalEvent.selected && !globalEvent.isPeriod()) {
        if (isDayBetweenSelectedDates(globalEvent.startDate)) {
          float lineWidth = 1;
          float x = map(getDaysBetween(globalMinDate, globalEvent.startDate), 0, getDaysBetween(globalMinDate, globalMaxDate), plotX1, plotX2);

          if (globalEvent.isHover()) {
            lineWidth = GLOBAL_EVENT_ONE_DAY_THICKER_WIDTH;
          } else {
            lineWidth = GLOBAL_EVENT_ONE_DAY_DEFAULT_WIDTH;
          }

          noStroke();
          fill(EVENT_RED);
          rect(x, plotY1, lineWidth, plotY2 - plotY1);
          fill(0);
        }
      }
    }
  }

  void displaySelectedDate() {
    if (stockSelected || computerPartSelected) {
      float x = map(getDaysBetween(globalMinDate, selectedDate), 0, getDaysBetween(globalMinDate, globalMaxDate), plotX1, plotX2);
      fill(GREEN_COLOR);
      noStroke();
      rect(x, plotY1, 1, plotY2 - plotY1);

      x = map(getDaysBetween(globalMinDate, dateFrom), 0, getDaysBetween(globalMinDate, globalMaxDate), plotX1, plotX2);
      rect(x, plotY1, 1, plotY2 - plotY1);

      fill(0);
    }
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
    if (computerPart.isHover()) {
      strokeWeight(THICKER_STROKE);
    } else {
      strokeWeight(DEFAULT_STROKE_WIDTH);
    }
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
      
      float x = map(getDaysBetween(globalMinDate, currentDate), 0, getDaysBetween(globalMinDate, globalMaxDate), plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      curveVertex(x, y);
      // Double the curve points for the start and stop
      if ((day == 0) || (day == daysBetween - 1)) {
        curveVertex(x, y);
      }
    }

    endShape();
    stroke(0);
    strokeWeight(DEFAULT_STROKE_WIDTH);
  }

  private void drawDataCurve(Stock stock) {
    LocalDate minDate, maxDate;
    long daysBetween = 0;

    noFill();
    stroke(stock.displayedColor);
    if (stock.isHover()) {
      strokeWeight(THICKER_STROKE);
    } else {
      strokeWeight(DEFAULT_STROKE_WIDTH);
    }
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
      
      float x = map(getDaysBetween(globalMinDate, currentDate), 0, getDaysBetween(globalMinDate, globalMaxDate), plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      curveVertex(x, y);
      // Double the curve points for the start and stop
      if ((day == 0) || (day == daysBetween - 1)) {
        curveVertex(x, y);
      }
    }

    endShape();
    stroke(0);
    strokeWeight(DEFAULT_STROKE_WIDTH);
  }
}
