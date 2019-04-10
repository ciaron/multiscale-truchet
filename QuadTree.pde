class QuadTree {
  Rectangle boundary;

  int level;
  int motif;
  QuadTree northwest, northeast, southwest, southeast;
  Boolean divided = false;

  QuadTree(Rectangle _b, int _level, int _motif) {
    boundary = _b;
    level = _level;
    motif = _motif;
  }

  void insert(PVector p) {
    if (!this.boundary.contains(p)) {
      return;
    }

    if (!this.divided) {
        subdivide();
    } else {
      this.northwest.insert(p);
      this.northeast.insert(p);
      this.southwest.insert(p);
      this.southeast.insert(p);
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

    northwest = new QuadTree(nw, this.level+1, floor(random(0.0, 15.0)));
    northeast = new QuadTree(ne, this.level+1, floor(random(0.0, 15.0)));
    southwest = new QuadTree(sw, this.level+1, floor(random(0.0, 15.0)));
    southeast = new QuadTree(se, this.level+1, floor(random(0.0, 15.0)));

    this.divided = true;
    this.motif = -1;

  }

  // void query(Rectangle range, ArrayList<PVector> found) {
  //
  //   if (!this.boundary.intersects(range)) {
  //     // empty array
  //     return;
  //   } else {
  //     for (PVector p : this.points) {
  //       if (range.contains(p)) {
  //         found.add(p);
  //       }
  //     }
  //
  //     if (this.divided) {
  //       this.northwest.query(range,found);
  //       this.northeast.query(range,found);
  //       this.southwest.query(range,found);
  //       this.southeast.query(range,found);
  //     }
  //     return;
  //   }
  // }

  void show() {

    stroke(255);
    noFill();
    rectMode(CENTER);
    rect(this.boundary.x, this.boundary.y, this.boundary.w, this.boundary.h);

    // pushStyle();
    // for (PVector p : this.points) {
    //   stroke(255,0,0);
    //   strokeWeight(1);
    //   fill(255,0,0);
    //   ellipse(p.x, p.y, 4, 4);
    // }
    // popStyle();

    if (this.divided) {
      this.northwest.show();
      this.northeast.show();
      this.southwest.show();
      this.southeast.show();
    }
  }
}
