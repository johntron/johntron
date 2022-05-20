#!/usr/bin/sh

VNC_PORT='5900'

echo "Using wsman from $(which wsman)" 
echo -n "Connect to (IP): "
read IP
echo -n "MEBx password: "
read PASSWORD
echo "VNC password requirements: EXACTLY 8 characters, 1 capital letter, regular letter, digit and special character"
echo "Cannot contain '\"' (double-quote) ',' (comma) or ':' (colon)"
echo -n "Set VNC password: "
read VNC_PWD
echo "Connecting to $IP with password $PASSWORD"
echo "Setting VNC password to $VNC_PWD, port will be $VNC_PORT"
wsman put http://intel.com/wbem/wscim/1/ips-schema/1/IPS_KVMRedirectionSettingData -h $IP -P 16992 -u admin -p ${PASSWORD} -k RFBPassword="${VNC_PWD}" \
  -k Is5900PortEnabled=true \
  -k OptInPolicy=false \
  -k SessionTimeout=0
wsman invoke -a RequestStateChange http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_KVMRedirectionSAP -h ${IP} -P 16992 -u admin -p ${PASSWORD} -k RequestedState=2
echo "Open Linux vnc client. Use \"$IP:$VNC_PORT\" as host and when promoted enter \"$VNC_PWD\" as password"
