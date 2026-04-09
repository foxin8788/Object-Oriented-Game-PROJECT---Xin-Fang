int gameState = 0;  
// 0 = start menu
// 1 = settings
// 2 = playing
// 3 = paused
// 4 = end screen

int killCount = 0; // Player kill count
int winTarget = 15; // How many kills do the player need to win?
float playerHealth = 3.0; // Player's health

// Determine if the game has ended
boolean gameOver = false;
boolean gameWon = false;

// Press and hold to move (Using the keyboard directly to determine if a key is pressed results in a bug where movement in two directions cannot occur simultaneously.)
boolean holdW, holdA, holdS, holdD;

Player p;

// Bullet and Enemy List
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
