void setup() {
  size(800, 600, P3D);
}

void draw() {
  background(135, 206, 235); // Sky blue background
  lights();

  // Draw the ground
  drawGround();

  // Define the positions of the buildings
  PVector templePos = new PVector(300, height/2, 300);
  PVector skyscraperPos = new PVector(400, height/2, 400);
  PVector towerPos = new PVector(500, height/2, 500);

  // Draw the buildings
  drawTemple(templePos);
  drawSkyscraper(skyscraperPos);
  drawTower(towerPos);

  // Set the first viewpoint to see all three buildings
  camera(400, 300, 1200, 400, 300, 0, 0, 1, 0);
  saveFrame("viewpoint_all_three.png");

  // Set the second viewpoint to see two buildings
  camera(600, 300, 800, 400, 300, 0, 0, 1, 0);
  saveFrame("viewpoint_two.png");

  // Set the third viewpoint to see one building
  camera(800, 300, 400, 400, 300, 0, 0, 1, 0);
  saveFrame("viewpoint_one.png");

  // Allow manual interaction
  if (mousePressed) {
    camera(mouseX, mouseY, -200, 400, height/2, 400, 0, 1, 0);
  }
}

void drawGround() {
  pushMatrix();
  translate(width/2, height, -500);
  rotateX(HALF_PI);
  fill(34, 139, 34); // Forest green color
  noStroke();
  drawPlane(2000, 2000);
  popMatrix();
}

void drawTemple(PVector position) {
  pushMatrix();
  translate(position.x, position.y, position.z);

  // Base of the temple
  fill(210, 180, 140); // Light brown color
  box(100, 30, 100);

  // Middle part of the temple
  translate(0, -15, 0);
  fill(180, 140, 90); // Darker brown color
  drawCylinder(40, 80);

  // Top part of the temple
  translate(0, -40, 0);
  fill(255, 215, 0); // Gold color
  drawCone(30, 50);

  // Dome on top of the temple
  translate(0, -25, 0);
  fill(255, 255, 255); // White color
  sphere(25);

  popMatrix();
}

void drawSkyscraper(PVector position) {
  pushMatrix();
  translate(position.x, position.y, position.z);

  // Main body of the skyscraper
  fill(100, 100, 100); // Gray color
  box(80, 300, 80);

  // Windows on the skyscraper
  drawWindows(80, 300, 80, 15, 4);

  // Middle section
  translate(0, -150, 0);
  fill(200, 200, 200); // Light gray color
  box(90, 50, 90);

  // Top section
  translate(0, -25, 0);
  fill(50, 50, 50); // Dark gray color
  box(100, 50, 100);

  popMatrix();
}

void drawTower(PVector position) {
  pushMatrix();
  translate(position.x, position.y, position.z);

  // Main body of the tower
  fill(150, 150, 150); // Medium gray color
  drawCylinder(35, 250);

  // Middle section
  translate(0, -125, 0);
  fill(255, 0, 0); // Red color
  sphere(40);

  // Top section
  translate(0, -20, 0);
  fill(0, 0, 255); // Blue color
  drawCone(20, 50);

  // Antenna on top of the tower
  translate(0, -25, 0);
  fill(200, 200, 200); // Light gray color
  box(10, 100, 10);

  popMatrix();
}

void drawCylinder(float radius, float height) {
  int detail = 30;
  float angle = 0;
  float angleIncrement = TWO_PI / detail;

  beginShape(QUAD_STRIP);
  for (int i = 0; i <= detail; i++) {
    float x = cos(angle) * radius;
    float z = sin(angle) * radius;
    vertex(x, -height / 2, z);
    vertex(x, height / 2, z);
    angle += angleIncrement;
  }
  endShape();

  // Draw the top and bottom caps
  beginShape(TRIANGLE_FAN);
  vertex(0, height / 2, 0);
  angle = 0;
  for (int i = 0; i <= detail; i++) {
    float x = cos(angle) * radius;
    float z = sin(angle) * radius;
    vertex(x, height / 2, z);
    angle += angleIncrement;
  }
  endShape();

  beginShape(TRIANGLE_FAN);
  vertex(0, -height / 2, 0);
  angle = 0;
  for (int i = 0; i <= detail; i++) {
    float x = cos(angle) * radius;
    float z = sin(angle) * radius;
    vertex(x, -height / 2, z);
    angle += angleIncrement;
  }
  endShape();
}

void drawCone(float radius, float height) {
  int detail = 30;
  float angle = 0;
  float angleIncrement = TWO_PI / detail;

  beginShape(TRIANGLE_FAN);
  vertex(0, -height / 2, 0);
  for (int i = 0; i <= detail; i++) {
    float x = cos(angle) * radius;
    float z = sin(angle) * radius;
    vertex(x, height / 2, z);
    angle += angleIncrement;
  }
  endShape();

  // Draw the base
  beginShape(TRIANGLE_FAN);
  vertex(0, height / 2, 0);
  angle = 0;
  for (int i = 0; i <= detail; i++) {
    float x = cos(angle) * radius;
    float z = sin(angle) * radius;
    vertex(x, height / 2, z);
    angle += angleIncrement;
  }
  endShape();
}

void drawWindows(float width, float height, float depth, int rows, int cols) {
  float windowWidth = width / cols;
  float windowHeight = height / rows;
  float halfDepth = depth / 2;

  noFill();
  stroke(255);
  strokeWeight(2);

  beginShape(QUADS);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x1 = -width / 2 + j * windowWidth;
      float y1 = -height / 2 + i * windowHeight;
      float x2 = x1 + windowWidth;
      float y2 = y1 + windowHeight;

      vertex(x1, y1, halfDepth);
      vertex(x2, y1, halfDepth);
      vertex(x2, y2, halfDepth);
      vertex(x1, y2, halfDepth);
    }
  }
  endShape();
}

void drawPlane(float width, float height) {
  beginShape(QUADS);
  vertex(-width / 2, -height / 2, 0);
  vertex(width / 2, -height / 2, 0);
  vertex(width / 2, height / 2, 0);
  vertex(-width / 2, height / 2, 0);
  endShape();
}
