# Remote device testing

Terminology:

* Remote device - the device you're trying to test/debug, like an iPhone
* Development server - the machine running your local development environment, like a laptop

In order, I prefer these methods:

* Browserstack – easiest and most capable
* Proxy if I don't need debugging – easy
* Simulator – still pretty easy, and can do debugging, but doesn't fully simulate real devices
* USB – a real device, and doesn't require a Browserstack account


## Browserstack

Browser support: lots
Capabilities: testing and debugging
Can access hostnames in /etc/hosts: yes, with the Chrome plugin and "Resolve all URLs through my network"

Basic steps:
1. Install Browserstack's Chrome plugin
1. Open Chrome and click the plugin's icon
1. Choose test device and browser
1. Wait for device to boot
1. Open Browserstack's settings (gear icon in hovering button panel grossness)
1. Enable "Resolve all URLs through my network" under "Server Testing"
1. Wait for device to reboot and reconnect
1. Navigate as if you were on your development server
1. Open devtools by clicking "Devtools" in the gross hovering button panel

Gotchas:

* There's old information that claims Browserstack only uses simulators – this is false, and Browserstack Live uses real
 devices; although, there are other Browserstack services that can be used with simulators
* Browserstack's devtools are actually just Chrome's devtools from a few years ago, so you won't have the latest 
greatest features
* Sometimes the tunnel enabled by "Resolve all URLs through my network" fails – just stop and start the Browserstack session


## HTTP/SOCKS Proxy 

Browser support: Anything device or browser that allows you to use an HTTP/SOCKS proxy
Capabilities: testing only
Can access hostnames in /etc/hosts: yes 

Basic steps:

1. Start a proxy server on your development machine, like Charles (you must enable proxying)
1. Connect your device and development server to the same network (WiFi)
1. Record your development machine's IP address - use IP of the correct NIC – e.g. WiFi, not Thunderbolt or localhost 
1. Record the port the proxy is running on 
1. Configure the browser or networking on the remote device to use your development machine's proxy
1. Open Chrome / Safari on your remote device and browse as if you were on your development machine

Gotchas:

* Google "http or socks proxy for iOS" or similar for more info on step 5.
* Even on the same network, you may not be able to use your development server's hostname – use the (WiFi) IP instead
* Setting a system-wide proxy may not work - on many mobile OSes it's up to native app developers to support using system proxies


## Simulator

Browser support: Safari (maybe others, but you'll have to install them from app store on the simulator)
Capabilities: testing and debugging
Can access hostnames in /etc/hosts: yes

Basic steps:

1. Install and launch latest version of Xcode
1. Under the Xcode main menu at top of screen, choose "Open Developer Tool", then "Simulator"
1. In the simulator that launches, change to the desired device using the "Hardware" / "Device" menu item
1. Launch browser in simulator and browse as if you were in your desktop browser
1. Connect debugger using your desktop browser's remote debugging functionality

Gotchas:

* Simulators aren't real devices - CPU/memory are based on your development server, and multi-touch / swipe gestures 
aren't accurate


## USB

Browser support: Chrome (Android only?), Safari, Firefox?
Capabilities: testing and debugging
Can access hostnames in /etc/hosts: no 

Basic steps:

1. Connect device via USB
1. Enable remote debugging on device
1. Open Chrome or Safari Technology Preview (enabled developer options in Safari)
1. Use developer tools to initiate remote debugging
1. Optional for Chrome: setup port forwarding to access development server's localhost 

Gothcas:

* Sometimes devices appear and disappear from the Developer menu when using Safari – download the latest Safari 
Technology Preview and try using that
* Chrome can be configured to forward "localhost" and a specific from the remote device to your development server; 
however, things in /etc/hosts won't work


## Tips and tricks


### Access server bound to development server's localhost (127.0.0.1)

See "Optional for Chrome" step under "Debugging over USB"


### Access your development server by IP: 

1. Connect development server to internet via ethernet cable
1. Setup WiFi access point on your development server
1. Connect remote device to development server's WiFi
1. Use development server's WiFi IP address in your browser

