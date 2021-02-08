# System maintenance (logs, rebooting, etc.)

# 1 - Logs
## 1.1 Logs locations
By default, all the logs in Linux systems are stored in the `/var/log` folder. Inside it, we can run `ls -l | more` or `ll | more` to see all stored logs.

We can then look at  the following files (`more <filename>` recommended since the files are large):
	*  `messages`: most important file, used to check what happened. Contains all the information about the processes: which application and user ran it, etc. `grep -i error messages` Will print all errors of the system.
	* `boot.log`: these are the logs relating to the system booting. This file is overwritten every time to system is booted. We must be “root” to read it. 
	* `chrony`: placement of NTP (network time protocol) service - synchronises clocks to allow packet delivery
	* `cron`: all the logs of jobs that are scheduled (see `crontab` command)
	* `maillog`: all e-mail related logs are stored in this file
	* `secure`: all log-ins log-outs of the system (with machines, etc) `tail -f secure` will show us the latest activity in real time.
	* `httpd`:
	* `dmesg`: gives info about hardware

## 1.2 SOS report
Used by RedHat and CentOS to collect and package diagnostic data (when something goes wrong). Name of the package: `sos-version`

Getting the report (needs root access):
```sh
$ sosreport
```
* Will create a SOS report and save it in `/var/tmp/sos.<smth>`. The package scans all logs (system, errors, kernel…) and provides a diagnostic report.

# 2 - Shell history
We can view the list of shell commands run in the machine.
> Note: all ran commands are stored in the file `/home/username/.bash_history`  
```sh
$ history
```
* Returns the list of scripts run (the bash history) by the current user in the current user session, giving a number to each one (can be used with `grep` to find keywords)

Once `history` has been run (and we know the id of each script), we can re-run that command by entering the id:
```sh
$ !<command-id>
```
* Runs that command (id is given by `history`, ex: `!407`)


# 3 - System maintenance commands
```sh
$ shutdown
```
* Shuts down the current machine (note: check it is the right machine with `hostname`)
	* `-r`: reboots it
	* `-H`: halts it

```sh
$ reboot
```
* Reboots the machine (if ssh’d, wait some time to re-connect)

(Not sure of what this does)
```sh
$ init <run-level>
```
* Starts the `init` process (one of the last steps the kernel calls in the boot sequence -> Looks for the file in `/etc/inittab`)
* Examples:
	* `init 0` : reboots the machine

