# Processes: Managing, Scheduling and Monitoring


# 0 - Basic definitions
* Application: a program that is installed in the machine and can run processes
* Script: some text written in a file as a list of instructions that the computer will execute. Applications can run scripts on the background.
* Process: executable task that takes use of the CPU (can be launched by application). It runs for a while then stops (runs until it is interrupted).
* Daemon: a process that continuously runs “on the background”, listening to incoming traffic and performing some actions.
* Thread: a single process can have multiple threads, it is a linear set of operations.
* Job: a job is a scheduled process that will be run at a point in time (once the CPU is free, or at after some event).

# 1 - Processes
## 1.1 - Checking status
Checking running processes:
```sh
$ ps
```
* Shows currently running processes (useful command: `ps -ef | grep <process>` to display specific info)
	* `-e`: (same as `-A`) shows all processes
	* `-f`: displays process id, CPU usage, and some other info
> Note: when using `grep` to find info, `grep` is a process itself, so if we are looking for a specific program we need to ignore the `grep` process itself.  

```sh
$ jobs
```
* Will output the processes that are running in the background

Checking resources consumed by processes:
```sh
$ top
```
* Shows currently running processes ordered (in real time) by the ones using more resources (also shows resources being used). Also lists overall usage of resources.


## 1.2 Managing processes
## 1.2.1 Creating and killing processes
Generic managing tool for applications:
```sh
$ systemctl <action> <application>
```
* Performs the action requested to the application selected
* Old version: `service`
	* Actions: 
		* `restart`: restarts the app
		* `status`: returns info about the current state of the app (running, not running, etc)
		* `stop`: stops the app
		* `enable`: sets up an application to start every time the system boots

```sh
$ kill <process-id>
```
* Stops process with the id (same as running `systemctl stop <process-name>`
> Note: a process consuming 99% of one of the resources is a good candidate for killing (check with the `top`  command).  

```sh
$ pkill <process-name>
```
* stops a process giving its name

## 1.2.2 Background / foreground
```sh
$ jobs
```
* Will output the processes that are running in the background

```sh
$ bg
```
* Will run in the background the latest stopped job.

```sh
$ fg
```
* Will bring to the foreground the last process sent to the background

Keep a process running even if the terminal closes:
```sh
$ nohup <command>
```
* `nohup` runs processes on the background, detaching them from terminals (so terminals can be closed but the command still runs).

> Note: without `nohup`, processes, even those running on the background are attached to the terminal sessions that called them.  

> Note2: `nohup`  creates a file called `nohup.out` with all outputs the process gave  

Running a `nohup` process without keeping input and output:
```sh
$ nohup <command> > /dev/null 2>&1 &
```
* Redirects all outputs to “black hole” directory  `/dev/null` (deletes it). `2>&1` redirects all standard error as standard output (so it can also be redirected to `/dev/null`)

> Note:  Why  `2>&1`? In linux, `1` indicates standard output `stdout`, and `2` indicates standard error `stderr`. The `&` is to indicate that `1` is a file indicator and not a new file (without it, Linux would create a file called `1` and output all `stderr`there).  

## 1.2.3 Prioritising processes
```sh
$ sleep <secs>
```
* Terminal will not accept inputs for the number of seconds asked

Prioritising processes:
```sh
$ nice -n <priority> <command>
```
* Specifies a priority to the command run (note: priority is a number from `-20`(super urgent) to `19`(not urgent at all)


## 1.3 Scheduling processes
Linux can schedule hourly, daily, weekly and monthly recurrent tasks (or jobs). In fact, by default, Linux systems already have some of these jobs predefined. These are set up in the directories  `/etc/cron.___`. We can add the jobs we want in those directories (`cron.hourly` for all hourly jobs, for example), or we can schedule it using the `crontab` command.

### 1.3.1 Scheduling cron jobs in the `/etc` folder
All the jobs to be run regularly (hourly, daily, weekly or monthly) find themselves (the scripts) inside the `/etc/cron.__` folder.

To find the folders:
```sh
$ cd /etc
$ ls -l | grep cron
```
> Note: the scripts that will run regularly are inside these folders  

The timing for the hourly jobs can be found in the folder `/etc/cron.d/0hourly`, while the rest of timings are in `/etc/anacrontab` (shows what time exactly daily, weekly and monthly jobs run).
> Note: timings are shown in the following format (we put a `*` to indicate “all” (ex: hourly script running one minute passed the hour `01 * * * *`):  
``` 
Minute Hour Day Week Month
```

### 1.3.2 Scheduling using `crontab`
```sh
$ crontab -e
```
* Enters the “edit” mode of the command (like doing `vi` on an empty file). Inside the file, we can specify a list of linux commands to perform at certain times.
* Format:
```sh
<minute> <hour> <day> <month> <day-of-week>  <command to be run>
```

 Example:
```sh
22 13 * 3 * "my first crontab" >crontab-entry
```
* Will execute the command every day (`*`) of the month of march (`3`), at 13h22 min

> Note: the `crontab` command will schedule jobs and save it in the `crontab` directory inside the `/etc` folder.  

# 2 - Monitoring
```sh
$ top
```
* Shows the running processes by top usage of the resources, as well as the total resources being used

```sh
$ df
```
* Returns the disk partition (how much are the different parts of the disk used)
	* `-h`: returns more human-readable figures (in GB)

```sh
$ du
```
* Returns the list of files of the computer, and its use of resources

```sh
$ dmesg
```
* Shows the list of system-related outputs, warnings or error (long list so might use `| more` to show one page at a time)

```sh
$ iostat
```
* “input and output statistics”: how much is the disk read and written
	* `iostat 1` will print real-time data

```sh
$ netstat
```
* Shows the network status (shows all processes establishing network connections, )
	* Useful command `netstat -rnv` (shows gateway info, subnet mask, etc.)
	* `-r`: displays the kernel routing tables
	* `-n`: shows numerical addresses
	* `-v`: verbose

```sh
$ free
```
* Shows the used and free space on the virtual memory (RAM), and the swap space

```sh
$ cat /proc/cpuinfo
```
* Gets the CPU specifications

```sh
$ cat /proc/meminfo
```
* Gets the RAM specifications
