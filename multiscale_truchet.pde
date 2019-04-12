/* Original paper on multi-scale truchet patterns:
   https://archive.bridgesmathart.org/2018/bridges2018-39.html
   Multi-Scale Truchet Patterns
   Christopher Carlson
   Proceedings of Bridges 2018: Mathematics, Art, Music, Architecture, Education, Culture

   Inspiration and coding help from the JavaScript version here:
      https://editor.p5js.org/Varyter/sketches/j23pb7_ua
   and Dan Shiffman's QuadTree Coding Train video. */

import java.util.Queue;
import java.util.ArrayDeque;
int border = 120;
Boolean showrect = false;
int tilesize;
QuadTree qt;

void setup() {
  size(800, 800);
  background(127);
  tilesize = (width - 2*border); // assume square
  // initial "root" QuadTree
  qt = new QuadTree( new Rectangle(width/2, height/2, tilesize, tilesize), 0, null);
}

void draw() {
  background(255);
  qt.show();
}

void mousePressed() {
  PVector p = new PVector(mouseX, mouseY);
  if (mouseButton == LEFT) {
    qt.subdivide(p);
  } else if (mouseButton == RIGHT) {
    qt.join(p);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  //println(e);
  if (e<0) qt.scroll("UP");
  if (e>0) qt.scroll("DOWN");
}

void keyPressed() {
  if (key == ' ') {
    // re-initialise
    qt = new QuadTree(new Rectangle(width/2, height/2, tilesize, tilesize), 0, null);
  }
  if (key == 'r') {
    // toggle show rectangles
    showrect = !showrect;
  }

  if (key == 'n') {
    // toggle show rectangles
    qt.scroll("UP");
  }

  if (key == 'p') {
    // toggle show rectangles
    qt.scroll("DOWN");
  }

  if (key == 'j') {
    qt.join(new PVector(mouseX, mouseY));
  }
}
