class Tile {

  /* The 15 motifs are numbered in the same order they appear in the
     Bridges 2018 paper by Christopher Carlson

   0: \    1: /   2: -   3: |   4: +.   5: x.   6: +
   7: fne  8: fsw   9: fnw  10: fse  11: tn  12: ts  13: te  14: tw
  */

  Rectangle boundary;
  int motif;
  int level;
  int[] colors = {0, 255};

  Tile(Rectangle _b, int _l) {
    motif = floor(random(0, 15));
    level = _l;

    if (level % 2 != 0) {
      int tmp = colors[0];
      colors[0] = colors[1];
      colors[1] = tmp;
    }
    boundary = _b;
  }

  void outline() {
    noFill();
    strokeWeight(1);
    stroke(0,255,0);
    boundary.draw();
  }

  void draw() {

    float x = this.boundary.x;
    float y = this.boundary.y;
    float w = this.boundary.w;
    float h = this.boundary.h;

    float smallr =  2 * w / 6;
    float bigr =  2 * w / 3;
    float arcd = 2 * 2 * w / 3;

    noStroke();
    rectMode(CENTER);
    fill(this.colors[1]); //bg
    rect(x, y, w, h);
    fill(this.colors[0]); //fg

    switch(this.motif){
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
        fill(this.colors[0]);
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
        fill(this.colors[0]);
        rect(x, y-smallr/2, w, bigr);
        break;
      case 12: // 'ts'
        fill(this.colors[0]);
        rect(x, y + smallr/2, w, bigr);
        break;
      case 13: // 'te'
        fill(this.colors[0]);
        rect(x + smallr/2, y, bigr, h);
        break;
      case 14: // 'tw'
        fill(this.colors[0]);
        rect(x - smallr/2, y, bigr, h);
        break;
      default:
        println("Invalid motif");
    }

    fill(this.colors[1]);
    ellipse(x - w/2, y - h/2, bigr, bigr);
    ellipse(x + w/2, y - h/2, bigr, bigr);
    ellipse(x - w/2, y + h/2, bigr, bigr);
    ellipse(x + w/2, y + h/2, bigr, bigr);

    fill(this.colors[0]);
    ellipse(x, y - h/2, smallr, smallr);
    ellipse(x + w/2, y, smallr, smallr);
    ellipse(x, y + h/2, smallr, smallr);
    ellipse(x - w/2, y, smallr, smallr);
  }
}
