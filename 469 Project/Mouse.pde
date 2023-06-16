
class Mouse{
  
  int i, j;
  int w = 40;
  PImage jerry;
  
  Mouse(int i, int j, PImage jerry){
    this.i = i;
    this.j = j;
    this.jerry = jerry;
  }
  
  void show(){
    int x = this.i * w;
    int y = this.j * w;
    image(jerry, x, y, w, w);
  }
  
  
}
