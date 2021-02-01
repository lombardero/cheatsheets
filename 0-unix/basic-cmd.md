# UNIX COMMANDS CHEATSHEET

List of UNIX command-line statements:
- [1 - Basic commands](#1---basic-commands): `cd`, `pwd`, `ls`, `rm`, `mv`, `mkdir`, `echo`, `cat`
- [2 - Advanced commands](#2---advanced-commands): `apt-get`, `chmod`
- [Extra: Working with Environment Variables](#3---environment-variables)

# 1 - Basic commands
## 1.0 Get help
```<command> --help```
- Will output syntax guidelines to run any command

## 1.1 File and folder navigation
### Move through folders
```cd <path>```
- cd stands for "change directory"; this command moves the folder the terminal is looking to into to the specified absolute or relative path. Example: `cd /folder` will move to `folder` (which should be inside the folder we are currently looking to).
- `cd ..` moves to the upwards (or 'preceding') directory

Note: in some terminals, typing `cd ` (with a space), and pressing `Tab` allows the terminal to jump between available sub-folders possible options.

```pwd```
- stands for "Print Working Directory": returns the absolute path of the current directory

### Show folder contents
```ls```
- lists current directory contents (prints the filenames)
Options:
- use `ls -l` to output the file details. `-l` stands for 'long' listing format.
- use `ls -a` to print all files (normal files and hidden ones). `-a` stands for 'all'
- use `ls -la` to combine above 

### Create, Update, Delete files and folders
- `rm <directory>/<file>`: deletes (`rm` stands for 'remove') `<file>` in `<directory>` 
- `rm -r <directory>` deletes `<directory>` and its contents. Note: this command needs `-r` (Recursive), since the OS will need to recursively enter every folder and file in the directory to completely erase it.
- `mv <old_directory>/<file> <new_directory>/<file>` moves `<file>` from a directory to another
- `mv <old-file-name> <new-file-name>` renames file
- `mkdir <new-directory-name>` creates a new directory in current path

## 1.2 - Check file contents
### The `cat` command
The command `cat` is one of the most useful commands to quickly check on the terminal the contents of a file. `cat` stands for 'concatenate': the contents of the file will be 'concatenated' and shown in the terminal.

```cat <filename>```
- Prints on the terminal the contents of `<filename>`

Additional arguments we can use for `cat`:
- `cat -n <filename>` will print the contents of the file with a number showing the line number

## 1.3 - Display on the terminal
The command `echo` displays a string directly on the terminal. It can be used to display some statement if something specific happens such as ('Launching application'), or accessing environment variables (env. variables explained [here](#3---environment-variables)).
```echo "This will be displayed on the terminal```
- displays the text above directly on the terminal

## 2 - Advanced commands
### 2.1 - Downloading and updating packages
#### the `apt-get` command
`apt-get` (Advanced Packaging tool) is a command which handles packages in Linux. It retrieves information about packages from the authenticated sources; it allows to install, upgrade and remove packages along with their dependencies (We will use `apt-get` to download Python inside our VM, for example).

```apt-get install <package-name>```
- Downloads and installs the package added from the authenticated source
> Note: we can add `-y` for 'Yes' to let the `apt-get` reply 'Yes' for all `[yes/no]` queries (such as 'are you sure you want to install?').

```apt-get update```
- Checks if there are any updates for the packages installed


### 2.2 - Modifying permissions
#### How do Unix permissions work?
Unix systems have three kinds of permissions for each file: `r` for *Read permissions*, `w` for *Write permissions*, and `x` for *Execute permissions* (permissions can be checked using the `ls -l` command, which will show `-` when a permission is not available). These permissions need to be set for each one of the three types of users defined in a Unix system.

> Note: Unix systems have three kinds of users: 'user' (the owner of the file), 'group' (which is useful when many computers have access to one file), and 'others' (which is any user not on the first two groups).

#### The `chmod` command
The `chmod` (or 'change mode') command allows us to modify the permissions of a file for the three types of users. The easiest way of doing so is by using the three-digit code, which uses a each digit to define the permissions for each type of user.
Each digit is converted into a binary 'mapping' (`1` for 'permission granted' and `0` for 'permission disabled') of the permissions using the `rwx` (read-write-execute) format: for example, `0` is `000` in binary, so it stands for 'none of the permissions granted'; `4` is `100` (or `r--` so 'Only read permission enabled', `7` is `111` so 'All permissions granted'.

That way, `400`, for example, will enable reading permissions for the first type of user (which is the 'user' of the file itself), and disable any permissions for rest ('groups' and 'others'); `777`, as another example, would enable all permissions by all users.

```chmod <three-digit-code> <filename>```
- Modifies the permissions of `<filename>` and sets them to the ones specified on the three digit code. 
> For example, `chmod 400 file.txt` will only enable reading of `file.txt` by the main user, and will not allow groups or others to read it, write it or execute it.

# 3 - Environment variables
'Environment variables' are variables stored in special folders, in order to only reveal its contents locally (on the terminal), and if requested.

Environment variables very useful to store confidential data such as passwords and API keys, which we do not want to reveal in our source code or uploaded in GitHub, for example. They can also be used to run code in different machines, where the value of `HOME` is different, for example.

Note: in Unix systems, global environment variables are stored in the `/etc/environment` folder and user level variables in `.bashrc` and `.profile` files of the user's Home folder.

#### Environment variables to know
- `PATH` is the list of folder paths (separated by `:`) that our terminal will look into to understand the commands we run in the terminal.
- `HOME` is the absolute location of the user's home directory

#### Get list of environment variables
```printenv```
- prints in the terminal the list of currently set environment variables (alternatively, we can use the command `env`)

```set```
- displays the entire list of set or unset values of shell options (environment variables). Gives a much more complete list than  `env`, with all predefined evironment variables (even those that have no value assigned to it)

#### View contents of environment variables
```echo $<environment-variable>```
- Displays the value of the environment variable. Example: `echo $PATH`

Note: the `$` sign is used by Linux to access the value of environment variables

#### Update environment variables
```export <env-variable>=<variable-content>```
- Sets up the contents of an environment variable. Example: `export PATH=$PATH:opt/bin` adds an address to `PATH`.