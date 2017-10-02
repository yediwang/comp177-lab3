Parser data;
Pie pie;
Button button;

void setup(){
  size(800, 1000);
  if (surface != null) {
    surface.setResizable(true);
  }
  
  data = new Parser();
  String filePath = "data.csv";
  data.parse(filePath);
  pie = new Pie(data, 0.5, 0.5, 0.5);
  button = new Button(pie);
}

void draw() {
  fill(191);
  rect(0,0,width,height);
  pie.drawPie();
  button.drawButton();
}

void mouseClicked() {
  button.clickButton();
}