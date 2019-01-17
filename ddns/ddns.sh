#!/bin/sh

# See README.md

HOSTNAME=
USERNAME=
PASSWORD=
DNS_SERVICE=domains.google.com
CURL="/usr/bin/curl -sS"
CA_BUNDLE=/jffs/cacert.pem
#LOG_FILE=/var/log/ddns.log # comment-out to use syslogd and logger 
#UPDATE_INTERVAL=300 # seconds - comment-out to run once

log() {
  # sylsog
  echo $@ | logger -t ddns
  # log file
  test -n "$LOG_FILE" && echo $@ >> $LOG_FILE 
  # stdout
  test -t 0 && echo $@
}
  
update_dns() {
  log "Updating $HOSTNAME on $DNS_SERVICE"
  PUBLIC_IP=$1
  URL="https://$USERNAME:$PASSWORD@$DNS_SERVICE/nic/update?hostname=$HOSTNAME&myip=$PUBLIC_IP"
  RESPONSE=$($CURL --cacert $CA_BUNDLE $URL)
  log "Done - got response $RESPONSE"
  nvram set previous_dns_update_response=$RESPONSE && nvram commit
}

main() {
  PUBLIC_IP=$($CURL "http://ipv4bot.whatismyipaddress.com/")
  PREVIOUS_PUBLIC_IP=$(nvram get wan_ipaddr_last)
  PREVIOUS_PUBLIC_IP=${PREVIOUS_PUBLIC_IP:-unset}
  DNS_IP=$(nslookup $HOSTNAME 8.8.8.8 | grep Address | tail -n 1 | awk '{print $3}')

  log ""
  log "Updating DNS at $(date)"
  log "$DNS_IP - IP from DNS"
  log "$PUBLIC_IP - current public IP"
  log "$PREVIOUS_PUBLIC_IP - previously-stored public IP"

  if [ $PUBLIC_IP != $PREVIOUS_PUBLIC_IP ]; then
    log "IP has changed - updating"
    nvram set wan_ipaddr_last=$PUBLIC_IP && nvram commit 
    update_dns $PUBLIC_IP
    return
  fi

  if [ $PUBLIC_IP != $DNS_IP ]; then
    log "DNS IP outdated - updating"
    update_dns $PUBLIC_IP
    return
  fi
  
  log "No changes"
}

main

if [ -n "$UPDATE_INTERVAL" ]; then
  log "Running every $UPDATE_INTERVAL seconds"
  while sleep $UPDATE_INTERVAL
  do 
    main
  done
fi
