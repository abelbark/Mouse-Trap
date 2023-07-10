// Contributors: Abel Abarca & Lilianna Rosales

// generates path from players position to the cheese
void generatePath() {
  //updating path
  resetPath();
  openSet.add(start);                              //add the players pos to the open set

  if (!initializeMaze) {
    for (int i = 0; i < grid.size(); i++) {
      grid.get(i).addNeighbors();                                      // add neighbors to current cell
    }
  }

  //find the one thats the lowest index
  while (openSet.size() > 0) {                                         // loop through everything until open set is empty
    int lowestIndex = 0;                                              // keep track of the index of the cell with lowest f value
    for (int i = 0; i < openSet.size(); i++) {                        
      if (openSet.get(i).f < openSet.get(lowestIndex).f) {             // find the one thats the lowest index 
        lowestIndex = i;
      }
    }

    Cell current = openSet.get(lowestIndex);                         //assign the lowest to current

    if (current.equals(end)) {                            // checks if the current cell is the end pos                                                
      path = new ArrayList<>();                          //will store the path
      Cell temp = current;
      path.add(temp);
      while (temp.previous != null) {                  //will backtrack to the start pos, following the previous ref
        path.add(temp.previous);
        temp = temp.previous;
      }

      System.out.println("Done!");
      break;
    } else {
      removeFromArray(openSet, current);                      
      closedSet.add(current);

      ArrayList<Cell> neighbors = current.neighbors;            //assigns the current cells neighbors to neighbors
      for (Cell neighbor : neighbors) {
        if (!closedSet.contains(neighbor)) {                   //iterate the current cell neighbors to see if theyre not in closed set
          int tempG = current.g + 1;                          //calculate the g value 
          if (openSet.contains(neighbor)) {                  
            if (tempG < neighbor.g) {                        //find the lowest g value and update the neighbor.g
              neighbor.g = tempG;
            }
          } else {
            neighbor.g = tempG;
            openSet.add(neighbor);
          }
          // adding heuristics
          neighbor.h = heuristic(neighbor, end);                 //calculates heuristic value from the neighbor to cell
          neighbor.f = neighbor.g + neighbor.h;                  //calculates f value 
          neighbor.previous = current;                          //path between start and neighbor cell
        }
      }
    }
  }
  System.out.println("No Solution");                        //no path is found
}

// loops through the array to see if it has a specific element and delete it from the array
void removeFromArray(ArrayList<Cell> arr, Cell elt) {
  for (int i = arr.size() - 1; i >= 0; i--) {
    if (arr.get(i) == elt) {
      arr.remove(i);
    }
  }
}

// calculates the distance between two cells
int heuristic(Cell a, Cell b) {
  int distance = abs(a.cellX - b.cellX) + abs(a.cellY - b.cellY);
  return distance;
}
