class Cell{
  int cellX, cellY;
  int tempX, tempY;
  boolean[] cellWalls;
  boolean cellVisited = false;

  Cell(int x,int y){
    this.cellX = x;
    this.cellY = y;
    this.cellWalls = new boolean[]{true,true,true,true};
  }
  
  Cell checkNeighbors() {
    ArrayList<Cell> cellNeighbors = new ArrayList<Cell>();

    Cell cellTop = grid.get(index(cellX, (cellY - 1)));
    Cell cellRight = grid.get(index((cellX + 1), cellY));
    Cell cellBottom = grid.get(index(cellX, (cellY + 1)));
    Cell cellLeft = grid.get(index((cellX - 1), cellY));

    if ((cellTop != null) && (!cellTop.cellVisited)) {
      cellNeighbors.add(cellTop);
    } 
    if ((cellRight != null) && (!cellRight.cellVisited)) {
      cellNeighbors.add(cellRight);
    }
    if ((cellBottom != null) && (!cellBottom.cellVisited)) {
      cellNeighbors.add(cellBottom);
    } 
    if ((cellLeft != null) && (!cellLeft.cellVisited)) {
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

  //helps displays each square
    void show(){
      tempX = this.cellX * w;
      tempY = this.cellY * w;

      //botton three rows are for buttons
      //everything else --> walls are built
      if(cellY >= rows - 3){
        fill(0, 0, 0, 0);
        noStroke();
        rect(tempX, tempY, w, w);
      } else {
        stroke(255);
        if (this.cellWalls[0]){
          line(tempX, tempY, tempX + w, tempY);
        } if (this.cellWalls[1]){
            line(tempX + w, tempY, tempX + w, tempY + w);
        } if (this.cellWalls[2]){
            line(tempX + w, tempY + w, tempX + w, tempY + w);
        } if (this.cellWalls[3]){
            line(tempX, tempY + w, tempX, tempY);
        } if (this.cellVisited) {
            noStroke();
            fill(0, 0, 0, 0);
            rect(tempX, tempY, w, w);
        }
      }
    }

}
