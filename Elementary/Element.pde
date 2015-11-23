class Element {
  float diameter = 35;
  int number;
  float mass;
  float xPos, yPos;
  float currentX, currentY;
  String symbol, name, group;
  color fillColor;
  float alpha = 0;
  boolean isFadingOut;
  boolean isFadingIn;
  boolean textFadingOut;
  boolean textFadingIn;
  boolean isCentered;
  boolean isCentering, isDecentering;
  float centerStage = 0;
  float textAlpha = 0;

  Element(int inNumber, String inSymbol, String inName, String inMass) {
    number = inNumber;
    mass = float(inMass);
    if (number==1) {
      yPos = 42;
      xPos = 42;
    }
    if (number>=2&&number<=4) {
      yPos = 42+48*((number+15)/18);
      xPos = 42+48*((number+15)%18);
    }
    if (number>=5&&number<=12) {
      yPos = 90+48*((number+7)/18);
      xPos = 42+48*((number+7)%18);
    }
    if (number>=13&&number<=56) {
      yPos = 138+48*((number-1)/18);
      xPos = 42+48*((number-1)%18);
    }
    if (number>=57&&number<=71) {
      yPos = 426;
      xPos = 138+48*(number-57);
    }
    if (number>=72&&number<=88) {
      yPos = 282+48*((number-69)/18);
      xPos = 42+48*((number+3)%18);
    }
    if (number>=89&&number<=103) {
      yPos = 474;
      xPos = 138+48*(number-89);
    }
    if (number>=104) {
      yPos = 330;
      xPos = 186+48*(number-104);
    }
    symbol = inSymbol;
    name = inName;
    group = "Default";
    if (yPos<426) {
      if (xPos == 42) {
        if (yPos != 42) {
          group = "Alkali Metals";
        } else {
          group = "Nonmetals";
        }
      }
      if (xPos == 90) {
        group = "Alkaline Earth Metals";
      }
      if (xPos>=138&& xPos<=570) {
        group = "Transition Metals";
      }
      if (xPos==810) {
        group = "Halogens";
      }
      if (xPos==858) {
        group = "Noble Gases";
      }
      if (number==6||number==7||number==8||number==15||number==16||number==34) {
        group = "Nonmetals";
      }
      if (number==5||number==14||number==32||number==33||number==51||number==52||number==84) {
        group = "Semimetals";
      }
      if (group == "Default") {
        group = "Basic Metals";
      }
      if (xPos==858) {
        group = "Noble Gases";
      }
      if (xPos==858) {
        group = "Noble Gases";
      }
    } else {
      if (yPos == 426) {
        group = "Lanthanides";
      }
      if (yPos == 474) {
        group = "Actinides";
      }
    }
    if (group == "Nonmetals") {
      fillColor = #2980b9;
    } else if (group == "Alkali Metals") {
      fillColor = #c0392b;
    } else if (group == "Alkaline Earth Metals") {
      fillColor = #e67e22;
    } else if (group == "Transition Metals") {
      fillColor = #f1c40f;
    } else if (group == "Lanthanides") {
      fillColor = #8e44ad;
    } else if (group == "Actinides") {
      fillColor = #16a085;
    } else if (group == "Halogens") {
      fillColor = #2ecc71;
    } else if (group == "Noble Gases") {
      fillColor = #DB0A5B;
    } else if (group == "Semimetals") {
      fillColor = #E08283;
    } else if (group == "Basic Metals") {
      fillColor = #336E7B;
    } else {
      fillColor = #ffffff;
    }
    currentX = xPos;
    currentY = yPos;
  }
  void drawElement() {
    fill(fillColor, alpha);
    ellipse(currentX, currentY, diameter, diameter);
    fill(255, alpha);
    if (symbol.length()==3) {
      textSize(int(12*(diameter/35.0)));
    } else {
      textSize(int(16*(diameter/35.0)));
    }
    textAlign(CENTER, CENTER);
    text(symbol, currentX, currentY-2*(diameter/35.0));
    if (isFadingIn) {
      alpha+=17;
      if (alpha>=255) {
        alpha = 255;
        isFadingIn = false;
        fading = false;
      }
    }
    if (isFadingOut) {
      alpha-=17;
      if (alpha<=0) {
        alpha = 0;
        isFadingOut = false;
        fading = false;
      }
    }
    if (textFadingIn) {
      textAlpha+=17;
      if (textAlpha>=255) {
        textAlpha = 255;
        textFadingIn = false;
        fading = false;
      }
    }
    if (textFadingOut) {
      textAlpha-=17;
      if (textAlpha<=0) {
        textAlpha = 0;
        textFadingOut = false;
        fading = false;
      }
    }
    if (isCentering) {
      centerStage+=.1;
      diameter = lerp(35.0, 400.0, centerStage);
      currentX = lerp(xPos, 225.0, centerStage);
      currentY = lerp(yPos, 258.0, centerStage);
    }
    if (centerStage>=1&&isCentering) {
      centerStage = 1;
      isCentering = false;
      centered = true;
      isCentered = true;
      this.fadeInText();
    }
    if (isDecentering) {
      if (!fading) {
        centerStage+=.1;
        diameter = lerp(400, 35.0, centerStage);
        currentX = lerp(225.0, xPos, centerStage);
        currentY = lerp(258.0, yPos, centerStage);
      }
    }
    if (centerStage>=1&&isDecentering) {
      centerStage = 1;
      isDecentering = false;
      decentering = false;
      centered = false;
      isCentered = false;
      for (Element element : elements) {
        if (element != this) {
          element.fadeIn();
        }
      }
    }
    if (isCentered) {
      textAlign(LEFT, LEFT);
      textSize(64);
      fill(255, textAlpha);
      text(name, 450, 130);
      fill(200, textAlpha);
      textSize(30);
      text("Atomic Number : " + number, 450, 175);
      if (mass == 0) {
        text("Atomic Mass : N/A", 450, 215);
      } else {
        text("Atomic Mass : " + mass, 450, 215);
      }
      text("Group : " + group, 450, 255);
    }
  }

  void fadeOut() {
    fading = true;
    isFadingOut = true;
  }
  void fadeIn() {
    fading = true;
    isFadingIn = true;
  }
  void center() {
    isCentering =true;
    centerStage = 0;
  }
  void decenter() {
    this.fadeOutText();
    isDecentering =true;
    decentering = true;
    centerStage = 0;
  }
  void fadeInText() {
    textFadingIn = true;
    fading = true;
  }
  void fadeOutText() {
    textFadingOut = true;
    fading = true;
  }
  boolean isOver() {
    return(dist(mouseX, mouseY, xPos, yPos)<=17.5);
  }
}