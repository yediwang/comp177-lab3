static final float EXPAND = 1.1;
static final float HOLE_RATIO = 0.5;
static final float HOLE_GROWTH = 0.02;
static final int MODES = 2;

class Pie implements ButtonCallback {
  float r, x, y;
  ArrayList<DataPoint> data;
  color from, to, hover, bg;
  private int drawMode; // 0 = PIE, 1 = DONUT;
  private float holeRatio;
  
  Pie(float r, float x, float y, DataTable tbl, color from, color to, color hover, color bg) {
    this.r = r;
    this.x = x;
    this.y = y;
    this.data = new ArrayList<DataPoint>(tbl.points);
    this.from = from;
    this.to = to;
    this.hover = hover;
    this.bg = bg;
    this.drawMode = 0;
    this.holeRatio = 0;
  }
  
  private color getColorAtIndex(int i) {
    if (this.data.size() == 1) return this.to;
    float multiplier = float(i) / (this.data.size() - 1);
    float rDiff = (red(this.to) - red(this.from)) * multiplier;
    float gDiff = (green(this.to) - green(this.from)) * multiplier;
    float bDiff = (blue(this.to) - blue(this.from)) * multiplier;
    return color(red(this.from) + rDiff, green(this.from) + gDiff, blue(this.from) + bDiff);
  }
  
  private Boolean inCircle(float x, float y, float r) {
    return pow(x, 2) + pow(y, 2) <= pow(r, 2);
  }
  
  private void drawHole() {
    if (this.drawMode == 0) {
      if (this.holeRatio > 0) {
        this.holeRatio -= HOLE_RATIO * HOLE_GROWTH;
      } else {
        return;
      }
    } else if (this.drawMode == 1 && this.holeRatio < HOLE_RATIO) {
      this.holeRatio += HOLE_RATIO * HOLE_GROWTH;
    }
    
    float absX = this.x * width;
    float absY = this.y * height;
    float absR = this.r * min(width, height);
    fill(this.bg);
    ellipse(absX, absY, 2 * absR * this.holeRatio, 2 * absR * this.holeRatio);
  }
  
  private int onWhichEllipse() {
    float absX = this.x * width;
    float absY = this.y * height;
    
    if (isOver()) {
      float mouseRad = atan2(mouseY - absY, mouseX - absX);
      mouseRad += mouseRad > 0 ? 0 : 2 * PI;
      float lastRad = 0;
      for (int i = 0; i < this.data.size(); i++) {
        DataPoint pt = this.data.get(i);
        if (mouseRad >= lastRad && mouseRad < lastRad + pt.value) return i;
        lastRad += pt.value;
      }
    }
    return -1;
  }
  
  Boolean isOver() {
    float absX = this.x * width;
    float absY = this.y * height;
    float absR = this.r * min(width, height);
    return inCircle(mouseX - absX, mouseY - absY, absR) &&
           !inCircle(mouseX - absX, mouseY - absY, absR * this.holeRatio);
  }
  
  void onClick() {
    float absX = this.x * width;
    float absY = this.y * height;
    
    float mouseRad = atan2(mouseY - absY, mouseX - absX);
    mouseRad += mouseRad > 0 ? 0 : 2 * PI;
    float lastRad = 0;
    for (int i = 0; i < this.data.size(); i++) {
      DataPoint pt = this.data.get(i);
      if (mouseRad >= lastRad && mouseRad < lastRad + pt.value) {
        if (mouseButton == LEFT) {
          float prop = (mouseRad - lastRad) / pt.value;
          float newRad = pt.value * prop;
          pt.value *= 1 - prop;
          this.data.add(i, new DataPoint(String.valueOf(i+1), newRad));
        } else if (mouseButton == RIGHT && this.data.size() > 1) {
          int prevIndex = i - 1 < 0 ? this.data.size() - 1 : i - 1;
          pt.value += this.data.get(prevIndex).value;
          this.data.remove(prevIndex);
          
        }
        return;
      }
      lastRad += pt.value;
    }
  }
  
  void draw() {
    float absX = this.x * width;
    float absY = this.y * height;
    float absR = this.r * min(width, height);
    
    if (this.data.size() > 1) {
      float lastRad = 0;
      for (int i = 0; i < this.data.size(); i++) {
        DataPoint pt = this.data.get(i);
        float drawR = onWhichEllipse() == i ? EXPAND * absR : absR;
        color drawClr = onWhichEllipse() == i ? this.hover : getColorAtIndex(i);
        fill(drawClr);
        arc(absX, absY, drawR * 2, drawR * 2, lastRad, lastRad + pt.value, PIE);
        lastRad += pt.value;
      }
    } else {
      float drawR = isOver() ? EXPAND * absR : absR;
      color drawClr = isOver() ? this.hover : this.to;
      fill(drawClr);
      ellipse(absX, absY, drawR * 2, drawR * 2);
    }
    
    drawHole();
  }
  
  // change mode
  void buttonCallback() {
    this.drawMode = (this.drawMode + 1) % MODES;
  }
}