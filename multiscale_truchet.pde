void drawtile(int motif, Rectangle boundary, int[] colors) {
  /* The 15 motifs are numbered in the same order they appear in the
     Bridges 2018 paper by Christopher Carlson

   0: \    1: /   2: -   3: |   4: +.   5: x.   6: +
   7: fne  8: fsw   9: fnw  10: fse  11: tn  12: ts  13: te  14: tw
  */
  float x = boundary.x;
  float y = boundary.y;
  float w = boundary.w;
  float h = boundary.h;

  float smallr =  2 * w / 6;
  float bigr =  2 * w / 3;
  float arcd = 2 * 2 * w / 3;

  noStroke();
  rectMode(CENTER);
  //fill(this.color[1]);
  fill(colors[0]); //bg
  rect(x, y, w, h);
  //fill(this.color[0]);
  fill(colors[1]); //fg

  switch(motif){
    case 0: // '\'
      arc(x + w/2, y - h/2, arcd, arcd, PI / 2, PI);
      arc(x - w/2, y + h/2, arcd, arcd, 3 * PI / 2, 2 * PI);
      break;
    case 1: // '/'
      arc(x - w/2, y - h/2, arcd, arcd, 0, PI / 2);
      arc(x + w/2, y + h/2, arcd, arcd, PI, 3 * PI / 2);
      break;
    case 2: // '-'
      rect(x, y, w, smallr);
      break;
    case 3: // '|'
      rect(x, y, smallr, h);
      break;
    case 4: // '+.'
      break;
    case 5: // 'x.'
      fill(colors[0]);
      rect(x, y, w, h);
      break;
    case 6: // '+'
      rect(x, y, w, smallr);
      rect(x, y, smallr, h);
      break;
    case 7: // 'fne'
      arc(x + w/2, y - h/2, arcd, arcd, PI / 2, PI);
      break;
    case 8: // 'fsw'
      arc(x - w/2, y + h/2, arcd, arcd, 3 * PI / 2, 2 * PI);
      break;
    case 9: // 'fnw'
      arc(x - w/2, y - h/2, arcd, arcd, 0, PI / 2);
      break;
    case 10: // 'fse'
      arc(x + w/2, y + h/2, arcd, arcd, PI, 3 * PI / 2);
      break;
    case 11: // 'tn'
      fill(colors[1]);
      rect(x, y-smallr/2, w, bigr);
      break;
    case 12: // 'ts'
      fill(colors[1]);
      rect(x, y + smallr/2, w, bigr);
      break;
    case 13: // 'te'
      fill(colors[1]);
      rect(x + smallr/2, y, bigr, h);
      break;
    case 14: // 'tw'
      fill(colors[1]);
      rect(x - smallr/2, y, bigr, h);
      break;
    default:
      println("Invalid motif");
  }

  //fill(this.color[1]);
  fill(colors[0]);
  ellipse(x - w/2, y - h/2, bigr, bigr);
  ellipse(x + w/2, y - h/2, bigr, bigr);
  ellipse(x - w/2, y + h/2, bigr, bigr);
  ellipse(x + w/2, y + h/2, bigr, bigr);

  //fill(this.color[0]);
  fill(colors[1]);
  ellipse(x, y - h/2, smallr, smallr);
  ellipse(x + w/2, y, smallr, smallr);
  ellipse(x, y + h/2, smallr, smallr);
  ellipse(x - w/2, y, smallr, smallr);
}

int motif;
int border = 120;
int rc = 1; //rows and columns
ArrayList<Rectangle> rects;
int[] colors = { 0, 255 };
QuadTree qt;

void setup() {
  size(800, 800);
  background(127);

  rects = new ArrayList<Rectangle>();

  int tilesize = (width - 2*border) / rc; // assume width and height equal

  // generate some base tiles
  for (int x=border+tilesize/2; x<width-border; x+=tilesize) {
    for (int y=border+tilesize/2; y<height-border; y+=tilesize) {
      rects.add(new Rectangle(x, y, tilesize, tilesize));
    }
  }
}

void draw() {
  background(0);//127,32);

  for (Rectangle r : rects) {
    drawtile(floor(random(0.0, 15.0)), r, colors);
    r.draw();
  }
  noLoop();
}

void mouseClicked() {
  loop();
}

void keyPressed() {
  if (key == ' ') {
    loop();
  }
}
