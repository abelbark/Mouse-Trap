// Contributors: Abel Abarca & Lilianna Rosales

class Mouse {

  int userMouseX, userMouseY;
  int w = 40;
  PImage jerry;

  Mouse(int inputMX, int inputMY, PImage inputJerry) {
    this.userMouseX = inputMX;
    this.userMouseY = inputMY;
    this.jerry = inputJerry;
  }

  void show() {
    int x = this.userMouseX * w;
    int y = this.userMouseY * w;

    image(jerry, x, y, w, w);
  }
}
