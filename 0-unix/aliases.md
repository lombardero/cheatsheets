# Aliases


# 1 - Managing aliases (session)
## 1.1 Defining aliases
Aliases are shortcuts that we can define to avoid typing long commands.
> Note: defining aliases with this method will only be saved for the current session (when the user logs out, it is lost)  
```sh
$ alias l="ls -la"
```
* Will now run `ls -la` every time we run `l` on the terminal
> Note: we can use alias for several commands at a time separating them with a `;`  
> Note2: we will need to add a backslash before all executable characters (ex: `awk ’{print $6}’` becomes `awk ’{print \$6}’` (since the dollar sign indicates a variable to be accessed, and in this case, we are storing a string - that will be executed when the alias is run)  

We can also view all defined aliases:
```sh
$ alias
```
* Shows all aliases defined (the system ones and the user ones)

## 1.2 Deleting aliases

```sh
$ unalias <alias>
```
* Deletes the alias (ex: an `alias l="ls -la"` is deleted using `unalias l`

# 2 - Creating permanent aliases
## 2.1 Creating user aliases
In order to create user-specific command aliases we must modify (`vi`) the `.bashrc` file of the user (the one that gets loaded every time the terminal is booted). The file is found in `/home/user/.bashrc`

On that file, we add:
```sh
alias name="command"
```
> Note: we need to reboot the terminal to see the changes   

## 2.1 Creating global aliases
For global aliases, we need to modify the global `bashrc`file, which is located in the following path:  `/etc/bashrc`  (we need to be root to do it)

