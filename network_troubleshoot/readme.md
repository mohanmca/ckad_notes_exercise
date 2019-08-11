# (https://forums.docker.com/t/how-to-access-docker-container-from-another-machine-on-local-network/4737/16)


## Find it’s local ip addresses of docker ssh by running :

```bat
  docker-machine.exe ssh default
  ifconfig
```

```bash
  docker@default:~$ ifconfig | grep "inet "
  inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
  inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
  inet addr:192.168.99.101  Bcast:192.168.99.255  Mask:255.255.255.0
  inet addr:127.0.0.1  Mask:255.0.0.0
```

## On the windows host run powershell as administrator. Find the virtual box interface(s) by running:
ipconfig

```pre
Ethernet adapter VirtualBox Host-Only Network #3:
   Connection-specific DNS Suffix  . :
   Link-local IPv6 Address . . . . . : fe80::e47a:2ea1:af4:581d%8
   IPv4 Address. . . . . . . . . . . : 192.168.99.1
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . :
```

## Locate the windows ip address that matches subnets with the docker machine.
* docker address=192.168.99.101
* windows address=192.168.99.1
* Add a route to the internal docker interface(s) by running
* Find online tool to find the subnet of 10.0.2.15 of address, that is 10.0.2.0

```bat
route add <subnet> MASK <mask range> <windows ip gateway>
route add 10.0.2.0 MASK 255.255.255.0 192.168.99.1
```

## Check the windows host’s route have been forwarded by running
netstat -r

## Ensure connectivity by pinging the docker’s internal address(es).
ping 10.0.2.15
