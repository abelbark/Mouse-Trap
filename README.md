# Mouse-Trap
Buttons.pde (Abel and Lilianna): Sets up the appearance of the buttons and their click-ability. If a certain button 
  is clicked it'll make a call to a specific function related to either New Game or Hint.

Cell.pde (Abel and Lilianna): Creates the initial grid for the maze and starts eliminating cell walls from the 
  starting position of the player. It also handles the display of the cells in the open and closed set and showing 
  the path from the player to the cheese.

Cheese.pde (Abel and Lilianna): Sets up the cheese image to be later displayed and randomizes the location when a 
  new game is clicked.

MazeGenerator.pde (Abel and Lilianna): Sets up everything in the game (the design/look), the maze can be seen and 
  every other feature within the game. It also handles resetting the maze and path from the player to the cheese, 
  in order for the new game and hint button to work. Also allows for movability within the game.

searchAlg.pde (Abel and Lilianna): Contains the A* algorithm which finds an efficient path from the player to the 
  cheese.

Mouse.pde (Abel and Lilianna): Sets up the player in the game.

winScreen.pde (Abel and Lilianna): helps display a pop up when the player reaches the cheese to show that they won.

Images and Gif (jerry.png, queso.png, win.gif): Must be within this file in order to see the player, cheese, and 
  the win pop up.
