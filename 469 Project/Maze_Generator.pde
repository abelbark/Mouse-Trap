
int cols, rows;
//width of the square
int w = 40;
ArrayList<Cell> grid = new ArrayList<>();

//Player
Mouse player;
//Cheese
Cheese cheese;
//Buttons
Buttons hint;
Buttons newGame;

void setup() {
  size(600, 600);
  cols = (int)width/w; // total number of columns
  rows = (int)height/w; // rows
  
  //creates player
  player = new Mouse(0, 0, loadImage("jerry.png"));
  
  //Creates the cheese
  cheese = new Cheese(8, 6, loadImage("Queso.png"));
  
  //creates the buttons
  hint = new Buttons(2, rows - 2, 2, color(120, 200, 0),  "Hint");
  newGame = new Buttons(10, rows - 2, 3, color(235, 190, 0), "New Game");
  
  //make all of these cell objects
  //put them into the array
  for(int j = 0; j < rows; j++){
    for(int i = 0; i < cols; i++){
      Cell cell = new Cell(i, j); 
      grid.add(cell); 
    }
  }
  
}

void draw() {
  background(2000);
  for(int i = 0; i < grid.size(); i++){
    grid.get(i).show(); //display the whole grid
  }
  //show the player
  player.show();
  
  //show cheese
  cheese.show();
  
  //show the buttons
  hint.show();
  newGame.show();
  
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      player.j--;
    } else if(keyCode == DOWN){
      player.j++;
    } else if(keyCode == LEFT){
      player.i--;
    } else if(keyCode == RIGHT){
      player.i++;
    }
  }


}

//trying to create a cell object
// i is column number
// j is row number
class Cell{
  int i, j;
  boolean[] walls;
  
  Cell(int i,int j){
    this.i = i;
    this.j = j;
    this.walls = new boolean[]{true,true,true,true};
  }
  
  //helps displays each square
    void show(){
      int x = this.i * w;
      int y = this.j * w;
      
      //botton three rows are for buttons
      //everything else --> walls are built
      if(j >= rows - 3){
        fill(0, 0, 0);
        noStroke();
        rect(x, y, w, w);
      } else {
        stroke(255);
        if(walls[0]){
          line(x,y,x+w,y);
        }if(walls[1]){
            line(x+w,y,x+w,y+w);
        }if(walls[2]){
            line(x+w,y+w,x+w,y+w);
        }if(walls[3]){
            line(x, y+w,x,y);
        }
      
          
         
          
          //noFill();
          //rect(x,y,w,w);
      }
      
    }
    
}
