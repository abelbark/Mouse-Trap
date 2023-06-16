
//need to randomize the location of the cheese
//not too close to the player
class Cheese{

  int i, j;
  int w = 40;
  PImage cheddar;
  
  Cheese(int i, int j, PImage cheddar){
    this.i = i;
    this.j = j;
    this.cheddar = cheddar;
  }
  
  void show(){
    int x = this.i * w;
    int y = this.j * w;
    image(cheddar, x, y, w, w);
  
  }

}
