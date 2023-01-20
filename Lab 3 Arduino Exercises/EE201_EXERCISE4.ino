void setup() {
  pinMode(9, OUTPUT);  // F 
  pinMode(10, OUTPUT); // G 
  pinMode(1, OUTPUT);  // E 
  pinMode(2, OUTPUT);  // D
  pinMode(4, OUTPUT);  // C    
  pinMode(6, OUTPUT);  // B     
  pinMode(7, OUTPUT);  // A     

}

void loop() {
  //9
  digitalWrite(7, LOW);
  digitalWrite(6, LOW);
  digitalWrite(9, LOW);
  digitalWrite(10, LOW);
  digitalWrite(4, LOW);
  digitalWrite(2, LOW);
  delay(15000);

  //8
  digitalWrite(1, LOW);
  digitalWrite(2, LOW);
  digitalWrite(4, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(9, LOW);
  digitalWrite(10, LOW); 
  delay(15000);

  //7
  digitalWrite(4, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  delay(15000);

  //6
  digitalWrite(1, LOW);
  digitalWrite(2, LOW);
  digitalWrite(4, LOW);
  digitalWrite(7, LOW);
  digitalWrite(9, LOW);
  digitalWrite(10, LOW); 
  delay(15000);

  //5
  digitalWrite(2, LOW);
  digitalWrite(4, LOW);
  digitalWrite(7, LOW);
  digitalWrite(9, LOW);
  digitalWrite(10, LOW); 
  delay(15000);

  //4
  digitalWrite(4, LOW);
  digitalWrite(6, LOW);
  digitalWrite(9, LOW);
  digitalWrite(10, LOW); 
  delay(15000);
  
  //3
  digitalWrite(2, LOW);
  digitalWrite(4, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(10, LOW); 
  delay(15000); 

  //2
  digitalWrite(1, LOW);
  digitalWrite(2, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(10, LOW); 
  delay(15000); 

  //1
  digitalWrite(1, LOW);
  digitalWrite(9, LOW);
  delay(15000); 

  //0
  digitalWrite(1, LOW);
  digitalWrite(2, LOW);
  digitalWrite(4, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(9, LOW); 
  delay(15000);
}
