
class Buttons {

  int buttonX, buttonY;
  int w = 40; //width of a single cell
  int width; // #number of cells that I want thw width to be
  color buttonColor;
  String label;
  boolean isClicked = false;

  Buttons(int X, int Y, int width, color buttonColor, String label){
    this.buttonX = X;
    this.buttonY = Y;
    this.width = width;
    this.buttonColor = buttonColor;
    this.label = label;

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
      player.userMouseX = 0;
      player.userMouseY = 0;
      cheese.randomPos(player);
      resetPath();
    }
  }

  void show(){
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
