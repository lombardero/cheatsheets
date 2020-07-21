# Shell scripting

* Kernel: it is the first layer of software, creates an initial level of abstraction to talk directly to the hardware. The kernel handles memory, runs processes, and much more. All orders needing hardware will pass by the kernel.
* Shell: the “UI” of Linux. Will take commands and perform tasks. A shell runs in an isolated environment

# 0 - Checking available shells
Check which shell you are currently in:
```
$ echo $0
```

Get the list of available shells:
```
$ cat /etc/shells
```

Check shell associated to each user:
```
$ cat /etc/passwd
```

Check location of binary files for specific command:
```
$ which <command>
```
* Returns path where the binaries of the command are located


# 1 -  Shell scripting
A shell script is an executable file containing multiple shell commands that are executed sequentially. These file contain:
* Info about which shell we are using (always required as the first line of the shell script) `#!/bin/bash`
* Comments (`# this is a comment`)
* Commands (ex: `cp`, `grep`…)
* Statements (`if`, `while`, `for`…)

> Note: a shell script needs to have executable permissions. Command to give executing permissions to everyone: `chmod a+x <filename>`  
> Note2: a shell script can only be called using an absolute path, or using a dot and the relative path

## 1.0 Good practices
It is good practice to start all bash scripts by running the `set` command at the start of the script:
```
set -euo pipefail
```

## 1.1 Basic scripts
### 1.1.0 Basic operators
#### The "pipe": `|`
`|` is one of the most used operators in shell scripting, it takes the standard output from a command and redirects it as the standard input of another. It can be used, for example, to filter results from `ls -la` using `grep`:
```
$ ls -la | grep <keyword>
```
* will output all files in the current folder containing `<keyword>` on its name.


### 1.1.1 Basic syntax
Simple script printing “hello world”. We create a file with `vi`:
```
#!/bin/bash

echo Hello world!
```
* This file can be executed running `./filename`  - or using the absolute path (note: make sure the file has executable permissions activated)

### 1.1.2 Defining variables
Accessing a variable: `$var`
Accessing the exit status of a command: `$?` (ex: if `ping -c1 <ip>` failed, will return 1, else will return zero)

Same script with a variable:
```
#!/bin/bash

a='Hello world!'
echo $a
```
* Prints “hello world”
> Note: single quotes are interpreted as strings, (will not consider the space as a line breaker). This command will not work with double quotes. For single words, we can avoid using quotes at all.  

Getting expressions in variables:
```
#!/bin/bash

a=`hostname`
echo Logged in in $a machine.
```
* The `accents` will treat `hostname` as an executable command, and will query the hostname of the computer (rather than setting a to the “hostname” string).


### 1.1.3 Asking the user’s input
When we want a script to take the user input, we will use the `read <variable>` command, which will set up the user input inside a variable (we then can use it in other parts of the script).

Simple use of `read`:
```
#!/bin/bash

echo Please enter your name
read variable
echo Hello $variable
```
* Script will ask your name and salute you.

## 1.2 Logical statements
### 1.2.1 `If-then` statements
This is the syntax required for an if/then statement:
```
if [ condition ]
then
	<command-if-true>
else
	<command-if-false>
fi
```
* We need to indent the commands, and state the end of the if/then statement with `fi` (opposite of “if”)

