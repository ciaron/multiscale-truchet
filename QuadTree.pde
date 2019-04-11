class QuadTree {
  Rectangle boundary;
  int level;
  //int motif;
  QuadTree northwest, northeast, southwest, southeast;
  Tile tile;
  Boolean divided = false;
  //int[] colors = { 255, 0 };

  QuadTree(Rectangle _b, int _level) {
    boundary = _b;
    level = _level;

    this.tile = new Tile(boundary, level);

  }

  void split(PVector p) {
    if (!this.boundary.contains(p)){
      return;
    }

    if (!this.divided) {
        subdivide();
    } else {
      this.northwest.split(p);
      this.northeast.split(p);
      this.southwest.split(p);
      this.southeast.split(p);
    }
  }

  void subdivide() {
    float X = this.boundary.x;
    float Y = this.boundary.y;
    float W = this.boundary.w;
    float H = this.boundary.h;

    Rectangle nw = new Rectangle(X - W/4, Y - H/4, W/2, H/2);
    Rectangle ne = new Rectangle(X + W/4, Y - H/4, W/2, H/2);
    Rectangle sw = new Rectangle(X - W/4, Y + H/4, W/2, H/2);
    Rectangle se = new Rectangle(X + W/4, Y + H/4, W/2, H/2);

    northwest = new QuadTree(nw, this.level+1);
    northeast = new QuadTree(ne, this.level+1);
    southwest = new QuadTree(sw, this.level+1);
    southeast = new QuadTree(se, this.level+1);

    this.divided = true;

  }

  void show() {

    //drawtile(this.motif, this.boundary, this.colors);
    this.tile.draw();

    if (this.divided) {
      this.northwest.show();
      this.northeast.show();
      this.southwest.show();
      this.southeast.show();
    }

    // stroke(255);
    // noFill();
    // rectMode(CENTER);
    // rect(this.boundary.x, this.boundary.y, this.boundary.w, this.boundary.h);

  }
}
