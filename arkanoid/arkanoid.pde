int paddleWidth = 100;
int paddleHeight = 20;
int ballSize = 20;
float ballX, ballY, speedX, speedY;
float paddleX;
boolean[][] bricks;

void setup() {
  size(800, 600);
  paddleX = width / 2;
  ballX = width / 2;
  ballY = height / 2;
  speedX = 3;
  speedY = 3;
  bricks = new boolean[10][5];
  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[i].length; j++) {
      bricks[i][j] = true;
    }
  }
}

void draw() {
  background(0);
  drawPaddle();
  drawBall();
  drawBricks();
  checkCollisionWithWalls();
  checkCollisionWithPaddle();
  checkCollisionWithBricks();
}

void drawPaddle() {
  paddleX = constrain(mouseX, paddleWidth / 2, width - paddleWidth / 2);
  fill(255);
  rect(paddleX - paddleWidth / 2, height - paddleHeight, paddleWidth, paddleHeight);
}

void drawBall() {
  ballX += speedX;
  ballY += speedY;
  fill(255);
  ellipse(ballX, ballY, ballSize, ballSize);
}

void drawBricks() {
  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[i].length; j++) {
      if (bricks[i][j]) {
        fill(255, 0, 0);
        rect(i * 80, j * 30, 80, 30);
      }
    }
  }
}

void checkCollisionWithWalls() {
  if (ballX < ballSize / 2 || ballX > width - ballSize / 2) {
    speedX *= -1;
  }
  if (ballY < ballSize / 2) {
    speedY *= -1;
  }
  if (ballY > height) {
    ballX = width / 2;
    ballY = height / 2;
  }
}

void checkCollisionWithPaddle() {
  if (ballY + ballSize / 2 > height - paddleHeight) {
    if (ballX > paddleX - paddleWidth / 2 && ballX < paddleX + paddleWidth / 2) {
      speedY *= -1;
    }
  }
}

void checkCollisionWithBricks() {
  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[i].length; j++) {
      if (bricks[i][j]) {
        if (ballX + ballSize / 2 > i * 80 && ballX - ballSize / 2 < i * 80 + 80 && ballY + ballSize / 2 > j * 30 && ballY - ballSize / 2 < j * 30 + 30) {
          bricks[i][j] = false;
          speedY *= -1;
        }
      }
    }
  }
}