List of boolean operators to use in an “if” condition:
	* `-eq` or `==`: check if equals (ex: `$a -eq 10` checks if variable a equals 10, `[ “$a” == y ]` checks if a equals “y” )
	* `-lt` : checks if an expression is “less than” another (ex: `$a -lt 10`)
	* `-e`: checks if something exists (ex: `-e /home/user/file.txt` checks if file exists

Example of a script using if/then:
```
#!/bin/bash

if [ -e /home/manu/file.txt]
then
	echo File exists!
else
	elcho File does not exist
fi
```

### 1.2.2 `for` loop
This is the syntax needed by a `for` statement:
```
for i in <set-of-values>
do
<command>
done
```
* The set of values are values separated by a space such as `1 2 3 4 5` or `cat dog fish bird`
> Note: an improved way of stating a range of numbers is `(1..n)`  
> Note2: we can pass all lines of a file as arguments of a for loop defining doing `for line in $(cat <file>)` (works with absolute paths)  

### 1.2.3 `while` statement
The `while` statement executes a command while a condition holds true.
```
while [ condition ]
do
	<command1>
	<command2>
```

Example of a `while` statement script that counts from 10 to zero then stops:
```
#!/bin/bash

count=0
max=10

while [$count -lt 10 ]
do 
	echo
	echo $num seconds left to stop process $1
	echo
	sleep 1
num=`expr $num - 1`
count=`expr $count +1`
done
echo
echo $1 process stopped
```
* Does a countdown from 10 to 0 then stops
> Note: `$1` will be the name of the process entered right after running the script  
> Note2: The empty `echo` statements will print an empty line  
> Note3: The `expr $variable - 1` reduces the variable value by one unit.  

### 1.2.4 `case` statement scripts
Case statements allow the user to select from a list of options, and performs an action depending on the option selected.
```
echo Explanatory message
	read choices
	case $choices in
<char1>) <command>;;
<char2>) <command>;;
	esac
```
* Will perform an action if the character entered matches any of the `<var>` of the file (use `*` for “any other character”).
* Use `esac` to stop the statement
> Note: the user needs to tap a valid character + “Enter”  


Example:
```
#!/bin/bash
echo
echo Please select one of the options below
echo
echo 'a = Display Date and Time'
echo 'b = List files and directories'
echo 'c = Check system uptime'
echo
	read choice
	case $choices in
a) date;;
b) ls;;
c) uptime;;
*) echo Invalid choice - Bye.
	esac
```

### 1.2.5 Putting everything together

Script to ping one IP address:
```
#!/bin/bash

host="127.0.0.1"
ping -c1 $host &> /dev/null
	if [ $? -eq 0 ]
	then
	echo $host is OK
	else
	echo $host is unreachable
	fi
```
* Script checks if a server responds or not (`$?` returns `0` if no error occurred while running the command).
> Note: redirecting the output to `/dev/null` will run the command without printing the results (otherwise it will show the `stdout`)  

Script to ping multiple IP addresses:
```
#!/bin/bash

iplist="path-to-ip-list"

for ip in $(cat $iplist)
do
	ping -c1 $ip &> /dev/null
	if [ $? -eq 0 ]
	then
	echo $host is OK
	else
	echo $host is unreachable
	fi
done
```
* Verifies all IPs inside the file specified (file must contain one IP address per line)
* `$(cat $iplist)` reads each line of the file as an element of the for loop.

# 2 - Other scripts
## 2.1 Finding files
The `find`  command is a useful tool that allows us to find relative or absolute paths of files and directories.

### Querying files
The basic syntax for the `find` command is:
```
$ find <path> <options>
```
* Will find all objects in the mentioned path, that satisfy the conditions mentioned in the options
* Useful options:
  * `-type`: will filter by file type, `f` for regular file, `d` for directory
  * `-name`: will filter by name, `"<filename>"`. Wildcards such as `*` are very useful for this part of the command.
  * `-iname`: will behave like `-name`  but will ignore uppercase-lowercase differences
  * `-size <int>`: will filter by filesize. Can use with `+` and `-` for "more than" and "less than", and `k` for KB, `M` for MB, and `G` for GB. (ex: `-size +15MB` are files of more than 15MB)
  * `-mmin <int>`: ("modified minutes") will find files that have been modified in the last minutes. Use `+` to indicate "more than", and `-`  for "less than" (ex: `-mmin -10`  are files modified less than 10 min ago). Use two `-mmin` statements to set up a time bracket. Can also use `-amin` for "access minutes" (minutes since last access)
  * `-mtime <int>`: ("modified time") will act like `-mmin` but with days. Can also use `-atime` ("access time")
  * `-empty`: will show only files that are empty
  * `-perm <permission number code>`: filters files by permission type (ex: `-perm 777`)

### Executing commands in filtered files
It is possible to execute a command in all files `find` filters by running the `-exec` option:
```
$ find <path> <options> -exec <command to execute> {} +
```
* executes the selected command in al filtered files
> Note: `{}` is a placeholder for the filename of the file (find will recursively add the file path in this position); this is the place where the name of the file would go if the command was run normally
> Note2: `+` is the "end-of-command" statement; alternatively we can use `\;`.

Example: changing username and group in all files of a directory:
```
$ find test-folder -exec chown paulmccartney:beatles {} +
```
* Takes all files inside "test-folder", and changes its ownership to user "paulmccartney" and to group "beatles"

## 2.2 `xargs`: iterating through stin
`xargs` reads through a list of standard input (separated by blanks), and performs some action. These commands can be run in parallel.

Syntax of the command:
```
$ xargs <options> <command>
```
* takes a list of standard input, and performs some command individually
  * Options:
    * `-P <number of threads>`: paralellizes the operations for each standard input
    * 

