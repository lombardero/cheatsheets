# System utilities (date, hostname)

# 1 - Getting basic info
## Hostname
Checking the hostname:
```sh
$ hostname
```
* displays the hostname (name given to the server)
> Note: the hostname info is in the `/etc/hostname` file  

Changing the hostname (needs to be root)
```sh
$ hostnamectl set-hostname <new-hostname>
```
* Changes the hostname to the newly specified one. Note that we can change the hostname modifying the `/etc/hostname` file)
> Note: the machine needs to reboot to see the changes affected  

## Getting hardware info
```sh
$ sudo dmidecode
```
* Will print info about the hardware

```sh
$ sudo fdisk
```
* Displays size of disk with all partitions

```sh
$ arch
```
* “Architecture” tells if machine uses 32-bit or a 64-bit CPU.

## Getting OS info
```sh
$ uname -a
```
* Returns the OS name, the hostname, the distribution version, the date, bits used…

# 2 - Other utilities

## Date and time
```sh
$ date
```
* displays the current date up to the seconds
	* `-s`: sets up the current date and time

```sh
$ uptime
```
* tells for how long the system has been running,  how many users have logged in, and the load averages

```sh
$ uname
```
* returns the linux distribution
	* `-a` to get more info

```sh
$ which <command>
```
* returns the location where the binary of the command is located

```sh
$ cal
```
* returns the calendar of the current month
* can be used with a year to display all the months of those years

```sh
$ bc
```
* opens a basic calculator


