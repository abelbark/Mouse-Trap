// generates path from players position
// to the cheese
void generatePath() {
  resetPath();
  openSet.add(start);

  if (!initializeMaze) {
    for (int i = 0; i < grid.size(); i++) {
      grid.get(i).addNeighbors();                                  // add neighbors
    }
  }
  
  while (openSet.size() > 0) {                                    // loop through everything
    int lowestIndex = 0;
    for (int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).f < openSet.get(lowestIndex).f) {        // find the one thats the lowest index
        lowestIndex = i;
      }
    }
    Cell current = openSet.get(lowestIndex);

    if (current.equals(end)) {
      // find the path, start with empty list and add to the end of list and backtrack
      path = new ArrayList<>();                                 
      Cell temp = current;
      path.add(temp);
      while (temp.previous != null) {
        path.add(temp.previous);
        temp = temp.previous;
      }

      System.out.println("Done!");
      break;
    } else {
      removeFromArray(openSet, current);
      closedSet.add(current);
      ArrayList<Cell> neighbors = current.neighbors;
      
      for (Cell neighbor : neighbors) {
        if (!closedSet.contains(neighbor)) {
          int tempG = current.g + 1;
          if (openSet.contains(neighbor)) {
            if (tempG < neighbor.g) {
              neighbor.g = tempG;
            }
          } else {
            neighbor.g = tempG;
            openSet.add(neighbor);
          }
          
          // adding heuristics
          neighbor.h = heuristic(neighbor, end);
          neighbor.f = neighbor.g + neighbor.h;
          neighbor.previous = current;
        }
      }
    }
  }
  System.out.println("No Solution");
}

// loops through the array to see if it has a
// specific element and delete it from the array
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
