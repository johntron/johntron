#include "wifi.h"
#include "print.h"
#include <SPI.h>
#include <WiFi101.h>

void Wifi::connect(const char* ssid, const char* pass) {
    int status = WL_IDLE_STATUS;     // the WiFi radio's status

    WiFi.setPins(8,7,4,2);
    //Initialize serial and wait for port to open:


    // check for the presence of the shield:
    if (WiFi.status() == WL_NO_SHIELD) {
        Serial.println("WiFi shield not present");
        // don't continue:
        while (true);
    }

    // attempt to connect to WiFi network:
    while ( status != WL_CONNECTED) {
        Serial.print("Attempting to connect to WPA SSID: ");
        Serial.println(ssid);
        // Connect to WPA/WPA2 network:
        status = WiFi.begin(ssid, pass);

        // wait 10 seconds for connection:
        delay(10000);
    }

    // you're connected now, so print out the data:
    Serial.print("You're connected to the network");
    printCurrentNet();
    printWiFiData();
}