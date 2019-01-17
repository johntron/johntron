# Dynamic DNS updater

Enables dynamic DNS updating - even for services that require HTTPS/SSL.

## Installation

* Download root CA certs for use with curl (Google it)
* Ensure cacert.pem and ddns.sh are in the appropriate location
* Make ddns.sh executable: `chmod +x ddns.sh`
* Edit variables at top of ddns.sh
* Setup something to run ddns.sh script regularly (e.g. cron)

## DD-WRT

By default, DD-WRT's filesystem is either read-only or ephemeral (will be lost at reboot). To add your own long-lived scripts (e.g. ddns.sh), you'll need to [enable JFFS](http://www.dd-wrt.com/wiki/index.php/JFFS) and put your files (e.g. ddns.sh) in the JFFS directory.

If you have trouble getting the root CS certificate bundle with wget or curl, you can download the bundle to your local machine, then use scp to transfer to the DD-WRT machine (same goes for ddns.sh):

```
scp ./cacert.pem user@machine
```

See [CRON on DD-WRT's website](https://wiki.dd-wrt.com/wiki/index.php/CRON) or google how to enable this.

For more (outdated) information, see [Secure DDNS Updates Over HTTPS/SSL](https://wiki.dd-wrt.com/wiki/index.php/DDNS_-_How_to_setup_Custom_DDNS_settings_using_embedded_inadyn_-_HOWTO#Custom_.28URL_Updates.29).