/*
 * Flame Breathing Pumpkin - Motion sensor or button press triggers servo to depress nozzle on can
 * mostly cribbed from simple servo example from Adafruit Arduino, and probably their PIR example too, I forget at this point
 */

/*
 MIT License

Copyright (c) 2021 Justin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#include <Servo.h> 

Servo servo;  
const int servoPin = 3;
const int angleMin = 20;
const int angleMax = 60;
const int sweepSmoothing = 15;
const int timePIRdepressNozzle = 1 * 1000; //X seconds
const int minTimeBetweenActuation = 5 * 1000; //X seconds
int angle = angleMin;   // servo position in degrees

//led indicator stuff
const int ledPin = 13;                // declare the pin for the onboard LED

//button tester stuff
const int buttonPin = 5;
int buttonPressed = 0;

//PIR motion stuff
int inputPIRPin = 2;               // choose the input pin (from PIR sensor)
//int pirState = LOW;             // we start, assuming no motion detected
int valPIR = 0;                    // variable for reading the pin status

void setup() 
{ 
  pinMode(ledPin, OUTPUT);      // declare LED as output
  servo.attach(servoPin);
  pinMode(buttonPin, INPUT); //declare button as input
  servo.write(angleMin);
  pinMode(inputPIRPin, INPUT);     // declare sensor signal as input
  delay(minTimeBetweenActuation); // settle motion sensor
} 
 
 
void loop() 
{ 
  int buttonState;
  buttonState = digitalRead(buttonPin);
  
  if (buttonState == LOW) {
    if (buttonPressed == 0) {
      buttonPressed = 1;
      nozzlePress();
    }
    //NB: No delay here so release happens exactly when you release button

  } else {
    if (buttonPressed == 1) {
      nozzleRelease();
      buttonPressed = 0;
    }
    
    //delay(minTimeBetweenActuation); //still have a cooldown timeout, because safety?
  }

  valPIR = digitalRead(inputPIRPin);  // read input value
  if (valPIR == HIGH) {            // check if the input is HIGH
    //pres nozzle down with servo
    nozzlePress();
    
    //wait set time before releasing
    delay(timePIRdepressNozzle);
    
    //release nozzle with servo
    nozzleRelease();
    
    delay(minTimeBetweenActuation); //cooldown timeout
    
//    if (pirState == LOW) {
//      // we have just turned on
//      Serial.println("Motion detected!");
//      // We only want to print on the output change, not state
//      pirState = HIGH;
//    }
  }
} 

void nozzlePress() {
  // turn onBoard LED on:
  digitalWrite(ledPin, HIGH); 
  // scan from angleMin to angleMax degrees
  for(angle = angleMin; angle < angleMax; angle++)  
  {                                  
    servo.write(angle);               
    delay(sweepSmoothing);                   
  } 
}

void nozzleRelease() {
  // now scan back from angleMax to angleMin degrees
  for(angle = angleMax; angle > angleMin; angle--)    
  {                                
    servo.write(angle);           
    delay(sweepSmoothing);       
  } 
  servo.write(angleMin); //redundant?
  digitalWrite(ledPin, LOW); // turn LED OFF
}
