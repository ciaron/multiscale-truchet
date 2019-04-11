/* inspiration and help from the JavaScript version here:
      https://editor.p5js.org/Varyter/sketches/j23pb7_ua
*/

import java.util.Queue;
import java.util.ArrayDeque;
int border = 120;
int rc = 1; // starting rows and columns

//int[] colors = { 255, 0 };
int tilesize;
QuadTree qt;

void setup() {
  size(800, 800);
  background(127);

  tilesize = (width - 2*border) / rc; // assume width and height equal

  // initial "root" QuadTree
  qt = new QuadTree( new Rectangle(width/2, height/2, tilesize, tilesize), 0 );
}

void draw() {
  background(255);//127,32);

  qt.mkqueue();

  qt.show();
}

void mousePressed() {
  PVector p = new PVector(mouseX, mouseY);
  qt.split(p);

  if (mouseButton == RIGHT) {
  }
}

void keyPressed() {
  if (key == ' ') {
    // re-initialise
    qt = new QuadTree(new Rectangle(width/2, height/2, tilesize, tilesize), 0);
  }
}
