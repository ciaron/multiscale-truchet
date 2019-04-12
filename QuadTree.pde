class QuadTree {
  Rectangle boundary;

  Tile tile;
  int level;
  Boolean divided = false;

  QuadTree parent;

  // subtrees, if any
  QuadTree northwest, northeast, southwest, southeast;

  /* constructor */
  QuadTree(Rectangle _b, int _level, QuadTree _p) {
    parent = _p;
    boundary = _b;
    level = _level;
    this.tile = new Tile(boundary, level);
  }

  /* Subdivide the node of QuadTree at the given x,y position (a PVector) */

  void subdivide(PVector p) {
    if (!this.boundary.contains(p)){
      return;
    }
    if (!this.divided) {
      float X = this.boundary.x;
      float Y = this.boundary.y;
      float W = this.boundary.w;
      float H = this.boundary.h;

      Rectangle nw = new Rectangle(X - W/4, Y - H/4, W/2, H/2);
      Rectangle ne = new Rectangle(X + W/4, Y - H/4, W/2, H/2);
      Rectangle sw = new Rectangle(X - W/4, Y + H/4, W/2, H/2);
      Rectangle se = new Rectangle(X + W/4, Y + H/4, W/2, H/2);

      northwest = new QuadTree(nw, this.level+1, this);
      northeast = new QuadTree(ne, this.level+1, this);
      southwest = new QuadTree(sw, this.level+1, this);
      southeast = new QuadTree(se, this.level+1, this);

      this.divided = true;
    } else {
      this.northwest.subdivide(p);
      this.northeast.subdivide(p);
      this.southwest.subdivide(p);
      this.southeast.subdivide(p);
    }
  }

  void join(PVector p) {
    // to join this tile and its siblings
    // just set divided=false on parent
    if (!this.boundary.contains(p)){
      return;
    }
    if (!this.divided) {
      if (parent != null)
        parent.divided = false;
    } else {
      this.northwest.join(p);
      this.northeast.join(p);
      this.southwest.join(p);
      this.southeast.join(p);
    }
  }

  Boolean hover(PVector p) {

    if (!this.boundary.contains(p)) {
      return false;
    }

    if (!this.divided) {
      return true;
    } else {
      this.northwest.hover(p);
      this.northeast.hover(p);
      this.southwest.hover(p);
      this.southeast.hover(p);
    }
    return false;
  }

  void scroll(String dir) {

    if (this.divided) {
      northwest.scroll(dir);
      northeast.scroll(dir);
      southwest.scroll(dir);
      southeast.scroll(dir);
    } else {
      if (  this.hover(new PVector(mouseX, mouseY)) ) {
        //this.tile.motif = abs((this.tile.motif + n) % 15);
        this.tile.select(dir);
      } else {
        //qt.tile.highlight = false;
      }
    }
  }
  /* Draw the tiles. This is done via a breadth-first traversal of the QuadTree
     We need to draw the tiles in descending order of size (i.e. higher levels first)
  */
  void show() {

    Queue<Tile> drawqueue = new ArrayDeque<Tile>();
    Queue<QuadTree> traverse = new ArrayDeque<QuadTree>();

    traverse.add(this);

    QuadTree qt;
    while (!traverse.isEmpty()){
      qt = traverse.remove();
      if (qt.divided) {
        traverse.add(qt.northwest);
        traverse.add(qt.northeast);
        traverse.add(qt.southwest);
        traverse.add(qt.southeast);
      } else {
        if (  qt.hover(new PVector(mouseX, mouseY)) ) {
          qt.tile.highlight = true;
        } else {
          qt.tile.highlight = false;
        }
        drawqueue.add(qt.tile);
      }
    }

    for (Tile t : drawqueue){
      t.draw();
    }

    if (showrect) {
      for (Tile t : drawqueue){
        t.outline();
        //this.hover(new PVector(mouseX, mouseY))
      }
    }
  }
}
