void drawtile(int motif) {
  /* The 15 motifs are numbered in the same order they appear in the
     Bridges 2018 paper by Christopher Carlson

   0: \    1: /   2: -   3: |   4: +.   5: x.   6: +
   7: fne  8: fsw   9: fnw  10: fse  11: tn  12: ts  13: te  14: tw
  */
  float x = width/2;
  float y = height/2;
  float w = width/3;
  float h = height/3;

  float smallr =  w / 6;
  float bigr =  w / 3;
  float arcd = 2 * 2 * w / 3;

  noStroke();
  rectMode(CENTER);
  //fill(this.color[1]);
  fill(255); //bg
  rect(x, y, w, h);
  //fill(this.color[0]);
  fill(0); //fg

  switch(motif){
    case 0: // '\'
      arc(x + w/2, y - h/2, arcd, arcd, PI / 2, PI);
      arc(x - w/2, y + h/2, arcd, arcd, 3 * PI / 2, 2 * PI);
      break;
    case 1: // '/'
      break;
    case 2: // '-'
      break;
    case 3: // '|'
      break;
    case 4: // '+.'
      break;
    case 5: // 'x.'
      break;
    case 6: // '+'
      break;
    case 7: // 'fne'
      break;
    case 8: // 'fsw'
      break;
    case 9: // 'fnw'
      break;
    case 10: // 'fse'
      break;
    case 11: // 'tn'
      break;
    case 12: // 'ts'
      break;
    case 13: // 'te'
      break;
    case 14: // 'tw'
      break;


    default:
      println("Invalid motif");
  }

  //fill(this.color[1]);
  fill(255);
  ellipse(x - w/2, y - h/2, bigr, bigr);
  ellipse(x + w/2, y - h/2, bigr, bigr);
  ellipse(x - w/2, y + h/2, bigr, bigr);
  ellipse(x + w/2, y + h/2, bigr, bigr);

  //fill(this.color[0]);
  fill(0);
  ellipse(x, y - h/2, smallr, smallr);
  ellipse(x + w/2, y, smallr, smallr);
  ellipse(x, y + h/2, smallr, smallr);
  ellipse(x - w/2, y, smallr, smallr);
}

void setup() {
  background(127);
  size(400, 400);
  drawtile(0);
}

void draw() {

}
