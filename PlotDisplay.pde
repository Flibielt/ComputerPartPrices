void displayPlots() {
  float x = WINDOW_LEFT_COLUMN + 2 * MARGIN;

  noFill();
  rect(x, PRODUCT_PLOT_Y, WINDOW_RIGHT_COLUMN, PLOT_HEIGHT);
  rect(x, STOCK_PLOT_Y, WINDOW_RIGHT_COLUMN, PLOT_HEIGHT);
  rect(x, DATE_PICKER_Y, WINDOW_RIGHT_COLUMN, DATE_PICKER_HEIGHT);

  computerPartPlot.setPosition(x, x + WINDOW_RIGHT_COLUMN, PRODUCT_PLOT_Y, PRODUCT_PLOT_Y + PLOT_HEIGHT);
  computerPartPlot.display();

  stockPlot.setPosition(x, x + WINDOW_RIGHT_COLUMN, STOCK_PLOT_Y, STOCK_PLOT_Y + PLOT_HEIGHT);
  stockPlot.display();
}
