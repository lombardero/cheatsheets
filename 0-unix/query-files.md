# Files: Querying & searching


> Note: all these commands can be used  with a pipe `|` to treat the output of a command directly.  

# 1 - Selecting data
## 1.1 - The `cut` command
Cut allows to display part of the output separated by delimiter, position, or characters
```
$ cut -cn-m <filename> 
```
* Lists the n to m characters of each line
* `-cn,m` lists the characters n and m (can use any combination of those
* `bn-m` can be used to cut by number of bytes (rather than characters)

```
$ cut -d<delimiter> -f <n> <filename> 
```
* Cuts the file using the delimiter sign requested, and gets the nth field following that 
* Example: `cut -d: -f 6 /etc/passwd`  will read each line, separate it by “:”, and get the 6th element (starting at 1). The line `manu:x:1000:1000:Manuel:/home/manu` will output `/home/manu`)

> Note: cut can be also used with other commands such as `ls -l | cut c2-4`  

## 1.2 - Extracting data with `awk`
`awk` extracts data from files or outputs

Extracting single columns:
```
$ awk '{print $1}' <filename>
```
* Prints the first column of each line (column= text field divided by space)
* `-F<symbol>` uses another symbol as a column separator
*  `$NF` prints the last column, `NF` is the number of columns (can be used to print the number of columns of each line using `print NF`
* We can also use `awk '{print $1,$3}' <filename>` to print multiple columns

> Note: again, `awk` can be used with commands such as `ls -l ‘{print $1,$3}’`  


Extracting lines that contain specific characters:
```
$ awk '/keyword/ {print}' <filename>
```
* Prints only the lines on the file where the keyword appears

Getting lines with more than X characters:
```
$ awk 'length($0) > 15' <filename>
```
* Returns lines with more than 15 characters

Replacing a keyword with another in a file:
```
$ cat <file> | awk '{$2="name"; print $0}'
```
* Takes the second element on each line and replaces it by the string we asked for (in this case, “name”). Awk understands: “take the second element of what you read, set it up to “name”, and print everything”.

## 1.3 - The `grep` command
Stands for “global regular expression print”. It processes text line by line and prints any lines matching a specific pattern. (Kind of like a search feature)

```
$ grep <keyword> <file>
```
* Will return the lines of the file containing the keyword
	* `-c` returns the number of times the keyword appears in the file
	* `-i`  searches for the keyword not caring of caps or lower case
	* `-n` returns the line numbers where the keyword appears
	* `-v` returns all lines NOT containing the keyword

> Note: can be combined with other commands to find specific lines  

We can also use `egrep` to search for multiple keywords:
```
$ egrep "keyword1|keyword2" <filename>
```
* Prints the lines containing keyword 1 or keyword 2

> Note: this file can also be used with other stdout commands such as `ls`  

## 1.4 - Sorting
```
$ sort <file>
```
* Sorts the lines of the file in alphabetical order
	* `-r` sorts in reverse order
	* `-k<n>` sorts by the nth field (column, separated by spaces) of the file; ex: `-k2`

## 1.5 - Removing duplicates
`uniq` deletes all duplicate lines from a file:
```
$ sort <file> | uniq
```
* Deletes all duplicate lines from the file (`uniq` needs `sort` to work properly)
	* `-c` will add a column mentioning the amount of duplicates (for each line) there were on the original file
	* `-d` will show lines having a duplicate

## 1.6 - Counting Words
```
$ wc <file>
```
* Returns the number of lines, words, and bytes of the file
	* `-l` will return only the number of lines
	* `-w` returns only the number of words
	* `-c` returns the number of bytes only

# 2 - Comparing files
```
$ diff <file1> <file2>
```
* returns the lines and byte numbers that are different

```
$ cmp <file1> <file2>
```
* Compares files byte by byte
