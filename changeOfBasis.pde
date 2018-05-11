
// draw vector spaces given a particular basis
// change the basis, update the vector space

PVector[] standardBasis = new PVector[] {new PVector(1, 0), new PVector(0, 1)};
PVector[] newBasis = standardBasis;
PVector[] inverseBasis = standardBasis;
final int scale = 100;
int largerDim;

ArrayList<PVector> field = new ArrayList<PVector>();


void setup() {
  size(800, 800);
  background(0);
  stroke(255);

  largerDim = height;
  if (width - height > 0) {
    largerDim = width;
  }

  newBasis[0] = new PVector(3, 1);
  newBasis[1] = new PVector(1, 2);
  
  //inverseBasis[0] = new PVector(0.4, -0.2);
  //inverseBasis[1] = new PVector(-0.2, 0.6);
  
  generateField();
  
}

void draw() {
  background(0);
  drawStandardBasis();
  //testPoints();
  drawConnections();
}

void drawStandardBasis() {
  // draw vertical lines
  for (int i = 0; i < largerDim / scale; i++) {

    // bold verticals every 1
    stroke(255, 70);
    strokeWeight(1);
    line(width/2 + scale * i, 0, width/2 + scale * i, height);
    line(width/2 - scale * i, 0, width/2 - scale * i, height);

    // bold horizontals
    line(0, height/2 + scale * i, width, height/2 + scale * i);
    line(0, height/2 - scale * i, width, height/2 - scale * i);

    // faint verticals every 0.5
    stroke(255, 50);
    line(width/2 + 0.5 * scale * i, 0, width/2 + 0.5 * scale * i, height);
    line(width/2 - 0.5 * scale * i, 0, width/2 - 0.5 * scale * i, height);

    // faint horizontals
    line(0, height/2 + 0.5 * scale * i, width, height/2 + 0.5 * scale * i);
    line(0, height/2 - 0.5 * scale * i, width, height/2 - 0.5 * scale * i);
  }
}






void generateField() {
  // start with standard basis points
  // generate a 3x3 field around active window
  for(int i = 0; i < width / scale; i++) {
    for(int j = 0; j < height / scale; j++) {
      field.add(new PVector(i * scale, j * scale));
    }
  }
  // field.add(new PVector(width/2 + scale, height/2));
}

void transform(PVector[] basis) {
  for(PVector v : field) {
    
    //println(newBasis[0].y);
    //println((v.x - width/2) / scale);
    //println(newBasis[1].y);
    //println((v.y - height/2) / scale);
    //println((newBasis[0].y * (v.x - width/2) / scale) + (newBasis[1].y * (v.y - height/2) / scale));
    
    float vx = (newBasis[0].x * (v.x - width/2) / scale) + (newBasis[1].x * (v.y - height/2) / scale);
    float vy = (newBasis[0].y * (v.x - width/2) / scale) + (newBasis[1].y * (v.y - height/2) / scale);
    v.x = width/2 + vx * scale;
    v.y = height/2 - vy * scale; // account for top-left origin
    // println(v.y);
  }
}

//void transform2() {
//  for(PVector v : field) {
//    v.x = inverseBasis[0].x * v.x + inverseBasis[1].x  v.y;
//    v.y = inverseBasis[0].y * v.x + inverseBasis[1].y + v.y;
//  }
//}



void drawConnections() {
  for (PVector v : field) {
    stroke(40,255,255);
    float x1 = v.x;
    float y1 = v.y;
    float x2 = x1 + scale * newBasis[0].x;
    float y2 = y1 - scale * newBasis[0].y;
    line(x1, y1, x2, y2); // draw i-hat

    x2 = x1 + scale * newBasis[1].x;
    y2 = y1 - scale * newBasis[1].y;
    line(x1, y1, x2, y2); // draw j-hat
  }
}

void testPoints() {
  for (PVector v : field) {
    ellipse(v.x, v.y, 10, 10);
  }
}

void mouseClicked() {
  transform();
}
