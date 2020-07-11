# Files: Editing

There are many built-in text editors in linux systems: `vi`, `ed`, `ex`, `emacs`, `pico`, `vim`, `nano` (depends on the linux distributions).

# 1 - `vi` and `vim`
## 1.1 The vi editor
`vi` is the most well-known linux editor since it is known to be easy to use, and is in almost every linux system.

```
$ vi <filename>
```
* Enters the `vi` mode (allows you to modify the file)
	* `i`: insert mode
	* `o`: insert a line + activates insert mode
	* `a`: advance to the next space +. activate insert mode
	* `d`: delete mode (pressing two times d will delete the line, pressing d + up or down arrow will also delete the top or below line)
	* `/<keyword>` searches for the keyword on the file, and selects it
	* `Esc`: exit any mode
	* `r`: replace the character selected (one at a time)
	* `x`: delete the character selected (one at a time)
	* `u`: “undo” previous change (like `Ctrl+Z`)
	* `Esc`: exit any mode
	* `:q!`: quit without saving
	* 	`:wq!`: save and quit

Substituting words inside `vi`:
	* `%s/old-string/new-string/` will replace all old string by new strings.

## 1.2 The vim editor
Vim is a “newer and more enhanced” version of the vi editor, however it is not present in all linux devices.  It adds some functionalities (such as auto-completion and spell check) to `vi`, as well as many customisations.
For more details, check [this link where we can interact with it](openvim.com).

```
$ vim <filename>
```
* Vim uses `h`, `j`, `k` and `u` to move around instead of arrows

# 2 - The `sed` command
Sed allows us to perform many useful actions on a file such as:
	* replacing strings on files for other strings automatically
	* find and delete specific lines
	* remove empty lines
	* (and many more)

Replacing strings:
```
$ sed -i 's/old-string/new-string/g' filename
```
* Substitutes (`s`) globally (`g`, all occurrences) an old string for a new one in the filename specified.
* If we do not want the 8th line to be modified, we can say `’8!s/old-string/new-string/g'` and it won’t change it 
* Command be used with an empty new-string (will delete it)
	* `-i` is for “insert” (will do the changes to the file, otherwise it just prints it out without changing the file)
	* `G` will add a space between each line (`sed -i G filename`

> Note: a tab in linux is indicated with `\t` (replace tabs with spaces would be: `’s/\t/ /g’`  

Deleting lines:
```
$ sed -i '/keyword/d' filename
```
* Will delete (`d`) all lines that contain the keyword

Deleting empty lines
```
$ sed -i '/^$/d' filename
```
* Deletes all empty lines of the file (recall: `^` means the start of line, and `$` is the end of the line)

Deleting specific lines:
```
$ sed -i '1,2d' filename
```
* Deletes the first two lines of the file


