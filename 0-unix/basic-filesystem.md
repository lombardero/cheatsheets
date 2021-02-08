# Filesystem, Links


# 1 - Basic structure
Here is a description of all basic directories:
* `/boot`: contains all the files needed for the system to boot. When it starts, it looks for a hardcoded file (ex: file `grub.cfg` tells the system which OS to boot).
* `/root`: the home directory of the root user (not to be confused with the ‘/‘ directory)
* `/dev`: system devices, all devices (ex: keyboard, mouse, etc) will be a file inside this directory
* `/etc`: configuration files of applications that are built on top of linux, or that come with linux (mail, etc). Important to do a backup of the folder before touching any config file
* `/bin` (link to `/usr/bin`): contains the binaries for everyday user commands
*  `/sbin` (link to `/usr/sbin`): contains binaries for system commands
* `/opt`: optional add-on applications (not part of OS).
* `/proc`: folder storing files (created by the kernel) for each running program (when it computer starts, it should be empty)
* `/lib` (now points to `/usr/lib`) stores C programming library files needed by commands and apps (ex: `cd` and `pwd` use some C libraries)
* `/tmp`: contains all temporary files 
* `/home`: directory for user (each user has a directory inside “home”
* `/var`: where the system stores its logs (error logs, etc.)
* `/run`: stores temporary runtime files (ex: PID files) used by system daemons that start very early 
* `/mnt`: used to mount external filesystems
* `/media`: used for cdroms (ex: if you mount a virtual ISO image, it will show in this folder)

# 2 - File attributes
## 2.1 - File types
When the command `ls -l`  is run, a list of attributes is displayed for each file:
1. Type (ex: `drwxrwxrwx`), there are seven file types:
	* `d`: directory
	* `l`: link
	* `-` regular file
	* `c`: special file or device file (ex: keyboard)
	* `s`: socket
	* `p`: named pipe
	* `b`: block device
2. Number of links associated to that file
3. Owner of the directory
4. Group of the directory
5. Size
6. Month / Day / Time
7. Name

## 2.2 Pointers
`inode` is the pointer to a file on the hard disk, the computer associates names of files with the inode (address) where the file lives. The file name is a pointer. In linux, we can create two types of additional pointers to it (like shortcuts):
* Soft Link: will be deleted if file is renamed, moved or deleted (the soft link points to the name of the file)
* Hard Link: deleting, renaming or moving the original file will not affect it (the hard link points to the `inode` of the file itself). Names are hard links.

### Creating links
Links should be created on the `/tmp` folder:

Creating the link
```sh
$ ln -s <absolute-file-path>
```
* Creates a link to the file in the absolute path. By default, the link will have the same name as the file; now the file can be accessed through the link directly
* `-s` stands for “soft” (remove it to create a hard link)
> Note: soft links are just pointers, while hard links behave like a “copy” of the file (can interact with it even if the file is gone)  