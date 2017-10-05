final color BG_CLR = color(255, 255, 255);

DataTable tbl = null;
Pie pie = null;
Button btn = null;

void setup() {
  size(640, 480);
  surface.setResizable(true);
  
  selectInput("Select a file to process", "parseData");
  
}

void draw() {
  background(BG_CLR);
  if (pie != null && btn != null) {
    mouseOver();
    pie.draw();
    btn.draw();
  }
}

void parseData(File file) {
  tbl = new DataTable(file.getAbsolutePath());
  tableToRadians(tbl);
  pie = new Pie(0.4, 0.5, 0.5, tbl, 
                color(135, 206, 250), color(0, 0, 139), color(123, 104, 238), BG_CLR);
  btn = new Button(0.02, 0.02, 0.2, 0.05, 
                   color(100, 100, 100), color(200, 200, 200), "Change Mode",
                   pie);
}

void tableToRadians(DataTable table) {
  float total = 0;
  for (int i = 0; i < table.points.size(); i++) 
    total += table.points.get(i).value;
  for (DataPoint pt : table.points)
    pt.value = pt.weight * 2 * PI / total;
}

void mouseOver() {
  if (btn.isOver()) {
    btn.onOver();
  } else {
    btn.onOff();
  }
}

void mouseClicked() {
  if (btn.isOver()) btn.onClick();
  if (pie.isOver()) pie.onClick();
}