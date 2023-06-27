import java.util.*;

int cols, rows;
int w = 40;                                                                  // Width of the square
ArrayList<Cell> grid = new ArrayList<>();

Random rand = new Random();
int cheeseX;                                                                 // Cheese x coordinate
int cheeseY;                                                                 // Cheese y coordinate

Mouse player;                                                                // Player
Cheese cheese;                                                               // Cheese
Buttons hint;                                                                // Hint Button
Buttons newGame;                                                             // New Game Button

Cell currCell;
ArrayList<Cell> cellStack = new ArrayList<Cell>();

void cheeseRelocate() {
  cheeseX = rand.nextInt(cols);
  cheeseY = rand.nextInt(rows - 3);
}

void setup() {
  size(600, 600);
  cols = (int)width/w;                                                       // total number of columns
  rows = (int)height/w;                                                      // total number of rows
  cheeseRelocate();                                                          // random location for cheese
  
  player = new Mouse(0, 0, loadImage("jerry.png"));                          // Creates player
  cheese = new Cheese(cheeseX, cheeseY, loadImage("Queso.png"));             // Creates the cheese
  
  hint = new Buttons(2, rows - 2, 2, color(120, 200, 0), "Hint");           //creates the hint button
  newGame = new Buttons(10, rows - 2, 3, color(235, 190, 0), "New Game");    //creates the New Game button

  for(int j = 0; j < rows; j++){
    for(int i = 0; i < cols; i++){
      Cell cell = new Cell(i, j);                                            // make all of the cell objects
      grid.add(cell);                                                        // put them into the grid array
    }
  }
  currCell = grid.get(0);
}

void draw() {
  background(2000);
  for(int i = 0; i < grid.size(); i++){
    grid.get(i).show();                                                     // display the whole grid
  }
  
  player.show();                                                            // show the player
  cheese.show();                                                            // show the cheese
  hint.show();                                                              // show the Hint button
  newGame.show();                                                           // show the New Game button
  
  currCell.cellVisited = true;
  currCell.highlight();

  Cell nextCell = currCell.checkNeighbors();
  
  if (nextCell != null) {
    nextCell.cellVisited = true;
    cellStack.add(currCell);
    removeCellWalls(currCell, nextCell);
    currCell = nextCell;
  } else if (cellStack.size() > 0) {
    currCell = cellStack.remove(cellStack.size() - 1);
  }

}

int index(int indexX, int indexY) {
  if ((indexX < 0) || (indexY < 0) || (indexX > (cols - 1)) || (indexY > (rows - 1))) {
    return 0;
  }
  return (indexX + indexY * cols);
}

void removeCellWalls(Cell cellOne, Cell cellTwo) {
  int tempVarX = cellOne.cellX - cellTwo.cellX;
  if (tempVarX == 1) {
    cellOne.cellWalls[3] = false;
    cellTwo.cellWalls[1] = false;
  } else if (tempVarX == -1) {
    cellOne.cellWalls[1] = false;
    cellTwo.cellWalls[3] = false;
  }
  
  int tempVarY = cellOne.cellY - cellTwo.cellY;
  if (tempVarY == 1) {
    cellOne.cellWalls[0] = false;
    cellTwo.cellWalls[2] = false;
  } else if (tempVarY == -1) {
    cellOne.cellWalls[2] = false;
    cellTwo.cellWalls[0] = false;
  }
}

//void newGamePressed() {
  
//}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      player.userMouseY--;
    } else if(keyCode == DOWN){
      player.userMouseY++;
    } else if(keyCode == LEFT){
      player.userMouseX--;
    } else if(keyCode == RIGHT){
      player.userMouseX++;
    }
  }
}
