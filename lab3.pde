Parser data;
Pie pie;

void setup(){
  size(800, 1000);
  if (surface != null) {
    surface.setResizable(true);
  }
  
  data = new Parser();
  String filePath = "data.csv";
  data.parse(filePath);
  pie = new Pie(data, 0.5, 0.5, 0.5);
}

void draw() {
  pie.drawPie();
}