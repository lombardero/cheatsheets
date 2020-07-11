# System utilities (date, hostname)

# 1 - Getting basic info
## 1.1 Hostname
Checking the hostname:
```
$ hostname
```
* displays the hostname (name given to the server)
> Note: the hostname info is in the `/etc/hostname` file  

Changing the hostname (needs to be root)
```
$ hostnamectl set-hostname <new-hostname>
```
* Changes the hostname to the newly specified one. Note that we can change the hostname modifying the `/etc/hostname` file)
> Note: the machine needs to reboot to see the changes affected  


## 1.2 Other utilities
```
$ date
```
* displays the current date up to the seconds
	* `-s`: sets up the current date and time

```
$ uptime
```
* tells for how long the system has been running,  how many users have logged in, and the load averages

```
$ uname
```
* returns the linux distribution
	* `-a` to get more info

```
$ which <command>
```
* returns the location where the binary of the command is located

```
$ cal
```
* returns the calendar of the current month
* can be used with a year to display all the months of those years

```
$ bc
```
* opens a basic calculator


