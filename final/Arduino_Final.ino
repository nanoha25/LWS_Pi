#include <LCD5110_Graph.h>

LCD5110 myGLCD(8,9,10,11,12);

extern unsigned char SmallFont[];

const int VCC = A0; // VCC pin
const int GND = A4; // GND pin

const int xPin = A1; // x axis pin
const int yPin = A2; // y axis pin
const int zPin = A3; // z axis pin

int prev_x = 350; //initial variables
int prev_y = 250;
int prev_z = 350; 

void setup() {
  Serial.begin(9600);
  pinMode (VCC, OUTPUT);
  pinMode (GND, OUTPUT);
  digitalWrite (VCC, HIGH);
  digitalWrite (GND, LOW);

  myGLCD.InitLCD();
  myGLCD.setFont(SmallFont);
}

void loop() {
  if ((analogRead(xPin) > (prev_x + 100)) ||  (analogRead(xPin) < (prev_x - 100))) { //Determines a drop based on previous values from last iteration
    myGLCD.print("xTRIG ", 50, 10);
  }

  if ((analogRead(yPin) > (prev_y + 100)) ||  (analogRead(yPin) < (prev_y - 100))) {
    myGLCD.print("yTRIG ", 50, 25);
  }
  
  if ((analogRead(zPin) > (prev_z + 100)) ||  (analogRead(zPin) < (prev_z - 100))) {
    myGLCD.print("zTRIG ", 50, 40);
  }
  // print the sensor values:
  Serial.print(analogRead(xPin));
  Serial.print("\t");
  Serial.print(analogRead(yPin));
  Serial.print("\t");
  Serial.print(analogRead(zPin));
  Serial.println();

  myGLCD.print("X: ", 10, 10); //Printing values to LCD screen
  myGLCD.printNumI(analogRead(xPin), 25, 10);

  myGLCD.print("Y: ", 10, 25);
  myGLCD.printNumI(analogRead(yPin), 25, 25);

  myGLCD.print("Z: ", 10, 40);
  myGLCD.printNumI(analogRead(zPin), 25, 40);
  myGLCD.update();

  prev_x = analogRead(xPin);
  prev_y = analogRead(yPin);
  prev_z = analogRead(zPin);
  
  delay(25);
}
