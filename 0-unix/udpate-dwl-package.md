# Updating, downloading packages

# 1 - Downloading packages
## 1.1 Installing packages
In most Linux distributions:
```
$ apt-get install <package-name>
```
* Check if the package is downloaded, if not, will check for the “official” repository (defined in the configuration files), download, and install the package and its dependencies.
	* `-y`: to say “yes” to all yes/no questions

> Note: use `remove` instead of “install” to uninstall the package  

> Note2: to search if a specific package is available, we can use special characters such as `*` to search for package names.  



In RedHat:
```
$ yum install <package-name>
```
* Same as `apt-get` 

## 1.2 Managing packages (only RedHat)
RPM stands for RedHat Package Manager, and is only available in RedHat systems.

Listing all installed packages:
```
$ rpm -qa
```
* Prints out all installed packages (can be combined with `grep` to search for a specific command)
	* `-q`: for “query”
	* `-a`: for “all”

Installing packages downloaded
```
$ rpm -ihv <downloaded-package-path>
```
* Installs the downloaded 
	* `-i`: for “install”
	* `-v`: for verbose

Uninstalling a package:
```
$ rpm -e <package-name>
```
* Uninstalls a package (needs the full name with the version, same as in `rpm -qa`)

Finding configuration file location for a specific package:
```
$ rpm -qc <package-name>
```


# 2 - Upgrading the system
## 2.1 - Installing new upgrades
> Note: To check the current version of Linux we are running we can use `cat /etc/release`  

> Note2: For distribution themselves, it is only possible to update the “minor” version of the distribution (ex: version 7.3 to 7.4) using the `apt-get` or `yum` commands. For the major version (ex: 6 to 7), we need to backup all files and download the whole distribution.  
There are two ways of updating: preserving the old versions of the packages (`update`) or overwriting them (`upgrade`).

Downloading and updating a package without deleting original package:
```
$ apt-get update -y
```
* Updates Linux to the latest version (of the current major version)
	*  `-y`: to say “yes” to all yes/no questions

Downloading and updating a package overwriting the original package:
```
$ yum upgrade -y
```

## 2.2 - Rolling back upgrades
The easiest way of rolling back upgrades is to always create snapshots of the VM before installing a major update. In case of compatibility issues, we roll back.

> Note: it is recommended to do a snapshot before a major update since it is not recommended to do a system downgrade (since many dependencies are installed)  

Otherwise, we can roll back packages:
```
$ yum history undo <package-id>
```
* Undoes everything done by the package, and removes it




