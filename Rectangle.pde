class Rectangle {
  float x,y,w,h;

  Rectangle(float _x, float _y, float _w, float _h) {
    x = _x; y = _y; w = _w; h = _h;
  }

  Boolean contains(PVector p) {
    return (p.x > this.x - this.w/2 &&
            p.x < this.x + this.w/2 &&
            p.y > this.y - this.h/2 &&
            p.y < this.y + this.h/2 );
  }

  Boolean intersects(Rectangle range) {
    return !(range.x - range.w > this.x + this.w ||
             range.x + range.w < this.x - this.w ||
             range.y - range.h > this.y + this.h ||
             range.y + range.h < this.y - this.h );
  }

  void draw() {
    rectMode(CENTER); noFill(); strokeWeight(1); stroke(0,255,0);
    rect(this.x, this.y, this.w, this.h);
  }

}
