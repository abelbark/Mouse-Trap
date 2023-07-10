// Maze and Cell implementation based off of videos provided by "The Coding Train"
// https://youtu.be/HyK_Q5rrcr4

// Contributors: Abel Abarca & Lilianna Rosales

import gifAnimation.*;
import java.util.*;

int w = 40;                                                                  // Width of the individual cell
int cols, rows;                                                              // Used to keep track of the number of columns and rows in the grid
boolean isPlayerMoving = false;                                              // flag for starting path from mouse to cheese for hint
boolean initializeMaze = false;

ArrayList<Cell> grid = new ArrayList<>();
ArrayList<Cell> path = new ArrayList<>();
ArrayList<Cell> openSet = new ArrayList<>();
ArrayList<Cell> closedSet = new ArrayList<>();
ArrayList<Cell> cellStack = new ArrayList<Cell>();

Cell currCell;
Cell start;
Cell end;

Mouse player;                                                                // Player
Cheese cheese;                                                               // Cheese
Buttons hint;                                                                // Hint Button
Buttons newGame;                                                             // New Game Button
winScreen win_screen;                                                        // Win screen
Gif winner;

void setup() {
  size(600, 600);
  cols = (int)width/w;                                                       // total number of columns
  rows = (int)height/w;                                                      // total number of rows
  
  player = new Mouse(0, 0, loadImage("jerry.png"));                          // Creates player
  cheese = new Cheese(8, 6, loadImage("Queso.png"));                         // Creates the cheese
  
  winner = new Gif(this, "win.gif");                                         
  win_screen = new winScreen(width/2, height/2, winner);                     // Creates the win screen
  
  hint = new Buttons(2, rows - 2, 2, color(120, 200, 0), "Hint");            //creates the hint button
  newGame = new Buttons(10, rows - 2, 3, color(235, 190, 0), "New Game");    //creates the New Game button

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);                                            // make all of the cell objects
      grid.add(cell);                                                        // put them into the grid array
    }
  }
  currCell = grid.get(0);                                                    // Set cursor cell to be the top left corner of grid
  generatePath();                                                            // generate path from mouse to cheese
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
    grid.get(i).f = 0;                                                       // reset f value for each cell
    grid.get(i).g = 0;                                                       // reset g value for each cell
    grid.get(i).h = 0;                                                       // reset h value for each cell
    grid.get(i).previous = null;                                             // reset previous cell for each cell
    
  }
}

void resetMaze() {
  grid.clear();
  openSet.clear();
  closedSet.clear();
  cellStack.clear();

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }

  currCell = grid.get(0);
  generatePath();

  player.userMouseX = 0;
  player.userMouseY = 0;

  path.clear();

  genMaze();
  generatePath();
  initializeMaze = false;

  generatePath();                                                           // get a path after resetting the maze
  resetPath();                                                              // reset the path from mouse to cheese
}


void draw() {
  background(2000);
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show(); //display the whole grid
  }

  generatePath();
  // will change colors except the last three rows of the grid for the closed set
  if (hint.buttonPressed(mouseX, mouseY)) {
    for (Cell cell : closedSet) {
      if (cell.cellY < rows - 3) {
        cell.showClosedSet();
      }
    }
  }

  // will change colors except the last three rows of the grid for the open set
  if (hint.buttonPressed(mouseX, mouseY)) {
    for (Cell cell : openSet) {
      if (cell.cellY < rows - 3) {
        cell.showOpenSet();
      }
    }
  }

  // will change colors except the last three rows of the grid for the path from mouse to cheese
  if (hint.buttonPressed(mouseX, mouseY)) {
    for (Cell cell : path) {
      if (cell.cellY < rows - 3) {
        cell.showPath();
      }
    }
  }

  genMaze();

  player.show();                                                            // show the player
  cheese.show();                                                            // show the cheese
  hint.show();                                                              // show the Hint button
  newGame.show();                                                           // show the New Game button
  
  boolean won = win_screen.playerWins(player, cheese);                      // will check if the player wins

  if (won) {                                                                // display the win screen if player won
    win_screen.display();
  }
}

void genMaze() {
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

    if (cellStack.size() == 0 && !initializeMaze) {
      for (int cellIndx = 0; cellIndx <  grid.size(); cellIndx++) {
        Cell c = grid.get(cellIndx);
        c.removeNeighbor();
      }
      initializeMaze = true;
    }
  } 
}

int index(int indexX, int indexY) {
  if ((indexX < 0) || (indexY < 0) || (indexX > (cols - 1)) || (indexY > (rows - 1))) {
    return 0;
  }
  return (indexX + indexY * cols);
}

// changes grid into a maze by removing some of the individual cell walls in the grid
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
    isPlayerMoving = false;
    resetMaze();
    newGame.onClick();
  }
  if (hint.buttonPressed(mouseX, mouseY)) {
    hint.onClick();
  }
}

// responsible for the players movement and prevents the user from phasing through walls
void keyPressed() {
  if (key == CODED) {
    int nextI = player.userMouseX;
    int nextJ = player.userMouseY;
    Cell nextCell = null;

    if (keyCode == UP && player.userMouseY > 0) {
      nextCell = grid.get(player.userMouseX + (player.userMouseY - 1) * cols);
      if (!nextCell.cellWalls[2]) {
        nextJ--;
      }
    } else if (keyCode == DOWN && player.userMouseY < rows - 1) {
      nextCell = grid.get(player.userMouseX + (player.userMouseY + 1) * cols);
      if (!nextCell.cellWalls[0]) {
        nextJ++;
      }
    } else if (keyCode == LEFT && player.userMouseX > 0) {
      nextCell = grid.get((player.userMouseX - 1) + player.userMouseY * cols);
      if (!nextCell.cellWalls[1]) {
        nextI--;
      }
    } else if (keyCode == RIGHT && player.userMouseX < cols - 1) {
      nextCell = grid.get((player.userMouseX + 1) + player.userMouseY * cols);
      if (!nextCell.cellWalls[3]) {
        nextI++;
      }
    }
    
    if (nextCell != null) {
      player.userMouseX = nextI;
      player.userMouseY = nextJ;
      isPlayerMoving = true;
      resetPath();
    }
  }
}
