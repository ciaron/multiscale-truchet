class QuadTree {
  Rectangle boundary;

  int level;
  int motif;
  QuadTree northwest, northeast, southwest, southeast;
  ArrayList<PVector> points;
  Boolean divided = false;

  QuadTree(Rectangle _b, int _level, int _motif) {
    points = new ArrayList<PVector>();
    boundary = _b;
    level = _level;
    motif = _motif;
  }

  void split(PVector p) {
    if (!this.boundary.contains(p)){
      return;
    }

    // if (this.points.size() < 1) {
    //   this.points.add(p);
    // } else
    {
      if (!this.divided) {
        subdivide();
      }
else {
      this.northwest.split(p);
      this.northeast.split(p);
      this.southwest.split(p);
      this.southeast.split(p);
    }
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
  void print(int level) {
    println(nf(0,level), this.boundary.x, this.boundary.y, this.boundary.w, this.boundary.h);
    if (this.divided) {
     northwest.print(level+1);
     northeast.print(level+1);
     southwest.print(level+1);
     southeast.print(level+1);

    }

  }
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
