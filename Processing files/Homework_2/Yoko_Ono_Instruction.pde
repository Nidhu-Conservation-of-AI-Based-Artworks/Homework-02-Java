PVector eye = new PVector(400, 300, 1200);
PVector center = new PVector(400, 0, 0);
float zoom = 1.0;
float rotationX = 0.0;
float rotationY = 0.0;
boolean mousePressedLastFrame = false;

void setup() {
  size(800, 600, P3D);
}

void draw() {
  background(135, 206, 235);
  lights();

  PVector zoomedEye = PVector.sub(eye, center).mult(zoom).add(center);

  PVector rotatedEye = rotateAroundCenter(zoomedEye, center, rotationX, rotationY);

  camera(rotatedEye.x, rotatedEye.y, rotatedEye.z, center.x, center.y, center.z, 0, 1, 0);

  if (mousePressed && !mousePressedLastFrame) {
    rotationX = 0;
    rotationY = 0;
  }
  if (mousePressed) {
    rotationX += (mouseX - pmouseX) * 0.01;
    rotationY += (mouseY - pmouseY) * 0.01;
  }
  mousePressedLastFrame = mousePressed;

  if (mousePressed && mouseButton == RIGHT) {
    zoom += (mouseX - pmouseX) * 0.01;
    zoom = constrain(zoom, 0.1, 2.0);
  }

  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP) {
        center.y -= 10;
      } else if (keyCode == DOWN) {
        center.y += 10;
      } else if (keyCode == LEFT) {
        center.x -= 10;
      } else if (keyCode == RIGHT) {
        center.x += 10;
      }
    }
  }

  if (keyPressed && key == 's') {
    saveFrame("screenshot-####.png");
  }


  background(135, 206, 235);
  lights();

  PVector templePos = new PVector(200, 0, 0);
  PVector skyscraperPos = new PVector(400, 0, -50);
  PVector towerPos = new PVector(600, 0, 0);

  drawTemple(templePos);
  drawSkyscraper(skyscraperPos);
  drawTower(towerPos);

}

void drawTemple(PVector position) {
  pushMatrix();
  translate(position.x, position.y, position.z);
  fill(210, 180, 140);
  box(150, 300, 150);
  popMatrix();
}

void drawSkyscraper(PVector position) {
  pushMatrix();
  translate(position.x, position.y, position.z);
  fill(100, 100, 100);
  box(80, 300, 80);
  popMatrix();
}

void drawTower(PVector position) {
  pushMatrix();
  translate(position.x, position.y, position.z);
  fill(150, 150, 150);
  box(70, 300, 70);
  popMatrix();
}

PVector rotateAroundCenter(PVector point, PVector center, float angleX, float angleY) {
  PVector translated = PVector.sub(point, center);

  float cosY = cos(angleY);
  float sinY = sin(angleY);
  float x = translated.x * cosY - translated.z * sinY;
  float z = translated.x * sinY + translated.z * cosY;
  translated.x = x;
  translated.z = z;

  float cosX = cos(angleX);
  float sinX = sin(angleX);
  float y = translated.y * cosX - translated.z * sinX;
  z = translated.y * sinX + translated.z * cosX;
  translated.y = y;
  translated.z = z;

  return PVector.add(translated, center);
}
