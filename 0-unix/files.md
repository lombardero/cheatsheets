# Files: Creating, moving, reading


# 0 - Get help
```
$ whatis <command>
```
* Shows a small description of what the command does

```
$ <command> --help
```
* Shows some details on how to use the command (options, etc.)

```
$ man <command>
```
* Shows the “manual”, or the complete set of explanations and options to use the command (press space several times to jump through pages)

# 1 - Navigating
```
$ cd <directory-name>
```
* takes us to the requested directory (accepts relative and absolute paths)
> Note: absolute paths start with a `/`  

```
$ pwd
```
* “print working directory

```
$ ls -l
```
* lists all files on the current directory 
* Use `-a` (for “all”) to show all the hidden files
* Use the combined `-tr` (for “time” and “reverse”) to show all files from older to newer
* Use `-i` to show the inode (address) of the file
* Use filenames with wildcards to list all of them (ex: `ls -l *.txt` will list all files with the “txt” extension)

Viewing files one page at a time:
```
$ ls -ltr | more
```
* The `more` command shows the results of the output one page at a time (press space to go to the next page, q to quit)
> Note, the “pipe” (`|`) command allows to add an additional command to the one we just ran. In this example, on top of `ls` we ran `more`.  

```
$ whoami
```
* prints the name of the user



# 2 - Creating and handling files
```
$ touch <filename>
```
* Creates an empty file with the specified name

```
$ cp <original> <copy>
```
* Copies original file (works with both absolute and relative paths)

```
$ mv <initial-path> <final-path>
```
* moves (or renames) a file, works with both absolute and relative paths

```
$ mkdir <directory-name>
```
* creates a new directory (`mkdir` stands for “make directory”)
* `rmdir` can be used to remove it

```
$ rm <file>
```
* Deletes a file
* `-r` (recursive) to delete a directory, or use `rmdir`
* `-f` (force) will forcefully delete stuff


# 3 - Finding files
```
$ find <path> -name "<filename>"
```
* Iterates over the filesystem to locate files; it returns the path to the filename requested. (Slower than `locate`)
* The `<path>`  argument can be absolute or relative.
* Example: `find . -name “file.txt”`
> Note: some directories are only accessible by root  


```
$ locate <filename>
```
* Uses a pre-built database to return the location of the file (searches in the whole filesystem); returns an absolute path. The database needs to be updated for it to work properly
> Note: if no output is show, we can run `updatedb` as a root user  
> Note2: this command needs the `mlocate` package  

# 4 - Wildcards for filenames
These characters can be used to search, list, create or delete files:
* `*` represents zero or more characters
* `?` represents a single unknown character
* `[]` represents a list of unordered characters (contains this character or this other)
* `{n..m}`: represents the range from n to m (integers)

Other wildcards:
* `\` “do not execute next character”, or escape character
* `^`: beginning of a line
* `$`: end of a line

Example: creating 10 files.
```
$ touch file{1...10}.txt
```
* Creates 10 files: (“file1.txt”, … “file10.txt”)

Example: removing all files starting with “file”:
```
$ rm file*
```

Example: listing all files containing the letter c or d on its name
```
$ ls -l *[cd]*
```

# 5 - Reading, modifying files
## 5.1 Redirecting outputs
### The `>` command
Redirecting outputs from the `echo` command is the classic, easy way to add single lines to a file.
```
$ echo "text to be added" > filename.txt
```
* Deletes whatever was in `filename.txt` and replaces it with the text written
> Note: redirecting takes the standard output of a command and writes into a file. In the example, we use `echo`as the source, but we can use any other command.  

```
$ echo "text to be added" >> filename.txt
```
* Appends the text (in a new line) into `filename.txt`

### The `tee` command
`tee` does the same as `>` but also prints what has been added to the file into the screen (redirects stdout to both the terminal and the file)
```
$ echo "text to be added" | tee filename.txt
```
* Performs the same as `>` while printing the result (re-writes file)
* `-a`  (append) option allows us to append the output (same as `>>`)
* `tee` allows us to redirect the output to many files (all arguments)

## 5.2 - Displaying file contents
```
$ cat <filename>
```
* Reads the entire contents of a file in the terminal

```
$ more <filename>
```
* Reads contents of a file in the terminal one line at a time (space to go to next page, q to quit)

```
$ head -10 <filename>
```
* Reads the top 10 lines of the file (can print as much lines as wanted)

```
$ tail -10 <filename>
```
* Reads the bottom 10 lines of the file

## 5.3 Cutting files
```
$ truncate -s <n> <filename>
```
* Keeps the first n bytes of the file (deleting the rest)
> Note: this command can be used to increase the file size too  

## 5.4 Combining and splitting files
Combining files into another one:
```
$ cat file1 file2 > combined-file
```


```
$ split -l <n> <original-file> <new-name>
```
* Takes the contents of the original file, and puts it into smaller files (n lines at a time). The smaller files are called “new-nameaa”, “new-nameab”,…
* Options:
	* `-l` split the file by lines



# 6 - Compressing and un-compressing files
The `tar` command groups a bunch of files together (compressing them a bit( in a container. Once they are grouped, we can zip them (compresses them further( using `gzip`

## 6.1 Taring a file
Taring a file:
```
$ tar cvf <filename.tar> <path>
```
* Groups a list of files into the tar filename specified
* Options used:
	* `-c` creates a new file
	* `-f` writes the new file created
	* `-v` produces a verbose output (lists all files added)
* Example: `tar cvf newfile.tar .`
> Note: the path can be relative or absolute  

Un-taring a file:
```
$ tar xvf <filename.tar>
```
* Un-tars the tar file on the current location
* Options used:
	* `-x` for “extract”

# 6.2 Zipping a file
Compressing:
```
$ gzip <file>
```
* Zips (compresses) the file

Uncompressing:
```
$ gzip -d <file>
```
* Unzips the file
> Note: the `gunzip`  command will do the same thing as `gzip -d`  