/interface ethernet
#    set [ find default-name=ether1 ] name=uplink mac-address=${mac_base}:01
    set [ find default-name=ether2 ] disabled=yes

# /interface bridge
#     set [ find name=bridge ] name=bridge disabled=no admin-mac=${mac_base}:00 auto-mac=no

/interface bridge port
 #   add interface=uplink bridge=bridge edge=no-discover hw=yes
    add interface=ether1 bridge=bridge edge=no-discover hw=yes
    set [ find interface=wlan1 ] bridge=bridge edge=yes-discover hw=yes
    set [ find interface=wlan2 ] bridge=bridge edge=yes-discover hw=yes
    disable [ find interface=ether2 ]

/ip address
    add address=${ip}/24 interface=bridge network=192.168.1.0

/ip dns static
    add address=159.148.172.226 name=upgrade.mikrotik.com

#/ip service
#    set www-ssl certificate=ssl disabled=no

/system clock
    set time-zone-name=America/Chicago
/system identity
    set name="${name}"
/system leds
    set 0 disabled=yes
    set 1 disabled=yes
/system routerboard settings
    set auto-upgrade=yes

#/ip dhcp-client
#    remove 0

/ip/dhcp-server
    disable 0

/ip service
    set www disabled=no
    set www-ssl disabled=no
    set telnet disabled=yes
    set ftp disabled=yes
    set winbox disabled=yes
    set api disabled=yes
    set api-ssl disabled=yes

/interface wireless
    set [ find default-name=wlan1 ] \
        disabled=no country="united states" frequency=auto installation=indoor mode=ap-bridge ssid="${ssid}" \
        band=2ghz-g/n channel-width=20/40mhz-XX radio-name="${name} 2.4" mac-address=${mac_base}:01
    set [ find default-name=wlan2 ] \
        disabled=no country="united states" frequency=auto installation=indoor mode=ap-bridge ssid="${ssid}" \
        band=5ghz-onlyac channel-width=20/40/80mhz-XXXX radio-name="${name} 5" mac-address=${mac_base}:02

/interface wireless security-profiles
    set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
        supplicant-identity=Cookie wpa2-pre-shared-key=${wifi_password}