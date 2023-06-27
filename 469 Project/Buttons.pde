
//button functionality coming soon
//must correspond with whats on the tag
class Buttons{

  int buttonX, buttonY;
  int w = 40; //width of a single cell
  int width; // #number of cells that I want thw width to be
  color buttonColor;
  String label;

  Buttons(int X, int Y, int width, color buttonColor, String label){
    this.buttonX = X;
    this.buttonY = Y;
    this.width = width;
    this.buttonColor = buttonColor;
    this.label = label;

  }

  void show(){
    int tempButtonX = this.buttonX * w;
    int tempButtonY = this.buttonY * w;


  // take a deeper look at these
    stroke(255);
    fill(buttonColor);
    rect(tempButtonX, tempButtonY, width * w, w);

  //These too
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(20);
    text(label, tempButtonX + (width * w) / 2, tempButtonY + w / 2);
  }



}
