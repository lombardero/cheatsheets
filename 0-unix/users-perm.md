# Users, permissions


# 1 - Managing users
## 1.1 Users vs Groups
In Linux systems there are users, and groups. A file can be owned by one user and one group.  If no groups have been defined, the group associated to the file will be the name of the user that owns it (default).

They both affect the permissions that each user has for each file (or directory). 

### Permissions in linux systems
`root` is a special user that owns all the basic folders (`/etc`, `/bin`…). Therefore only him can delete or modify the files in these folders. Regular users own their home directories only (can write files there).
> Note: if a user has `rwx` permissions on a directory it can delete and modify all the files inside of it even it does not own it. (Users control the contents of the directories they own).  

### Access Control List (ACL)
ACL is a layer that runs on top of permissions that allow us to give certain permissions to certain users without having to include them in a group.
> Note: a file with ACL permissions set up will show a “+” sign when listed  
> Note2: setting up ACL permissions does not allow to delete files  

Get the ACL permissions:
```
$ getfacl </path/to/file>
```

To set a permission for a user (the owner of the file must change it)
```
$ setfacl -m u:<user>:<rwx> </path/to/file>
```
* use `setfacl -x u:<user> </path/to/file>` to remove a user from the ACL

Setting a permission for a specific group:
```
$ setfacl -m g:<group>:<rwx> </path/to/file>
```

Enable all files in a directory to inherit all ACL permissions of the directory:
```
setfacl -rm "entry" </path/to/dir>
```
* `-r` for recursive

Remove all entries in the ACL:
```
setfacl -b </path/to/file>
```

## 1.2 Root privileges
Become root user
```
$ su -
```
* command for becoming a superuser
* Run `exit` to logout

Execute a command as “root”:
```
$ sudo <command>
```

Edit superuser privileges (run the command as root):
```
$ visudo
```
* Opens the editor of the file `/etc/sudoers`, which defines the superuser privileges (can add any users to perform any root commands -> need to add: `username  ALL=(ALL)   ALL` in the line where it says “Allow root to run any commands anywhere (below root itself) to allow the user have superuser privileges (not recommended). This file also mentions which groups have root privileges


## 1.2 Changing password
Change password of the current user:
```
$ passwd
```
* Asks for the old password, and asks for new password two times.
* As root, we can change the password of any user running `passwd <username>`

Changing the “root” password (or getting root password if lost).
	* Step 1: rebooting the machine
```
$ reboot
```

	* Step2: once rebooted, we select “e” in the restart menu (will offer to launch normally or a saved-up rescue version, we select the normal one and press “e” to edit it)
	
	* Step 3: we modify some lines of code (go to Udemy course, lesson 99 and check) to start computer in single user mode
	
	* Step 4: run the following commands to reset a password for root
```
$ chroot /sysroot
$ passwd root
```

	* Step 5: we run `exit` then `reboot` again

## 1.3 User Account Management
Users and groups get stored in three files: 
	* `/etc/passwd` (list of user settings)
	* `/etc/group` (list of group names with users associated to it)
	* `/etc/shadow` (stores the hashes of user passwords)

We can verify the users created by going into the `/home` folder and looking at the folder names there (should match users)

Example:
```
$ grep <groupname> /etc/group
```
* Will tell us which usernames are inside the group


### 1.3.1 Managing users
#### Creating a user
Note: only `root` can create users.
```
$ useradd <name>
```
* Creates a new user with the specified name
	* `-g` specifies a group name (otherwise creates a group with same name as the user)
	* `-s` specifies the shell to be used
	* `-c` adds a user description

```
$ useradd -g <group-name> -s /bin/bash -c "user description -m -d /home/<username> <username>
```
* Creates a user inside a group, defines the shell to be used, gives a description, defines a home directory and gives it a name

Verify if user has been created:
```
$ id <username>
```
* Will return the user id as well as the group it belongs to

#### Changing user password
```
$ passwd <username>
```
* Changed the password for the user


#### Deleting users
```
$ userdel <username>
```
* Deletes the user
	* `-r` deletes the user home directory as well

#### Changing user settings
Changing the group the user belongs to:
```
$ usermod -G <old-group> <new-group>
```
> Note: if user had a group (its own name), the user will still be part of its own group, and the new one; therefore, the groups of files that he created might not change. We will need to use `chgrp` for that.  
	* `-a` append (add a new user or group)
	* `-G` group


### 1.3.2 Managing groups
Creating a group
```
$ groupadd <groupname>
```
* Creates a new, empty group

Deleting a group:
```
$ groupdel <groupname>
```

Modifying a group:
```
$ chgrp -R <old-group> <new-group>
```
* Changes the files in the old group to the new
	* `-R` cascades the changes through all the files affected by the change
> Note: this command is useful when users belonged to their own group only.  


# 2 - File permissions
## 2.1 Basic permissions
There are three types of permissions for a file:
	* `r`: read
	* `w`: write
	* `x` execute (in case it is a script or an executable file)
> Note: to access a directory, we require `x` permission  

There are three kinds of users for the file:
	* `u`: the owner of the file (the one who created it)
	* `g`: users from the same user group as the creator
	* `o`: all other users

## 2.2 - the `chmod` command
Changing permissions
```
$ chmod <code> <filename>
```
* `<code>` can have multiple formats:
	* `<user>-<permission>` removes a permission(s) for a user type (use `a` for all users, or `u`, `g`, `o` for specific ones)
	ex: `chmod g-rw file.txt`
	* `<user>+<permission>` adds  permission(s) for a user type
	* `<number-code>`: one value for each type of user permission (`ugo`:
		* `0`: no permission
		* `1`: execute
		* `2`: write
		* `3`: execute + write
		* `4`: read
		* `5`: read + execute
		* `6`: read + write
		* `7`: read + write + execute

## 2.3 File ownerships
Files belong to a certain user, and to a group.

We can change the group it belongs and the owner with the following commands:
```
$ chown <username> <filename>
```
* changes the ownership of a file
* add `-r` to change recursively all the ownerships of files inside of a directory
* Can use `chown <user>:<group> <filename>` to change both group and owner of the file.

```
$ chgrp <username> <filename>
```

# 3 - Monitoring users
Check who is currently logged in
```
$ who
```
* Returns user id, terminal id and the time they logged it (useful to see why a machine has a high load)

```
$ w
```
* Gives more info than `who` (idle time, cpu usage…)


```
$ last
```
* Returns a list of the last things that happened to she system (logins, reboots, etc) - useful for troubleshooting
* Ex: use `last | awk ‘{print $1}’ | sort | uniq` to print the list of users that logged in

```
$ finger
```
* Tracks users (needs to be installed)

# 4 - Real-time messaging to users
```
$ wall
```
* Enters the `wall` mode, which allows you to send a message to all logged in users

```
$ write <username>
```
* Enters a writing mode that will send a message to a specific user (under the scenes, root is the ones who sends the message) 