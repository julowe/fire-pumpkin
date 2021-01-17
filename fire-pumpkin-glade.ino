/*
 FireLantern v1

 This sketch allows you to control the motor on a Glade freshmatic.

 By Rick Osgood

 : connect Glade VCC to Aduino 3.3V
 : connect Glade GND to Arduino GND
 : connect Glade "Manual" switch wire to Arduino pin 2 (motorpin)
 : connect PING sensor VCC to Arduino VCC
 : connect PING sensor GND to Arduino GND
 : connect PING sensor signal wire to Arduino pin 3 (pingpin)

*/

// https://www.youtube.com/watch?v=qDRTbuhs05Q
//Downloaded from https://web.archive.org/web/20131106091413/http://www.richardosgood.com/blog/wp-content/uploads/2013/10/fireLantern_v1.ino

// Pin Definitions
#define motorpin 2
#define pingpin 3

// Constants
const int TRIGGER_DISTANCE = 60; // How many inches from the PING sensor is the threshold?
const int SAFETY_DISTANCE = 32;  // How many inches from the PING sensor is the "safety" threshold?
const int WAIT_TIME = 30000; // How many seconds to wait after firing before we can fire again?

void setup() {
  pinMode(motorpin, OUTPUT);
  pinMode(pingpin, OUTPUT);

  digitalWrite(motorpin, HIGH); // Make sure fire button starts unpressed (When button is pulled to ground it will fire)

  Serial.begin(9600);
}

void loop() {
  int distance = sensePing();	// Get the current distance
  Serial.println(distance);		// Print it to serial for debugging
  if ((distance < TRIGGER_DISTANCE) && (distance > SAFETY_DISTANCE)) {  // If the sensor detects something close but not too close
    flameOn();  // Then press the fire button
    delay(WAIT_TIME);  // Wait for WAIT_TIME milliseconds so the pumpkin doesn't fire over and over if something is not moving
  }
}

void flameOn() {
  digitalWrite(motorpin, LOW);  // "Press" the fire button
  delay(200);
  digitalWrite(motorpin, HIGH);  // Stop pressing the button
}

int sensePing() {
  pinMode(pingpin, OUTPUT);
  digitalWrite(pingpin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingpin, HIGH);	//Send a pulse to the PING sensor
  delayMicroseconds(5);
  digitalWrite(pingpin, LOW);	//End pulse

  pinMode(pingpin, INPUT);
  return microsecondsToInches(pulseIn(pingpin, HIGH));	//Get the pulse, convert to inches and return the value
}

// This function from Arduino PING example sketch
long microsecondsToInches(long microseconds)
{
  // According to Parallax's datasheet for the PING))), there are
  // 73.746 microseconds per inch (i.e. sound travels at 1130 feet per
  // second).  This gives the distance travelled by the ping, outbound
  // and return, so we divide by 2 to get the distance of the obstacle.
  // See: http://www.parallax.com/dl/docs/prod/acc/28015-PING-v1.3.pdf
  return microseconds / 74 / 2;
}
