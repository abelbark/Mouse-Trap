
class Mouse{

  int userMouseX, userMouseY;
  int w = 40;
  PImage jerry;

  Mouse(int x, int y, PImage jerry){
    this.userMouseX = x;
    this.userMouseY = y;
    this.jerry = jerry;
  }

  void show(){
    int tempMouseX = this.userMouseX * w;
    int tempMouseY = this.userMouseY * w;
    image(jerry, tempMouseX, tempMouseY, w, w);
  }


}
