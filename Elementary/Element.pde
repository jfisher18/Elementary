class Element {
  float diameter = 35;
  int number;
  float xPos, yPos;
  float currentX, currentY;
  String symbol, name, group;
  color fillColor;
  float alpha = 0;
  boolean isFadingOut;
  boolean isFadingIn;
  boolean isCentering, isDecentering;
  float centerStage = 0;

  Element(int inNumber, String inSymbol, String inName) {
    number = inNumber;
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
          group = "Alkali Metal";
        } else {
          group = "Nonmetal";
        }
      }
      if (xPos == 90) {
        group = "Alkaline Earth Metal";
      }
      if (xPos>=138&& xPos<=570) {
        group = "Transition Metal";
      }
      if (xPos==810) {
        group = "Halogen";
      }
      if (xPos==858) {
        group = "Noble Gas";
      }
      if (number==6||number==7||number==8||number==15||number==16||number==34) {
        group = "Nonmetal";
      }
      if (number==5||number==14||number==32||number==33||number==51||number==52||number==84) {
        group = "Semimetal";
      }
      if (group == "Default") {
        group = "Basic Metal";
      }
      if (xPos==858) {
        group = "Noble Gas";
      }
      if (xPos==858) {
        group = "Noble Gas";
      }
    } else {
      if (yPos == 426) {
        group = "Lanthanide";
      }
      if (yPos == 474) {
        group = "Actinide";
      }
    }
    if (group == "Nonmetal") {
      fillColor = #2980b9;
    } else if (group == "Alkali Metal") {
      fillColor = #c0392b;
    } else if (group == "Alkaline Earth Metal") {
      fillColor = #e67e22;
    } else if (group == "Transition Metal") {
      fillColor = #f1c40f;
    } else if (group == "Lanthanide") {
      fillColor = #8e44ad;
    } else if (group == "Actinide") {
      fillColor = #16a085;
    } else if (group == "Halogen") {
      fillColor = #2ecc71;
    } else if (group == "Noble Gas") {
      fillColor = #DB0A5B;
    } else if (group == "Semimetal") {
      fillColor = #E08283;
    } else if (group == "Basic Metal") {
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
    if (isCentering) {
      centerStage+=.05;
      diameter = lerp(35.0, 400.0, centerStage);
      currentX = lerp(xPos, 225.0, centerStage);
      currentY = lerp(yPos, 258.0, centerStage);
    }
    if (centerStage>=1&&isCentering) {
      centerStage = 1;
      isCentering = false;
      centered = true;
    }
    if (isDecentering) {
      centerStage+=.05;
      diameter = lerp(400, 35.0, centerStage);
      currentX = lerp(225.0, xPos, centerStage);
      currentY = lerp(258.0, yPos, centerStage);
    }
    if (centerStage>=1&&isDecentering) {
      centerStage = 1;
      isDecentering = false;
      centered = false;
      for (Element element : elements) {
        if (element != this) {
          element.fadeIn();
        }
      }
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
    isDecentering =true;
    centerStage = 0;
  }
  boolean isOver() {
    return(dist(mouseX, mouseY, xPos, yPos)<=17.5);
  }
}