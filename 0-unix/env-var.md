# Environment variables

Formal definition of an env. variable: a dynamic-named value that can affect the way running processes will behave on a computer, and are part of the environment in which a process runs.
	* “dynamic-named”: can be modified by users at any time
	* “environment”: all which affects a script or program’s behaviour

# 1 - Reading environment variables
```sh
$ env
```
* Shows all currently defined environment variables (`printenv` will do the same)

```sh
$ echo $<variable-name>
```
* Shows the value of the environment variable (the `$` accesses the variable)

# 2 - Setting up environment variables
## 2.1 Temporary change
```sh
$ export VARIABLE=<value>
```
* Will set up temporarily the environment variable 
> Note: the change will disappear if the user logs out)  

## 2.2 Permanent change
### 2.2.1 For a specific user
We can change an environment variable permanently for a specific user and type of terminal using a specific file.
For “bash”, for example, we can modify the `.bashrc` file, which is loaded every time a bash terminal boots. It is located in the user’s home folder.
> Note: it is good practice to keep a copy the original `.bashrc` file just in case we break it.  

Changing `.bashrc` file:
```sh
$ cd
$ vi .bashrc
```
* Inside of it, we introduce the following code:
```
VARIABLE='value'
echo VARIABLE
```
> Note: the change made will be available after the terminal session is rebooted (since the file is loaded at the beginning)  

### 2.2.2 Globally
We can add environment variables globally for all users of the machine as well (need to be careful with it).

The same way we modified `.bashrc` we can modify either  `/etc/profile` or `/etc/bashrc`, and add the same lines of code:
```sh
$ vi /etc/profile
```

```sh
$ vi /etc/bashrc
```




