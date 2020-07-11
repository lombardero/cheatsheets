# Remote files (SSH, SCP, rsync)


# 1 - Downloading files or apps
Downloading files (used mostly to download files that cannot be downloaded through the `yum` or `apt-get` commands.
```
$ wget <url>
```
* “Www get”, downloads file or app from the world wide web (providing the URL with the file endpoint) and places it in the current folder

# 2 - File transfer protocol (FTP)
The standard network protocol to transfer files (runs on port 21); uses the classic client-server architecture. The receiving service needs to be listening (running the FTP daemon), otherwise the file transfer will fail.

## 2.1 Getting the server side ready (receiver)
To receive a file, the FTP daemon must be installed and running on the receiver machine. (Name of the package: `vsftpd`).

Step1: installing the package 
```
$ apt-get install vsftpd
```
* Installs the required package
> Note: use `yum` in RedHat distributions instead of `apt-get`  

Step2: configuring it (go to `/etc/vsftpd`)
```
$ cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf-old
$ vi /etc/vsftpd/vsftpd.conf
```
* Make a copy of the default config (safety), then edit the file (these options need to be changes/uncommented and added):
```
#change
anonymous_enable=NO

#uncomment
ascii_upload_enable=YES
ascii_download_enable=YES
ftpd_banner=Welcome to blah FTP service.

#add
use_localtime=YES
```
* Disables the option of anyone entering the service, enables uploads and downloads, adds a banner that indicates when the service starts, and adds timezone.

Step3: start or/and enable `vsftpd`
```
$ systemctl start vsftpd
```
* Starts the service (verify it is active running `system status vsftpd`)
* running `systemctl enable vsftpd` will start the service when the system boots
> Note: if `firewalld` is running, we need to allow port 21 to be open  

## 2.2 Getting the client side ready (sending it)
We need to install the FTP service (not the daemon) to send files. Name of the package: `ftp`

Step1: installing the package 
```
$ apt-get install ftp
```
* Installs the required package
> Note: use `yum` in RedHat distributions  

Step2: connect with the server side (receiver)
```
$ ftp <ip-address>
```
* Starts a connection with the receiver (returns the flag we set up). Will require the user password; an ftp session will be open-

Step3: switch to binary mode, ask the system to show the hash of the send progress
```
> bin
> hash
```

Step4: send the file
```
> put <filename>
```


# 3 - SSH
SSH accepts connections through the SSH daemon (a constant running process called `sshd` in Linux that listens to SSH connections by default). Once connected, a terminal will be able to run in a remote machine as if it was running locally.

Connect to a remote machine through ssh:
```
$ ssh remote-username@<remote-IP-address>:<remote-file-absolute-path>
```

> Note: we can block all incoming SSH requests by disabling the `sshd` process: `systemctl stop sshd`; check if process is running: `ps -ef | grep sshd`  

# 4 - Secure transfer protocol (SCP)
Like ”FTP” but “secure”: adds security and authentication. SCP has no port of its own, it uses the same port as SSH (port 22).
> Note: port 22 must be open on the receiver.  

Copying a local file into a remote server:
```
$ scp <local-file-path> username@<remote-IP-address>:<remote-file-absolute-path>
```
* Copies the local file into the remote server.

# 5 - Remote Synchronisation (`rsync`)
`rsync` can transfer and synchronise files from server to another. It is faster than `scp` or `ftp`  and often used for machine backups. The default `rsync` runs on port 22 (the same as SSH and SCP). Install it with `apt-get install rsync`.
> Note: a synchronised file from system A to system B will be transferred first, and all modifications of that file updated subsequently (protocol only sends the ndifferences; ex: original file of 2MB, gets modified to 8MB, `rsync` only sends 6MB).  

Copy files locally:
```
$ rsync -vh <source-path> <destination-path>
```
* Copies a file locally from source to destination (`-z` can also be used).
	* `-v`: verbose output
	* `-h`: human-readable output
	* `-z`: compress the file (useful for slow connections)

Copy files remotely:
```
$ rsync -avz <source-path> <remote-username>@<remote-ip>:<destination-path>
```
* Copies a file locally from source to destination (`-z` can also be used).
	* `-v`: verbose output
	* `-h`: human-readable output
	* `-z`: compress the file (useful for slow connections)
	* `-a`: preserves all info it can (?)

Fetching a file from a remote machine:
```
$ rsync -avzh <remote-username>@<remote-ip>:<source-path> <local-destination-path>
```
* Fetches file from remote source to local destination




