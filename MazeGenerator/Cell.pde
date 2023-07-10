// Contributors: Abel Abarca & Lilianna Rosales

class Cell {
  int cellX, cellY;                                                          // cellX is column number, cellY is row number
  int tempX, tempY;
  int cellPath;
  int f, g, h;                                                               // F(n) = g(n) + h(n)
  
  boolean[] cellWalls;
  boolean cellVisited = false;
  
  ArrayList<Cell> neighbors;
  Cell previous;
  
  Cell(int x, int y) {
    this.cellX = x;
    this.cellY = y;
    this.cellWalls = new boolean[]{true, true, true, true};
    this.f = 0;
    this.g = 0;
    this.h = 0;
    this.neighbors = new ArrayList<>();
    this.previous = null;
  }

  Cell checkNeighbors() {
    ArrayList<Cell> cellNeighbors = new ArrayList<Cell>();

    Cell cellTop = grid.get(index(cellX, (cellY - 1)));
    Cell cellRight = grid.get(index((cellX + 1), cellY));
    Cell cellBottom = grid.get(index(cellX, (cellY + 1)));
    Cell cellLeft = grid.get(index((cellX - 1), cellY));

    if ((cellTop != null) && (!cellTop.cellVisited) && (cellTop.cellY < rows - 3)) {
      cellNeighbors.add(cellTop);
    }
    if ((cellRight != null) && (!cellRight.cellVisited) && (cellRight.cellY < rows - 3)) {
      cellNeighbors.add(cellRight);
    }
    if ((cellBottom != null) && (!cellBottom.cellVisited) && (cellBottom.cellY < rows - 3)) {
      cellNeighbors.add(cellBottom);
    }
    if ((cellLeft != null) && (!cellLeft.cellVisited) && (cellLeft.cellY < rows - 3)) {
      cellNeighbors.add(cellLeft);
    }
    if (cellNeighbors.size() > 0) {
      int randNeighb = floor(random(0, cellNeighbors.size()));
      return cellNeighbors.get(randNeighb);
    } else {
      return null;
    }
  }

  void highlight() {
    tempX = this.cellX * w;
    tempY = this.cellY * w;
    noStroke();
    fill(0, 225, 0, 100);
    rect(tempX, tempX, w, w);
  }


  // helps displays each square
  void show() {
    tempX = this.cellX * w;
    tempY = this.cellY * w;
    
    if (cellY >= rows - 3) {                                          // botton three rows are for buttons
      fill(0);
      noStroke();
      rect(tempX, tempY, w, w);
    } else {                                                          // everything else --> walls are built
      stroke(255);
      if (this.cellWalls[0]) {
        line(tempX, tempY, tempX + w, tempY);
      }
      if (this.cellWalls[1]) {
        line(tempX + w, tempY, tempX + w, tempY + w);
      }
      if (this.cellWalls[2]) {
        line(tempX + w, tempY + w, tempX, tempY + w);
      }
      if (this.cellWalls[3]) {
        line(tempX, tempY + w, tempX, tempY);
      }
    }
  }

  void addNeighbors() {
    int i = this.cellX;
    int j = this.cellY;
    if (i < cols - 1) {
      this.neighbors.add(grid.get(i + 1 + j * cols));
    }
    if (i > 0) {
      this.neighbors.add(grid.get(i - 1 + j * cols));
    }
    if (j < rows - 1) {
      this.neighbors.add(grid.get(i + (j + 1) * cols));
    }
    if (j > 0) {
      this.neighbors.add(grid.get(i + (j - 1) * cols));
    }
  }

  void removeNeighbor() {
    int numNeighbors = this.neighbors.size();

    Cell[] neighborsToDelete = new Cell[numNeighbors];
    int deleteCount = 0;

    for (int i = 0; i < numNeighbors; i++) {
      Cell remove = this.neighbors.get(i);
      boolean removeLeft = remove.cellX < this.cellX && this.cellWalls[3];
      boolean removeRight = remove.cellX > this.cellX && this.cellWalls[1];
      boolean removeTop = remove.cellY < this.cellY && this.cellWalls[0];
      boolean removeBottom = remove.cellY > this.cellY && this.cellWalls[2];

      if (removeLeft || removeRight || removeTop || removeBottom) {
        neighborsToDelete[deleteCount] = remove;
        deleteCount++;
      }
    }

    for (int i = 0; i < deleteCount; i++) {
      this.neighbors.remove(neighborsToDelete[i]);
    }
  }

  void printNeighbors() {
    StringBuilder str = new StringBuilder("(" + this.cellX + ", " + this.cellY + ") Neighbors: ");
    for (int i = 0; i < this.neighbors.size(); i++) {
      Cell temp = this.neighbors.get(i);
      str.append("(" + temp.cellX + ", " + temp.cellY + ")");
    }
    System.out.println(str);
  }

  void showPath() {
    int x = this.cellX * w;
    int y = this.cellY * w;
    if (cellY < rows - 3) {
      fill(255, 166, 0);
      noStroke();
      rect(x+10, y+10, w/2, w/2);
    }
  }

  void setColor(int c) {
    if (cellY < rows - 3) {
      cellPath = c;
    }
  }

  //pink
  void showClosedSet() {
    int x = this.cellX * w;
    int y = this.cellY * w;
    if (cellY < rows - 3) {
      fill(255, 182, 193);
      noStroke();
      rect(x+10, y+10, w/2, w/2);
    }
  }

  //green
  void showOpenSet() {
    int x = this.cellX * w;
    int y = this.cellY * w;

    if (cellY < rows - 3) {
      fill(204, 255, 204);
      noStroke();
      rect(x+10, y+10, w/2, w/2);
    }
  }
}
