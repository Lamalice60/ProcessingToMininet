//TODO :
// Gestion couleur
// Gestion type de typo
// Gestion des fond typo
// Affichage des options en cours ( Graphiclide/tex/couleurs/ ...)
// tootips souris ? aide cmd ?
// 
//DEFILEMENT ?
// Extraction des bytes / code 


int border = 50;

float CharWidth, CharHeight;
int rowChar = 24;  //24
int columnChar = 40;  //40
int cXS, cYS;

float PixelWidth, PixelHeight;
int rowPixel = 3;
int columnPixel = 2;
float rX, rY;

boolean grid = true;
boolean pressed = false;
ArrayList<Char> c; 

boolean graphicMode = false;
boolean pixelate = false;
void setup() {
  size(800, 600);

  CharWidth = (width-(border*2))/(columnChar-1);
  CharHeight = (height-(border*2))/(rowChar-1);
  PixelWidth = CharWidth/2; 
  PixelHeight = CharHeight/7;
// 3p en ligne : 1petit 1grand 1petit
// diviser la hauteur par 7 ? pour faire 2/3/2 ou par 4 avec 1/2/1

  c = new ArrayList<Char>();

  for (int i = 0; i<rowChar; i++) {
    for (int j = 0; j<columnChar; j++) {
      c.add(new Char(i, j, j+i*columnChar));
    }
  }
}

void draw() {
  background(0, 0, 25);
  for (Char C : c) {
    C.run();
  }
}

void mousePressed() {
  pressed = true;
}

void mouseReleased() {
  pressed = false;
}


void keyPressed() {
  println(int(key));
  if (keyCode == CONTROL) {
    if (graphicMode) {
      if (!pixelate) {
        pixelate = true;
      } else {
        pixelate = false;
        graphicMode = false;
      }
    } else {
      graphicMode = true;
    }
    println("GRAPHIC MODE = "+graphicMode);
    println("pixelate = "+pixelate);
  } else if (keyCode == BACKSPACE) {
    lfSelected(66, false);
  } else if (keyCode == SHIFT) {
    lfSelected(11, false);
  } else if (keyCode == 35) {
    grid = !grid;
  } else if (graphicMode) {
    if (key == '1' || key == '2' || key == '4' || key == '5' || key == '7' || key == '8') {
      println(int(key));
      lfSelected(int(key)-48, true);
    }
  } else if (!graphicMode && key != keyCode) {
    lfSelected(int(key), true);
    
  }
}

void lfSelected(int _keyInt, boolean _entry) {
  for (Char C : c) {
    if (C.select || C.mselect) {
      C.pixelHold(_keyInt, _entry);
    }
  }
}