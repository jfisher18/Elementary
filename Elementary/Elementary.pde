ArrayList<Element> elements;
String[] symbols;
String[] names;
boolean centering;
int counter = 0;
int time;
Element currentElement;
void setup() {
  symbols = loadStrings("symbols.txt");
  names = loadStrings("names.txt");
  elements = new ArrayList<Element>();
  for (int i = 1; i<=118; i++) {
    elements.add(new Element(i, symbols[i-1], names[i-1]));
  }
  size(900, 516);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  noStroke();
  for (Element element : elements) {
    element.fadeIn();
  }
}

void draw() {
  background(44, 62, 80);
  for (Element element : elements) {
    element.drawElement();
  }
  if (centering) {
    counter++;
    if (counter>=16){
      currentElement.center();
      centering = false;
    }
  }
}

void mousePressed() {
  for (Element element : elements) {
    if (element.isOver()) {
      currentElement = element;
      time = millis();
      for (Element element2 : elements) {
        if (element2 != currentElement) {
          element2.fadeOut();
          centering = true;
          counter = 0;
        }
      }
    }
  }
} 