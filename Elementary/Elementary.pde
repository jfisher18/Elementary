ArrayList<Element> elements;
String[] symbols;
String[] names;
String[] masses;
boolean centering, decentering;
int counter = 0;
boolean centered;
Element currentElement;
boolean fading;
void setup() {
  symbols = loadStrings("symbols.txt");
  names = loadStrings("names.txt");
  masses = loadStrings("masses.txt");
  elements = new ArrayList<Element>();
  for (int i = 1; i<=118; i++) {
    elements.add(new Element(i, symbols[i-1], names[i-1],masses[i-1]));
  }
  size(900, 516);
  ellipseMode(CENTER);
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
    if (counter>=16) {
      currentElement.center();
      centering = false;
    }
  }
}

void mousePressed() {
  if (!centered&&!fading&&!centering) {
    for (Element element : elements) {
      if (element.isOver()) {
        currentElement = element;
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
}
void keyPressed() {
  if (key == ENTER && centered&&!decentering&&!fading) {
    currentElement.decenter();
  }
}