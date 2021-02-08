# NIC Bonding

NIC bonding is a way to increase the available bandwidth of an interface in Linux. Example: we use two 1 GBps interfaces to get 2 GBps. This also adds redundancy, allowing the connection to remain present if one of the sources fails.

This procedure can be done with any real adapter of the system.

Step 1: install the bonding driver
```sh
$ modprobe bonding
```
And get info about it:
```sh
$ modinfo bonding
```

Step 2: create the new interface file (bonding the interfaces we want to “join”) adding some parameters
```sh
$ vi /etc/sysconfig/network-scripts/ifcfg-bond0
```
Contents of the file:
```sh
DEVICE=bond0
TYPE=Bond
NAME=bond0
BONDING_MASTER=yes
BOOTPROTO=none
ONBOOT=yes
IPADDRESS=...
NETMASK=...
GATEWAY=...
BONDING_OPTS="mode=5 miimon=100"
```
* `BOOTPROTO` can be `none` (same as `static` ), or `dhcp`
* `ONBOOT` enables start of the boot 
* `miimon`  specifies the MII link monitoring frequency in ms (how often each interface is inspected for failures)


Step3: we edit the interface files we want to join, and point both files to the newly created one
```sh
$ vi /etc/sysconfig/network-scripts/<interface1>
$ vi /etc/sysconfig/network-scripts/<interface2>
```
Delete the contents, and modify them by this:
```sh
TYPE=Ethernet
BOOTPROTO=none
DEVICE=<name>
ONBOOT=yes
HWADDR=<mac-addr>
MASTER=bond0
SLAVE=yes
```
* The mac address can be found using `ifconfig`

Step4: restart network to see the changes
```sh
$ systemctl restart network
```

Bonus: verify the configuration with `ifconfig` and verifying the bonding file:
```sh
$ cat /proc/net/bonding/<bond-name>
```
