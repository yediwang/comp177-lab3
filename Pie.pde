class Pie {
  Parser data;
  float r;
  float x;
  float y;
  float angle[];
  boolean flag;
  float donut_ratio;
  float donut_D;
  
  Pie(Parser parser, float r, float x, float y){
    data = parser;
    this.x = x;
    this.y = y;
    this.r = r;
    angle = new float[data.values.length+1];
    flag = false;
    donut_ratio = 0.6;
    donut_D = 0;
  }
  
  void drawPie() {
    float lastAngle = 0;
    float absX = x * width;
    float absY = y * height;
    float absD = r * min(width, height);
    angle[0] = 0;
    for(int i = 0; i < data.values.length; i++) {
      stroke(255,255,255);
      if(in_which_ellipse()==i) {
        fill(211,238,233);
        arc(absX, absY, 1.1*absD, 1.1*absD, lastAngle, lastAngle+radians(data.values[i]), PIE);
      }
      else {
        fill(136,226,210*(i+1)/data.values.length);
        arc(absX, absY, absD, absD, lastAngle, lastAngle+radians(data.values[i]), PIE);
      }
      lastAngle += radians(data.values[i]);
      angle[i+1] = lastAngle;
    }
    if(flag) {
      fill(191);
      if(donut_D < donut_ratio*absD) donut_D+=3;
      ellipse(absX, absY, donut_D, donut_D);
    }
    else {
      fill(191);
      if(donut_D > 0) donut_D-=3;
      ellipse(absX, absY, donut_D, donut_D);
    }
  }
  
  void drawDonut(boolean flag) {
    this.flag = flag;
  }
  
  int in_which_ellipse() {
    float absX = x * width;
    float absY = y * height;
    float absR = (r * min(width, height))/2;
    float a = sqrt(pow(mouseX-(absX+absR), 2) + pow(mouseY-absY, 2));
    float b = sqrt(pow(mouseX-absX, 2) + pow(mouseY-absY, 2));
    float c = absR;
    if(b < absR) {
      if((flag && b > donut_ratio*absR) || (!flag)) {
        float cos = (pow(b,2)+pow(c,2)-pow(a,2))/(2*b*c);
        float mouse_angle = 0;
        if(mouseY>absY) mouse_angle = acos(cos);
        else mouse_angle = 2*acos(-1)-acos(cos);
        for(int i = 0; i < data.values.length; i++) {
          if(mouse_angle > angle[i] && mouse_angle < angle[i+1]) return i;
        }
      }
    }
    return -1;
  }
}