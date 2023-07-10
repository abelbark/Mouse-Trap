// Contributors: Abel Abarca & Lilianna Rosales

class Cheese {

  int cheeseX, cheeseY;
  int w = 40;
  PImage cheddar;

  Cheese(int inputX, int inputY, PImage inputCheddar) {
    this.cheeseX = inputX;
    this.cheeseY = inputY;
    this.cheddar = inputCheddar;
  }

  void randomPos(Mouse player) {
    int cols = (width / w);
    int rows = (height / w) - 3;
    int x = (int) random(3, cols);
    int y = (int) random(rows);

    cheeseX = x;
    cheeseY = y;
  }

  void show() {
    int x = this.cheeseX * w;
    int y = this.cheeseY * w;
    image(cheddar, x, y, w, w);
  }
}
