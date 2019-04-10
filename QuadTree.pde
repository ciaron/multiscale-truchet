class QuadTree {
  Rectangle boundary;
  int capacity;
  ArrayList<PVector> points;
  QuadTree northwest, northeast, southwest, southeast;
  Boolean divided = false;

  QuadTree(Rectangle _b, int n) {
    boundary = _b;
    capacity = n;
    points = new ArrayList<PVector>();
  }

  void insert(PVector p) {
    if (!this.boundary.contains(p)){
      return;
    }

    if (this.points.size() < capacity) {
      this.points.add(p);
    } else {
      if (!this.divided) {
        subdivide();
      }

      this.northwest.insert(p);
      this.northeast.insert(p);
      this.southwest.insert(p);
      this.southeast.insert(p);
    }

    this.redistribute();

  }

  void subdivide() {
    float X = this.boundary.x;
    float Y = this.boundary.y;
    float W = this.boundary.w;
    float H = this.boundary.h;

    Rectangle nw = new Rectangle(X - W/2, Y - H/2, W/2, H/2);
    Rectangle ne = new Rectangle(X + W/2, Y - H/2, W/2, H/2);
    Rectangle sw = new Rectangle(X - W/2, Y + H/2, W/2, H/2);
    Rectangle se = new Rectangle(X + W/2, Y + H/2, W/2, H/2);

    northwest = new QuadTree(nw, capacity);
    northeast = new QuadTree(ne, capacity);
    southwest = new QuadTree(sw, capacity);
    southeast = new QuadTree(se, capacity);

    this.divided = true;

  }

  void redistribute() {
    // redistribute points to children in subdivision
    if (this.divided) {
      for (int i = this.points.size() - 1; i >= 0; i--) {

        PVector p = this.points.get(i);

        this.northwest.insert(p);
        this.northeast.insert(p);
        this.southwest.insert(p);
        this.southeast.insert(p);

        this.points.remove(i);
      }

      this.northwest.redistribute();
      this.northeast.redistribute();
      this.southwest.redistribute();
      this.southeast.redistribute();
    }
  }

  void query(Rectangle range, ArrayList<PVector> found) {

    if (!this.boundary.intersects(range)) {
      // empty array
      return;
    } else {
      for (PVector p : this.points) {
        if (range.contains(p)) {
          found.add(p);
        }
      }

      if (this.divided) {
        this.northwest.query(range,found);
        this.northeast.query(range,found);
        this.southwest.query(range,found);
        this.southeast.query(range,found);
      }
      return;
    }
  }

  void show() {

    stroke(255);
    rect(this.boundary.x, this.boundary.y, this.boundary.w * 2, this.boundary.h * 2);

    pushStyle();
    for (PVector p : this.points) {
      stroke(255,0,0);
      strokeWeight(1);
      fill(255,0,0);
      ellipse(p.x, p.y, 4, 4);
    }
    popStyle();

    if (this.divided) {
      this.northwest.show();
      this.northeast.show();
      this.southwest.show();
      this.southeast.show();
    }

    //print(this.boundary.w, this.boundary.h, this.points, "\n");

  }

}
