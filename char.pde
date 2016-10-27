class Char {
  // char table and position
  int CX, CY;
  float CXx, CYy;
  int n;
  // pixel table
  float[] pX, pY;
  int type = 0;

  char input;

  boolean pixelUse = false;
  boolean oldStat = false;

  boolean select = false;
  boolean mselect = false;
  int[] per = {10, 4, 5, 10, 2, 3, 10, 0, 1};
  boolean[] pixi = {false, false, false, false, false, false};
  // pavé munérique / pixi[i] correspondant
  // > 7 / 0 // 8 / 1  // 4 / 2  // 5 / 3  // 1 / 4  // 2 / 5

  Char(int _row, int _col, int _number) {
    n = _number;
    CX = _col;
    CY = _row;
    CXx = border+(CX*((width-(border))/columnChar));
    CYy = border+(CY*((height-(border))/rowChar));

    // Generat pixel position
    pX = new float[2];
    pX[0] = CXx - CharWidth/4;
    pX[1] = CXx + CharWidth/4;

    pY = new float[3];
    pY[0] = CYy - 2.5*(CharHeight/7);
    pY[1] = CYy;
    pY[2] = CYy + 2.5*(CharHeight/7);
  }

  void run() {
    rectMode(CENTER);
    mselect = selected();

    if (graphicMode) {
      displayPixi();
    }
    // type 0 none > 1 graphic > 2 GraphicPixelate > 3 Text 
    switch(type) {
    case 0:
      break;
    case 1:
      displayPixi();
      break;
    case 2 :      
      displayPixi();
      break;
    case 3 :
      displayChar();
      break;
    }
    display();
  }

  void display() {
    noFill();
    if (!grid) {
      noStroke();
    } else if (select || mselect) {
      stroke(160, 0, 0);
    } else {
      stroke(0, 0, 50);
    }
    rect(CXx, CYy, CharWidth, CharHeight);
    //fill(255);
    //text(n+":"+CX+"/"+CY, CXx, CYy);
  }

  void displayPixi() {
    for (int i = 0; i < 6; i ++) {
      float x = pX[i%2]; 
      float y = pY[i/2]; 

      if (pixi[i]) {
        noStroke();
        fill(255);
      } else if (!grid || !graphicMode) {
        noStroke();
      } else if (select || mselect) {
        stroke(160, 0, 0);
      } else {    
        stroke(25, 25, 25);
      }
      //text(i, x, y);
      if (type == 1 ) {
        if (i == 2 || i == 3) {
          rect(x, y, PixelWidth, 3*PixelHeight);
        } else {
          rect(x, y, PixelWidth, 2*PixelHeight);
        }
      } else {
        rect(x, y, 3*PixelWidth/4, 3*PixelHeight/4);
      }

      noFill();
    }
  }

  void displayChar() {
    textAlign(CENTER, CENTER);
    text(input, CXx, CYy);
  }

  boolean selected() {
    float distM2C = dist(mouseX, mouseY, CXx, CYy); 
    if (distM2C < 15) {
      if (pressed) {
        select = true;
      }
      return true;
    } else {
      return false;
    }
  }


  void clearPixel() {
    for (int i = 0; i < 6; i++) {
      pixi[i] = false;
    }
  }
  void pixelHold(int _pixel, boolean _re) {
    if (_re && graphicMode) {
      if (!pixelate) {
        type = 1;
      } else {
        type = 2;
      }
      _pixel = per[_pixel];
      pixi[_pixel] = !pixi[_pixel];
    } else if (_re && !graphicMode) {
      clearPixel();
      type = 3;
      input = char(_pixel);
    } else if (_pixel > 20 && !_re) {      
      select = false;
    } else {
    }
  }
}