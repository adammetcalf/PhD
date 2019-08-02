#include <Wire.h>
int a = 0; //raw voltage reading (0-1023) for HES1
String a1; //string of binary data for HES 1
int a2;
int b = 0; //raw voltage reading (0-1023) for HES2
String b1; //string of binary data for HES 2
int b2;
int c = 0; //raw voltage reading (0-1023) for HES3
String c1; //string of binary data for HES 3
int c2;
int d = 0; //raw voltage reading (0-1023) for HES4
String d1; //string of binary data for HES 4
int d2;
String trans; //outgoing message


//setup code
void setup() {
  Wire.begin(1);                // join i2c bus with address #1
  Wire.onRequest(requestEvent); // register event
}
// end setup code

// main loop code
void loop() {
  a = analogRead(0); //read raw bits for HES 1
  b = analogRead(1); //read raw bits for HES 2
  c = analogRead(2); //read raw bits for HES 3
  d = analogRead(3); //read raw bits for HES 4

 
  a1 = String(a, BIN); //convert filtered reading of HES 1 to string of bits
  a2 = a1.length(); //get length, necessary to evaluate MSB padding of zeros
  b1 = String(b, BIN); //convert filtered reading of HES 2 to string of bits
  b2 = b1.length(); //get length, necessary to evaluate MSB padding of zeros
  c1 = String(c, BIN); //convert filtered reading of HES 3 to string of bits
  c2 = c1.length(); //get length, necessary to evaluate MSB padding of zeros
  d1 = String(d, BIN); //convert filtered reading of HES 4 to string of bits
  d2 = d1.length(); //get length, necessary to evaluate MSB padding of zeros

  padOne(); //This function pads filtered reading for HES 1, bringing to 10 bits in length
  padTwo(); //This function pads filtered reading for HES 2, bringing to 10 bits in length
  padThree(); //This function pads filtered reading for HES 3, bringing to 10 bits in length
  padFour(); //This function pads filtered reading for HES 4, bringing to 10 bits in length
  
  trans = "000111"+a1+b1+c1+d1; //form the final message, 46 bits. 6 bits identifier, 40 bits data
  delay(10);
}
// end main loop code

// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent() {
  Wire.write(trans.c_str()); // respond with message of 6 bytes (convert to char first)
  // as expected by master
}
// end function

void padOne() // This function pads the filtered reading of HES 1 to 10 bits
{
  if (a2<10) //pad zeros on left
  {
    if (a2==9)
    { 
      a1 = "0" + a1;
    }
    else if (a2==8)
    { 
      a1 = "00" + a1;
    }
    else if (a2==7)
    { 
      a1 = "000" + a1;
    }
    else if (a2==6)
    { 
      a1 = "0000" + a1;
    }
    else if (a2==5)
    { 
      a1 = "00000" + a1;
    }
    else if (a2==4)
    { 
      a1 = "000000" + a1;
    }
    else if (a2==3)
    { 
      a1 = "0000000" + a1;
    }
    else if (a2==2)
    { 
      a1 = "00000000" + a1;
    }
    else if (a2==1)
    { 
      a1 = "000000000" + a1;
    }           
  }
}

void padTwo() // This function pads the filtered reading of HES 2 to 10 bits
{
 if (b2<10) //pad zeros on left
  {
    if (b2==9)
    { 
      b1 = "0" + b1;
    }
    else if (b2==8)
    { 
      b1 = "00" + b1;
    }
    else if (b2==7)
    { 
      b1 = "000" + b1;
    }
    else if (b2==6)
    { 
      b1 = "0000" + b1;
    }
    else if (b2==5)
    { 
      b1 = "00000" + b1;
    }
    else if (b2==4)
    { 
      b1 = "000000" + b1;
    }
    else if (b2==3)
    { 
      b1 = "0000000" + b1;
    }
    else if (b2==2)
    { 
      b1 = "00000000" + b1;
    }
    else if (b2==1)
    { 
      b1 = "000000000" + b1;
    }           
  }
}

void padThree() // This function pads the filtered reading of HES 3 to 10 bits
{
 if (c2<10) //pad zeros on left
  {
    if (c2==9)
    { 
      c1 = "0" + c1;
    }
    else if (c2==8)
    { 
      c1 = "00" + c1;
    }
    else if (c2==7)
    { 
      c1 = "000" + c1;
    }
    else if (c2==6)
    { 
      c1 = "0000" + c1;
    }
    else if (c2==5)
    { 
      c1 = "00000" + c1;
    }
    else if (c2==4)
    { 
      c1 = "000000" + c1;
    }
    else if (c2==3)
    { 
      c1 = "0000000" + c1;
    }
    else if (c2==2)
    { 
      c1 = "00000000" + c1;
    }
    else if (c2==1)
    { 
      c1 = "000000000" + c1;
    }           
  }
}

void padFour() // This function pads the filtered reading of HES 4 to 10 bits
{
 if (d2<10) //pad zeros on left
  {
    if (d2==9)
    { 
      d1 = "0" + d1;
    }
    else if (d2==8)
    { 
      d1 = "00" + d1;
    }
    else if (d2==7)
    { 
      d1 = "000" + d1;
    }
    else if (d2==6)
    { 
      d1 = "0000" + d1;
    }
    else if (d2==5)
    { 
      d1 = "00000" + d1;
    }
    else if (d2==4)
    { 
      d1 = "000000" + d1;
    }
    else if (d2==3)
    { 
      d1 = "0000000" + d1;
    }
    else if (d2==2)
    { 
      d1 = "00000000" + d1;
    }
    else if (d2==1)
    { 
      d1 = "000000000" + d1;
    }           
  }
}
