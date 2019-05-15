int count =0; // required for filtering function
int filt1[] = {0, 0, 0, 0, 0}; // required for filtering function
int filt2[] = {0, 0, 0, 0, 0}; // required for filtering function
int filt3[] = {0, 0, 0, 0, 0}; // required for filtering function
int filt4[] = {0, 0, 0, 0, 0}; // required for filtering function
int filtered1; // filtered reading for HES 1
int filtered2; // filtered reading for HES 2
int filtered3; // filtered reading for HES 3
int filtered4; // filtered reading for HES 4
int total=0; // required for filtering function
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
byte incomingByte = "0"; //incoming byte from myrio, when received data will be sent
String trans; //outgoing message
int rx = 0;
int tx = 1;

void setup() {
  Serial.begin(9600);
  pinMode (rx, OUTPUT);
  pinMode (tx, INPUT);
  while (!Serial) {

  ; // wait for serial port to connect. Needed for native USB

  }
}

void loop() {

  a = analogRead(0); //read raw bits for HES 1
  b = analogRead(1); //read raw bits for HES 2
  c = analogRead(2); //read raw bits for HES 3
  d = analogRead(3); //read raw bits for HES 4

  DoFilter(); //Call filter function to implement running average filter
  
  a1 = String(filtered1, BIN); //convert filtered reading of HES 1 to string of bits
  a2 = a1.length(); //get length, necessary to evaluate MSB padding of zeros
  b1 = String(filtered2, BIN); //convert filtered reading of HES 2 to string of bits
  b2 = b1.length(); //get length, necessary to evaluate MSB padding of zeros
  c1 = String(filtered3, BIN); //convert filtered reading of HES 3 to string of bits
  c2 = c1.length(); //get length, necessary to evaluate MSB padding of zeros
  d1 = String(filtered4, BIN); //convert filtered reading of HES 4 to string of bits
  d2 = d1.length(); //get length, necessary to evaluate MSB padding of zeros

  padOne(); //This function pads filtered reading for HES 1, bringing to 10 bits in length
  padTwo(); //This function pads filtered reading for HES 2, bringing to 10 bits in length
  padThree(); //This function pads filtered reading for HES 3, bringing to 10 bits in length
  padFour(); //This function pads filtered reading for HES 4, bringing to 10 bits in length

  // send data only when you receive "0" data from myRIO:
  if (Serial.available() > 0) {
    //read the incoming byte:
    incomingByte = Serial.read();
    if (incomingByte = "0"){
    trans = "000111"+a1+b1+c1+d1; //form the final message, 46 bits. 6 bits identifier, 40 bits data
    Serial.println(trans);
    }
  }
  delay(50);
  count = count+1;
}


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

void DoFilter() //Filter last 5 readings
{
  // first 10 iterations, use unfiltered data but populate arrays
  if (count <5){
    filt1[count] = a;
    filt2[count] = b;
    filt3[count] = c;
    filt4[count] = d;
    filtered1 = a;
    filtered2 = b;
    filtered3 = c;
    filtered4 = d;
  }

  //after first 5 iterations, shift all values in arrays,
  //place in new values, find running averages
  else {

   // repopulate arrays
   filt1[4] = filt1[3];
   filt1[3] = filt1[2];
   filt1[2] = filt1[1];
   filt1[1] = filt1[0];
   filt1[0] = a;
   
   // sum contents of array, find average
   total = 0;
   for (int i = 0; i < 5; ++i)
   total += filt1[i];
   filtered1 = round(total/5);

   // repopulate arrays
   filt2[4] = filt2[3];
   filt2[3] = filt2[2];
   filt2[2] = filt2[1];
   filt2[1] = filt2[0];
   filt2[0] = b;

   // sum contents of array, find average
   total = 0;
   for (int i = 0; i < 5; ++i)
   total += filt2[i];
   filtered2 = round(total/5);

   // repopulate arrays
   filt3[4] = filt3[3];
   filt3[3] = filt3[2];
   filt3[2] = filt3[1];
   filt3[1] = filt3[0];
   filt3[0] = c;

   // sum contents of array, find average
   total = 0;
   for (int i = 0; i < 5; ++i)
   total += filt3[i];
   filtered3 = round(total/5);

   // repopulate arrays
   filt4[4] = filt4[3];
   filt4[3] = filt4[2];
   filt4[2] = filt4[1];
   filt4[1] = filt4[0];
   filt4[0] = d;

   // sum contents of array, find average
   total = 0;
   for (int i = 0; i < 5; ++i)
   total += filt4[i];
   filtered4 = round(total/5);
  }

}
