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

## 1.1 Basic scripts
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






