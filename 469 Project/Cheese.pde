
//need to randomize the location of the cheese
//not too close to the player
class Cheese{

  int cheeseX, chesseY;
  int w = 40;
  PImage cheddar;

  Cheese(int x, int y, PImage cheddar){
    this.cheeseX = x;
    this.chesseY = y;
    this.cheddar = cheddar;
  }

  void show(){
    int tempCheeseX = this.cheeseX * w;
    int tempCheeseY = this.chesseY* w;
    image(cheddar, tempCheeseX, tempCheeseY, w, w);

  }

}
