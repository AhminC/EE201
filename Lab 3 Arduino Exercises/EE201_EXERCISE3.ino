void setup() {
  // put your setup code here, to run once:
  pinMode(0, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  if (digitalRead(0) == HIGH) {
      Serial.print("Hello World");
    } else {
      Serial.print("It's 202s3");
      }
}
