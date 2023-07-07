 //<>// //<>// //<>// //<>//
class Mouse {

  int userMouseX, userMouseY;
  int w = 40;
  PImage jerry;


  Mouse(int inputMX, int inputMY, PImage jerry) {
    this.userMouseX = inputMX;
    this.userMouseY = inputMY;
    this.jerry = jerry;
  }

  void show() {
    int x = this.userMouseX * w;
    int y = this.userMouseY * w;
    
    image(jerry, x, y, w, w);
  }
}
