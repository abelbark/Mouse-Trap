// Contributors: Abel Abarca & Lilianna Rosales
import gifAnimation.*;


class winScreen {
  int winX, winY;
  Gif win;

  winScreen(int inputX, int inputY, Gif win) {
    this.winX = inputX;
    this.winY = inputY;
    this.win = win;
  }

  boolean playerWins(Mouse player, Cheese cheese) {
    if (player.userMouseX == cheese.cheeseX && player.userMouseY == cheese.cheeseY) {
      println("I win");
      win.loop();
      return true;
    }
    return false;
  }

  void display() {
    int tempX = (width - win.width)/2;
    int tempY = (height - win.height)/2 - win.height/4;
    image(win, tempX, tempY);
  }

  void playGif() {
    win.play();
  }

  void stopGif() {
    win.stop();
  }
}
