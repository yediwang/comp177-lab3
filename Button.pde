class Button {
  Pie pie;
  boolean clicked;
  float a;
  float b;
  float c;
  float d;
  
  Button(Pie pie) {
    this.pie = pie;
    clicked = false;
    a = width-100;
    b = 20;
    c = 80;
    d = 30;
  }
  
  void drawButton() {
    stroke(100);
    fill(120);
    rect(a, b, c, d, 5);
  }
  
  void clickButton() {
    if(mouseX > a && mouseX < a+c && mouseY > b && mouseY < b+d) {
      if(!clicked) {
        clicked = true;
        pie.drawDonut(true);
      }
      else {
        clicked = false;
        pie.drawDonut(false);
      }
    }
  }
}