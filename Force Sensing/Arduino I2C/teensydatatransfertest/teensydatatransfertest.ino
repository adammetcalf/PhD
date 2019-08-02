#include <Wire.h>
int a = 0; // HES 1 raw voltage reading
int b = 0; // HES 2 raw voltage reading
int c = 0; // HES 3 raw voltage reading
int d = 0; // HES 4 raw voltage reading

// bytes and byte array declared as volatile, since it is 
//necessary to inform the compiler that the values may
//change via interrupts, so that the compiler
//doesn't optimise the code away.

volatile byte dataPacket[8]; // array of bytes to send
volatile byte ha = 0; // High byte for HES1
volatile byte la = 10; // low byte for HES1
volatile byte hb = 0; // High byte for HES2
volatile byte lb = 0; // low byte for HES2
volatile byte hc = 11; // High byte for HES3
volatile byte lc = 0; // low byte for HES3
volatile byte hd = 0; // High byte for HES4
volatile byte ld = 13; // low byte for HES4

//setup code
void setup() {
  Wire.begin(1);                // join i2c bus with address #1
  Wire.onRequest(requestEvent); // register event
}
// end setup code

//Main loop code
void loop() {
  a = analogRead(0); //read raw bits for HES 1
  b = analogRead(1); //read raw bits for HES 2
  c = analogRead(2); //read raw bits for HES 3
  d = analogRead(3); //read raw bits for HES 4
  getByte(); // cast to high and low bytes
  fillArray(); // build byte array for transfer
  delay(1);
}
// end main loop code

// Function to cast high and low bytes
void getByte() {
  ha = highByte(a);
  la = lowByte(a);
  hb = highByte(b);
  lb = lowByte(b);
  hc = highByte(c);
  lc = lowByte(c);
  hd = highByte(d);
  ld = lowByte(d);  
}
// end function

// function to build transfer array
void fillArray() {
  dataPacket[0] = ha;
  dataPacket[1] = la;
  dataPacket[2] = hb;
  dataPacket[3] = lb;
  dataPacket[4] = hc;
  dataPacket[5] = lc;
  dataPacket[6] = hd;
  dataPacket[7] = ld;
}
// end fucntion

// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent() {
  Wire.write((byte*)dataPacket, 8);
}
// end function
