// Contributors: Abel Abarca & Lilianna Rosales

class Buttons {

  int buttonX, buttonY;
  int w = 40;                                                                  // Width of a single cell
  int width;                                                                   // Number of cells for the width of the graph
  color buttonColor;
  String label;
  boolean isClicked = false;

  Buttons(int inputX, int inputY, int inputwidth, color inputColor, String inputLabel) {
    this.buttonX = inputX;
    this.buttonY = inputY;
    this.width = inputwidth;
    this.buttonColor = inputColor;
    this.label = inputLabel;
  }

  boolean buttonPressed(int inputX, int inputY) {
    int buttonXW = this.buttonX * w;
    int buttonYW = this.buttonY * w;
    int buttonWidth = width * w;
    int buttonHeight = w;

    return inputX >= buttonXW && inputX <= buttonXW + buttonWidth && inputY >= buttonYW && inputY <= buttonYW + buttonHeight;
  }

  void onClick() {
    if (this == hint) {
      resetPath();
      generatePath();
    } else if (this == newGame) {
      cheese.randomPos(player);
    }
  }

  void show() {
    int tempButtonX = this.buttonX * w;
    int tempButtonY = this.buttonY * w;

    stroke(255);
    fill(buttonColor);
    rect(tempButtonX, tempButtonY, width * w, w);

    textAlign(CENTER, CENTER);
    fill(255);
    textSize(20);
    text(label, tempButtonX + (width * w) / 2, tempButtonY + w / 2);
  }
}
