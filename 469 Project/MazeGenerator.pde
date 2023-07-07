import java.util.*;
// maze and cell implementation based off of videos provided by "The Coding Train"
// https://youtu.be/HyK_Q5rrcr4

int w = 40;                                                                  // Width of the square
int cols, rows;
boolean isPlayerMoving = false;
boolean initializeMaze = false;

ArrayList<Cell> grid = new ArrayList<>();
ArrayList<Cell> path = new ArrayList<>();
ArrayList<Cell> openSet = new ArrayList<>();
ArrayList<Cell> closedSet = new ArrayList<>();
ArrayList<Cell> cellStack = new ArrayList<Cell>();

Cell currCell;
Cell start;
Cell end;

Random rand = new Random();
int cheeseX;                                                                 // Cheese x coordinate
int cheeseY;                                                                 // Cheese y coordinate

Mouse player;                                                                // Player
Cheese cheese;                                                               // Cheese
Buttons hint;                                                                // Hint Button
Buttons newGame;                                                             // New Game Button


void setup() {
  size(600, 600);
  cols = (int)width/w;                                                       // total number of columns
  rows = (int)height/w;                                                      // total number of rows
  
  player = new Mouse(0, 0, loadImage("jerry.png"));                          // Creates player
  cheese = new Cheese(8, 6, loadImage("Queso.png"));                         // Creates the cheese
  
  hint = new Buttons(2, rows - 2, 2, color(120, 200, 0), "Hint");            //creates the hint button
  newGame = new Buttons(10, rows - 2, 3, color(235, 190, 0), "New Game");    //creates the New Game button

  for(int j = 0; j < rows; j++){
    for(int i = 0; i < cols; i++){
      Cell cell = new Cell(i, j);                                            // make all of the cell objects
      grid.add(cell);                                                        // put them into the grid array
    }
  }
  currCell = grid.get(0);
  generatePath();
}

// will reset everything so a new path
// can be generated at a different location
void resetPath() {
  start = grid.get(player.userMouseX + player.userMouseY * cols);
  end = grid.get(cheese.cheeseX + cheese.cheeseY * cols);

  path.clear();
  openSet.clear();
  closedSet.clear();
  
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).f = 0;                                                       //reset f value for each cell
    grid.get(i).g = 0;                                                       //reset g value for each cell
    grid.get(i).h = 0;                                                       //reset h value for each cell
    grid.get(i).previous = null;                                             //reset previous cell for each cell
  }
}

void draw() {
  background(2000);
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show(); //display the whole grid
  }

  //will change colors except the last three rows
  if (hint.buttonPressed(mouseX, mouseY)) {
    for (Cell cell : closedSet) {
      if (cell.cellY < rows - 3) {
        cell.showClosedSet();
      }
    }
  }

  //will change colors except the last three rows
  if (hint.buttonPressed(mouseX, mouseY)) {
    for (Cell cell : openSet) {
      if (cell.cellY < rows - 3) {
        cell.showOpenSet();
      }
    }
  }
  if (hint.buttonPressed(mouseX, mouseY)) {
    for (Cell cell : path) {
      if (cell.cellY < rows - 3) {
        cell.showPath();
      }
    }
  }

  if (!isPlayerMoving) {
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
    
    if(cellStack.size() == 0 && !initializeMaze){
      
      for(int cellIndx = 0; cellIndx <  grid.size(); cellIndx++) {
        Cell c = grid.get(cellIndx);
        c.removeNeighbor();
      }
      initializeMaze = true;
    }
  }

  player.show();                                                            // show the player
  cheese.show();                                                            // show the cheese
  hint.show();                                                              // show the Hint button
  newGame.show();                                                           // show the New Game button
  
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

void mouseClicked() {
  if (newGame.buttonPressed(mouseX, mouseY)) {
    newGame.onClick();
  }
  if (hint.buttonPressed(mouseX, mouseY)) {
    hint.onClick();
  }
}

// responsible for the players movement and prevents the user
// from phasing through walls
void keyPressed() {
  if (key == CODED) {
    int nextMX = player.userMouseX;
    int nextMY = player.userMouseY;
    Cell nextCell = null;

    if (keyCode == UP && player.userMouseY > 0) {
      nextCell = grid.get(player.userMouseX + (player.userMouseY - 1) * cols);
      if (!nextCell.cellWalls[2]) {
        nextMY--;
      }
    } else if (keyCode == DOWN && player.userMouseY < rows - 1) {
      nextCell = grid.get(player.userMouseX + (player.userMouseY + 1) * cols);
      if (!nextCell.cellWalls[0]) {
        nextMY++;
      }
    } else if (keyCode == LEFT && player.userMouseX > 0) {
      nextCell = grid.get((player.userMouseX - 1) + player.userMouseY * cols);
      if (!nextCell.cellWalls[1]) {
        nextMX--;
      }
    } else if (keyCode == RIGHT && player.userMouseX < cols - 1) {
      nextCell = grid.get((player.userMouseX + 1) + player.userMouseY * cols);
      if (!nextCell.cellWalls[3]) {
        nextMX++;
      }
    }
    if (nextCell != null) {
      player.userMouseX = nextMX;
      player.userMouseY = nextMY;
      isPlayerMoving = true;
      resetPath();
    }
  }
}
