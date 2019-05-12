#include "driver/i2c.h"

//#include <string.h>
//
//#include "freertos/FreeRTOS.h"
//
//#include "esp_event.h"
//#include "esp_event_loop.h"
//#include "esp_system.h"
//#include "esp_wifi.h"
//#include "nvs_flash.h"
//
//#include "mongoose.h"
//
//#define WIFI_SSID "Johntron"
//#define WIFI_PASS "/pAV5&UP"
//
//#define MG_LISTEN_ADDR "80"
//
//static esp_err_t event_handler(void *ctx, system_event_t *event) {
//  (void) ctx;
//  (void) event;
//  return ESP_OK;
//}
//
//static void mg_ev_handler(struct mg_connection *nc, int ev, void *p) {
//  static const char *reply_fmt =
//      "HTTP/1.0 200 OK\r\n"
//      "Connection: close\r\n"
//      "Content-Type: text/plain\r\n"
//      "\r\n"
//      "Hello %s\n";
//
//  switch (ev) {
//    case MG_EV_ACCEPT: {
//      char addr[32];
//      mg_sock_addr_to_str(&nc->sa, addr, sizeof(addr),
//                          MG_SOCK_STRINGIFY_IP | MG_SOCK_STRINGIFY_PORT);
//      printf("Connection %p from %s\n", nc, addr);
//      break;
//    }
//    case MG_EV_HTTP_REQUEST: {
//      char addr[32];
//      struct http_message *hm = (struct http_message *) p;
//      mg_sock_addr_to_str(&nc->sa, addr, sizeof(addr),
//                          MG_SOCK_STRINGIFY_IP | MG_SOCK_STRINGIFY_PORT);
//      printf("HTTP request from %s: %.*s %.*s\n", addr, (int) hm->method.len,
//             hm->method.p, (int) hm->uri.len, hm->uri.p);
//      mg_printf(nc, reply_fmt, addr);
//      nc->flags |= MG_F_SEND_AND_CLOSE;
//      break;
//    }
//    case MG_EV_CLOSE: {
//      printf("Connection %p closed\n", nc);
//      break;
//    }
//  }
//}

#define I2C_FREQUENCY 100000
#define MASTER_PORT I2C_NUM_0
#define NO_BUFFER_NEEDED_FOR_MASTER 0
#define SLAVE_ADDRESS 0b10000
#define FRAME_SIZE_BYTES 4
#define ACK false

void i2c_master_init()
{
  int i2c_master_port = MASTER_PORT;
  i2c_config_t conf;
  conf.mode = I2C_MODE_MASTER;
  conf.sda_io_num = GPIO_NUM_16;
  conf.scl_io_num = GPIO_NUM_17;
  conf.sda_pullup_en = GPIO_PULLUP_ENABLE;
  conf.scl_pullup_en = GPIO_PULLUP_ENABLE;
  conf.master.clk_speed = I2C_FREQUENCY;
  ESP_ERROR_CHECK(i2c_param_config(i2c_master_port, &conf));
  ESP_ERROR_CHECK(i2c_driver_install(i2c_master_port, conf.mode,
                            NO_BUFFER_NEEDED_FOR_MASTER,
                            NO_BUFFER_NEEDED_FOR_MASTER, 0));
}

void send_to_slave(uint8_t* data, size_t size) {
  i2c_cmd_handle_t cmd = i2c_cmd_link_create();
  ESP_ERROR_CHECK(i2c_master_start(cmd));
//  ESP_ERROR_CHECK(i2c_master_write_byte(cmd, (SLAVE_ADDRESS << 1) | I2C_MASTER_WRITE, ACK));
  ESP_ERROR_CHECK(i2c_master_write_byte(cmd, SLAVE_ADDRESS, ACK));
  ESP_ERROR_CHECK(i2c_master_write(cmd, data, size, ACK));
  ESP_ERROR_CHECK(i2c_master_stop(cmd));

  ESP_ERROR_CHECK(i2c_master_cmd_begin(MASTER_PORT, cmd, 10000));
  i2c_cmd_link_delete(cmd);
}

void app_main(void) {
  printf("hi\n");
  i2c_master_init();
  printf("Connected\n");
  uint8_t* data = (uint8_t*) malloc(FRAME_SIZE_BYTES);
  for(int i = 0; i < FRAME_SIZE_BYTES; i += 1) {
    data[i] = i;
  }
  while (1) {
    send_to_slave(data, FRAME_SIZE_BYTES);
    printf("Sent\n");
    vTaskDelay(100);
  }
}

/*
void app_main(void) {
  nvs_flash_init();
  tcpip_adapter_init();
  ESP_ERROR_CHECK(esp_event_loop_init(event_handler, NULL));

  // Initializing WiFi
  wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
  ESP_ERROR_CHECK(esp_wifi_init(&cfg));
  ESP_ERROR_CHECK(esp_wifi_set_storage(WIFI_STORAGE_RAM));
  ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA));
  wifi_config_t sta_config = {
      .sta = {.ssid = WIFI_SSID, .password = WIFI_PASS, .bssid_set = false}};
  ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_STA, &sta_config));
  ESP_ERROR_CHECK(esp_wifi_start());
  ESP_ERROR_CHECK(esp_wifi_connect());

  // Starting Mongoose
  struct mg_mgr mgr;
  struct mg_connection *nc;

  printf("Starting web-server on port %s\n", MG_LISTEN_ADDR);

  mg_mgr_init(&mgr, NULL);

  nc = mg_bind(&mgr, MG_LISTEN_ADDR, mg_ev_handler);
  if (nc == NULL) {
    printf("Error setting up listener!\n");
    return;
  }
  mg_set_protocol_http_websocket(nc);

  // Processing events
  while (1) {
    mg_mgr_poll(&mgr, 1000);
  }
}
*/