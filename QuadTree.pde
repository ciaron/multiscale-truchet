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

  }

  void mkqueue() {
    Queue<Tile> drawqueue = new ArrayDeque<Tile>();
    Queue<QuadTree> traverse = new ArrayDeque<QuadTree>();

    traverse.add(this);

    QuadTree node;

    while (!traverse.isEmpty()){
      node = traverse.remove();
      if (node.divided) {
        traverse.add(node.northwest);
        traverse.add(node.northeast);
        traverse.add(node.southwest);
        traverse.add(node.southeast);
      } else {
        drawqueue.add(node.tile);
      }
    }

    for (Tile t : drawqueue){
      t.draw();
    }
  }


}
