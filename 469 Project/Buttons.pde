
//button functionality coming soon
//must correspond with whats on the tag
class Buttons{
  
  int i, j;
  int w = 40; //width of a single cell
  int width; // #number of cells that I want thw width to be
  color buttonColor;
  String label;
  
  Buttons(int i, int j, int width, color buttonColor, String label){
    this.i = i;
    this.j = j;
    this.width = width;
    this.buttonColor = buttonColor;
    this.label = label;
  
  }
  
  void show(){
    int x = this.i * w;
    int y = this.j * w;
  
  
  // take a deeper look at these
    stroke(255);
    fill(buttonColor);
    rect(x, y, width * w, w);
  
  //These too
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(20);
    text(label, x + (width * w) / 2, y + w / 2);
  }
  
 

}
