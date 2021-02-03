# Networking

# 1 - Basics
## 1.0 Basic concepts
* IP address: the unique number identifying the machine’s address on the network
* Subnet mask: the number specifying how many IP addresses an entity (such as a company) can get. ex: `255.255.255.0`
* Gateway: the direct point of entry and exit of networking packets (ex: the router).
* Static IP vs DHCP: in the static model, you need to specify an IP for your computer, and that will remain the same. In the DHCP model, the IP will be taken “randomly” from a pool of free IPs (changes every time the machine boots)
* Interface: the ethernet port or the wifi chip of the laptop (will always have a MAC address)

* Types of connections for VMS:
	* Bridged connection: the VM, through a “bridge” in the Host OS, will request an IP to the network as if it were a computer (so that it can connect to the internet).

## 1.1 Networking files in Linux
List of relevant networking configuration files in Linux:
* `/etc/nsswitch.conf`: lists the locations for the configuration files (ex: `hosts: files dns myhostname` means the host information is in `/etc/files`, if you cannot find it then go to `/etc/dns`, etc)
* `/etc/hosts`: this file is where we define aliases for IP addresses; for example: `localhost` is defined over there. Kind of like a “local DNS”.
* `/etc/sysconfig/network`: this file can be used to change some configurations (?)
* `/etc/sysconfig/network-scripts`: folder that contains all networking options (including a file that is the network interface itself - everything is a file in Linux).
	* `/etc/sysconfig/network-scripts/ifcfg-<name-interface>`: contains the configuration of the currently used network interface, such as the boot protocol (DHCP), the type, etc.
* `/etc/ressolv.conf`: specifies the IP of the DNS server that we are using


# 2 - Networking commands
## 2.1 Network interfaces
### 2.1.1 Getting interface information
NIC (Network Interface Card) is the name given to the card managing a network interface in Linux. On Linux, several network interfaces are set up (wireless, ethernet, etc.), each one has a specific name.

To list all the available interfaces we use:
```
$ ifconfig
```
* Returns the list of interfaces of the system (wireless, ethernet, etc.), with the current IP and current use of them:
	* `enp0` or `en0`: the main connection (used to be “ethernet”, but the wireless ones pass through it too)
	* `lo`: stands for loopback device (set up for localhost)
	* `virb0`: stands for “virtual bridge”, and is used for NAT (Network Address Translation) for VMs that have a bridge connection
	* (different distributions have different interface names)
* Alternatively (if this command does not work), we can use `ip a` or `ip addr` (which works in other distributions such as RedHat. 

To get more detailed info about each interface (useful for the “main” one only):
```
$ ethtool <interface-name>
```
* Returns the amount of traffic the connection supports, if it is Duplex (?) or not, and if it is down or not

### 2.1.2 Getting traffic info
Listing the current flows:
```
$ netstat
```
* Displays open network connections, useful uses `-rnv`
	* `-r`: show the routing tables (combined with `-a` shows all protocols using them, combined with `-s` the network statistics)
	* `-n`: show network addresses as numbers (ip)
	* `-a`: display all used sockets
	* `-t`: displays only TCP connections (`-at` useful)
	* `-u`: displays only TCP connections (`-au` useful)
	* `-v`: verbose

### 2.1.3 Getting all incoming traffic
```
$ tcpdump -i <interface-name>
```
* Lists all real-time incoming traffic coming through the interface mentioned
	* `-i`: interface name

### 2.1.4 Enabling/Disabling interfaces
```
$ ifup <interface-name>
```
* Enables the interface

```
$ ifdown <interface-name>
```
* Disables the interface

## 2.2 pinging servers
```
$ ping <IP-address-or-URL>
```
* Will return `64-bytes` every second (or something similar) from the remote server.
	* `c<n>`: stops after receiving n responses back from the remote servers (ex: `-c1` will wait one response back, then stop)
> Note: `ping` can also be used to see if a specific IP is taken on the network (if no response comes back, the IP is free)  

## 2.3 Sending requests to websites
```
$ curl <url>
```
* By default, will do a GET request to the URL specified, and print out the HTML received.
	* `-O`: will download the file in the URL (same as `wget`),
	* `-d`: sends a POST request.
	* `data <data>`: sends a POST request with the data specified

# 3 - The DNS package
The DNS package allows us to create a private DNS server with shortcuts that allow us to access different servers within a local environment. Here is how we run it.

Step1: installing the packages needed
```
$ apt-get install bind bind-utils -y
```

Step2: edit the package’s configuration file `/etc/named.conf`
```
$ vi /etc/named.conf
```
Add the IP of the right interface on the list of IPs listening on port 53 (default port)
```
listen-on port 53 { 127.0.0.1; <new-ip>; };
```
 (check remaining steps on Udemy, lesson 138).


# 4 - Synchronising servers
## 4.1 The `ntp` package
This package allows us to synchronize server clocks, it gets the time from a central server. Google is a server that can be used (IP: 8.8.8.8). Install with `apt-get install ntp`. Runs on port 123.

* Step1: enter the right IP addresses in the `/etc/ntp.conf` file
* Step2: tart the daemon: `systemctl start ntpd`

Now we can run the commands:
```
$ ntpq 
```
* Will show the servers from which we are getting the time

## 4.2 The `chronyd` package
`chronyd` is a more modern version of `ntp`. Works the same way as the latter one.

# 5 - Other network utilities
## 5.1 - Checking hostnames/IP
```
$ nslookup <URL-or-IP>
```
* Will return the page corresponding to the IP and the opposite.

```
$ dig <URL-or-IP>
```
* Returns a more detailed description






