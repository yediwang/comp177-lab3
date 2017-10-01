class Pie {
  Parser data;
  float r;
  float x;
  float y;
  float angle[];
  
  Pie(Parser parser, float r_temp, float x_temp, float y_temp){
    data = parser;
    x = x_temp;
    y = y_temp;
    r = r_temp;
    angle = new float[data.values.length+1];
  }
  
  void drawPie() {
    float lastAngle = 0;
    float absX = x * width;
    float absY = y * height;
    float absD = r * min(width, height);
    angle[0] = 0;
    for(int i = 0; i < data.values.length; i++) {
      if(in_which_ellipse()==i) fill(255,9,144);
      else fill(255,255,144);
      arc(absX, absY, absD, absD, lastAngle, lastAngle+radians(data.values[i]), PIE);
      lastAngle += radians(data.values[i]);
      angle[i+1] = lastAngle;
    }
  }
  
  int in_which_ellipse() {
    float absX = x * width;
    float absY = y * height;
    float absR = (r * min(width, height))/2;
    float a = sqrt(pow(mouseX-(absX+absR), 2) + pow(mouseY-absY, 2));
    float b = sqrt(pow(mouseX-absX, 2) + pow(mouseY-absY, 2));
    float c = absR;
    if(b < absR) {
      float cos = (pow(b,2)+pow(c,2)-pow(a,2))/(2*b*c);
      float mouse_angle = 0;
      if(mouseY>absY) mouse_angle = radians(90-90*cos);
      else mouse_angle = radians(270+90*cos);
      for(int i = 0; i < data.values.length; i++) {
        if(mouse_angle > angle[i] && mouse_angle < angle[i+1]) return i;
      }
    }
    return -1;
  }
}