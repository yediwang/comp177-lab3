interface ButtonCallback {
  void buttonCallback();
}

class Button {
  float x, y, w, h;
  color on, off;
  String text;
  ButtonCallback callback;
  private color c;
  
  Button(float x, float y, float w, float h, color on, color off, String text, ButtonCallback callback) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.on = on;
    this.off = off;
    this.text = text;
    this.callback = callback;
    this.c = off;
  }
  
  void draw() {
    float absX = this.x * width;
    float absY = this.y * height;
    float absW = this.w * width;
    float absH = this.h * height;
    
    fill(this.c);
    rect(absX, absY, absW, absH);
    
    fill(color(0, 0, 0));
    textSize(this.h * 0.6 * height);
    float textW = textWidth(this.text);
    text(this.text, absX + (absW - textW) / 2, absY + textAscent() + textDescent());
  }
  
  Boolean isOver() {
    float fracMX = mouseX / float(width);
    float fracMY = mouseY / float(height);
    return fracMX >= this.x && fracMX <= this.x + this.w &&
           fracMY >= this.y && fracMY <= this.y + this.h;
  }
  
  void onOver() {
    this.c = this.on;
  }
  
  void onOff() {
    this.c = this.off;
  }
  
  void onClick() {
    this.callback.buttonCallback();
  }
}