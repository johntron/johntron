## Technologies

* CoreDNS
* Traefik
* OpenPolicyAgent
* OpenFaaS
* CIS Benchmark
* k9scli.io


## Install

```
(cd metallb && helm upgrade --install metallb bitnami/metallb -f chart/values.yaml)
(cd coredns && helm upgrade --install coredns coredns/coredns -f chart/values.yaml)
(cd gocd && helm upgrade --install gocd gocd/gocd -f chart/values.yaml)
```

Also install the thing for local persistent volume claims (Host Path / local-path-provisioner)

## Uninstall

```
helm uninstall metallb gocd coredns
```

# Intel AMT

If the hardware supports it, you can use Intel AMT for remote out-of-band management over IP; however, you must enable it first. Note: Intel AMT is supported by the always-on Intel Management Engine (ME); AMT is the part that allows *remote* administration.

To enable:

* Figure out how to get into Intel MEBx settings during BIOS/UEFI boot - you'll need this later; For me, I had to hit ESC - using ctrl-P didn't work
* Find BIOS setting to unprovision Intel ME
* Save and exit
* Use keystroke to enter Intel MEBx
* Choose the login option
* Set a new password - google to see what the password requirments are, because the error message for an insecure/invalid password is ambiguous
* Now navigate the menu to find the setting to enable network configuration
* Optionally, change from DHCP to static
* Find the option to enable KVM, SOL, etc. - enable whichever
* Find the option for user consent - select "none"; otherwise, you'll be asked to enter a code visible on the physical device when you try to remotely manage
* Exit - this saves the settings

Now you can figure out the IP of the machine and visit http://$IP:16992 in your browser - login with the same password you created above. You should be able to do basic things now like reboot, view status, etc.

For KVM over IP, there are additional steps:

* Install wsmancli
* Run (./enable-kvm.sh) - *WARNING* Be sure you read the part about password requirments when setting VNC password
* Launch a VNC viewer like noVNC:
  * novnc --vnc $IP:5900
  * google-chrome --app="http://localhost:6080/vnc.html?host=johntron-linux&port=6080"
* Connect to the machine using the password you created when running enable-kvm.sh


# High-availability Kubernetes homelab

![][diagram]

Next:
* How to provision distributed storage?
* How to provision control-plane and worker nodes?
* How to provision etcd?
  * On pi's?
  * On x86s?

[diagram]: docs/diagrams/output/kubernetes-high-availability-homelab-0.png
