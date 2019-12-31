# UNIX COMMANDS CHEATSHEET

This document lists useful commands to be used while working on a UNIX shell: from basic file and folder navigation, to running processes.


## 1 - Basic navigation
### 1.0 Get help
```<command> --help```
- Will output syntax guidelines to run any command

### 1.1 File and folder navigation
#### Move through folders
```cd <path>```
- cd stands for "change directory", moves to the specified path. Example: `cd /folder` moves to `folder`. Note: use `cd `, and press `Tab` to jump to possible options
- `cd ..` moves to the upwards (or 'preceding') directory

```pwd```
- stands for "Print Working Directory": returns address of current directory

#### Show folder contents
```ls```
- lists current directory contents (prints the filenames)
Options:
- use `ls -l` to output the file details. `-l` stands for 'long' listing format.
- use `ls -a` to print all files (normal files and hidden ones). `-a` stands for 'all'
- use `ls -la` to combine above 

#### Create, Update, Delete
- `rm <directory>/<file>`: deletes (`rm` stands for 'remove') `<file>` in `<directory>` 
- `rm -r <directory>` deletes `<directory>` and its contents. Note: this command needs `-r` (Recursive), since the OS will need to recursively enter every folder and file in the directory to completely erase it.
- `mv <old_directory>/<file> <new_directory>/<file>` moves `<file>` from a directory to another
- `mv <old-file-name> <new-file-name>` renames file
- `mkdir <new-directory-name>` creates a new directory in current path
