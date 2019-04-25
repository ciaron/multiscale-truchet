class Tile {

  /* The 15 motifs are numbered in the same order they appear in the
     Bridges 2018 paper by Christopher Carlson

   0: \    1: /   2: -   3: |   4: +.   5: x.   6: +
   7: fne  8: fsw   9: fnw  10: fse  11: tn  12: ts  13: te  14: tw
   15: blank (xtra)
  */

  Rectangle boundary;
  int[] motifs = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14};
  //int[] motifs = {1,9,10};
  int motif;
  int idx_motif=1;
  int level;

  int[] colors = { 0, 255 };
  Boolean highlight = false;

  Tile(Rectangle _b, int _l, int[] _colors) {

    // make a deep copy of the colors array
    System.arraycopy(_colors, 0, colors, 0, _colors.length);

    idx_motif = floor(random(0, motifs.length));
    motif = motifs[idx_motif];

    level = _l;

    if (this.level % 2 != 0) {
      invert();
    }

    boundary = _b;
  }

  void invert() {
    // invert color set.
    int tmp = this.colors[0];
    this.colors[0] = this.colors[1];
    this.colors[1] = tmp;
  }

  void select(String dir) {
    if (dir == "UP") idx_motif+=1;
    if (dir == "DOWN") idx_motif-=1;
    int n = motifs.length;
    motif = motifs[(idx_motif % n + n) % n];
    println(motif, dir);
  }

  void outline() {

    noFill();
    strokeWeight(1);

    if (this.highlight) {
      stroke(255,0,0);
      strokeWeight(4);
      Rectangle h = new Rectangle(boundary.x, boundary.y, boundary.w-4, boundary.h-4);
      h.draw();
    }
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

    switch(this.motif) {
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
