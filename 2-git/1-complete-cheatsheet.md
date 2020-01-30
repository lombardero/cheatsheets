# GIT CHEATSHEET

This document is a commented cheatsheet of `Git`, divided in three parts:

### [1: Working in the local repository](#1-working-in-the-local-repository-1)
- Commands treated: `git init`, `git status`, `git diff`, `git add`, `git commit`, `git log`

### [2: Working with remote repositories](#2-working-with-remote-repositories-1)
- Commands treated: `git clone`, `git remote add`, `git fetch`, `git merge`, `git push`

### [3: Working with branches](#3-working-with-branches-1)
- Commands treated: `git checkout`, `git merge`, `git branch`, `git rebase`

A simplified Git cheatsheet can be found [here](https://github.github.com/training-kit/downloads/github-git-cheat-sheet.pdf).

## 1. Working in the Local Repository
### 1.0 Initializing
```git init```
- creates an empty Git repository (`.git/`) that will gather all committed files from the working document (see [Git basics](https://github.com/lombardero/nyu-devops-concepts/blob/master/3-git/0-git-basics.md)).

#### Basic files
Apart from our codebase, it is a good idea to initialize each project with two additional files:
- `README.md` file: uses the [Markdown language](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf) to render a description of the Project in GitHub.
- `.gitignore` file: a list of the files we do not want Git to keep track of (and we do not want in GitHub).

#### Note on `gitignore` file
The `.gitignore` file contains all files and terminations that should be ignored by `Git` (those files you might have or want in your local repository but you do not need in your code, such as `VS Code` files '`.vscode'`.)
The file contains a list of all terminations, folders, files to be ignored. The format is explained below:
- use `*.<extension>` to ignore all files ended up in the `<extension>` specified
- use `<folder>/` to ignore all files inside a folder
- use `<folder>/<filename>` to ignore a specific file

An example of `.gitignore` file can be found [here](https://gist.github.com/octocat/9257657).

### 1.1 Adding, Removing and Modifying files in the Staging Area
Conceptually, the Staging Area is what `Git` calls the list of 'files to be added later to my code'. 
The Staging Area allows us to keep track of the current changes of our code in real time. When a file added to the staging area, `Git` will take a snapshot of that file; `Git` will then be able to know if we have made changes on that file.

Once it is on the staging area, the file will be ready to be Committed (Saved on the `Git` tree, see point [1.2](#12-comitting-files-from-staging-area-to-local-repository)).

#### Checking status
```git status```
- compares the current state of the local files with the files on the staging area and outputs the differences. This command will also let us know the branch we are currently working on, and the files already in the Staging area.

```git diff```
- Tells us the files we have changed locally but not yet staged.

#### Adding files to Staging area
```git add [file]```
- adds snapshot of `[file]` to the staging area (Snapshot of file is taken, and will be added to the Git repository next time we run `commit`) (Note that if you modify `[file]` again before committing, only the version added to the Staging area will be considered. To update the modified version, run the add command again with the same file)

```git add -A```
- adds all modified files of the current folder in the Staging area

#### Removing files from Staging area
```git reset HEAD -- [file]```
- Removes from the staging area a `[file]` we previously added.

Note: this command should not be confused with the `rm` one, explained below: `git reset HEAD` simply 'resets' the state of the Staging area for the specific `[file]` we select (that `[file]` must have been previoulsy added to the staging area (with the command `git add` for the command to work); `git rm` is used to 'delete' or 'not keep track' anymore of a file that we have committed in the past (we are telling `Git` not to keep track of it anyore in future commits).

#### Removing files from Git tree
```git rm [file]```
- Remove: Tells `Git` to not keep track of changes in `[file]` anymore (removes it from the `Git` tree)

#### Modifying file names
```git mv [previous_file_name] [new_file_name]```
- Updates the name of the file from `[previous_file_name]` to `[new_file_name]` (this command explicitely tells `Git` that the new file had a different name in the past, and if we decide to retrieve a past version of the new file, it should look for the previous name). 
Note: if you delete (using the `rm` command) the file (`git rm [previous_file_name]`) then add it again with another name(`git add [new_file_name]`), `Git` will still figure out the file is being renamed, but the `mv` command is the explicit way of doing so (preferred way).

### 1.2 Comitting files from Staging area to Local Repository
Once the local changes have been sent to Staging area (git has taken a 'snapshot' of the files), these snapshots are ready to be saved in the local `.git/` repository. Once in the local repository, any saved state will be retrievable at any time.

#### Adding files to the Local Repository
```git commit -m '<commit description>'```
- Saves the snapshots the files in the staging area in to the local `.git/` repository.

Note: In the background, what `Git` does on each `commit` statement is saving the changes done to the files in an optimized format. The files do not get copied over and over, what is saved are only the lines of code that were deleted, and the new lines added from the previous version. That way, files can be 're-built' following any of the steps of each `commit` statement, from the initial state. Each `commit` statement receives a hash code, which will allow us to identify it, and retrieve it anytime we wish so.
- `-m` lets you add a comment to the commit (Important, so you can keep track of what you did in that commit). Note that `Git` will force you to add the message if it is not included.

#### Retrieving commit history
```git log```
- Outputs the history of commit statement done in the local repository. This command is very useful to understand where we are in the `Git` tree history; it can be used to retrieve the `commit` code and understand the branch tree.
Useful options (can be combined): 
- `git log --oneline` displays all the information in one line
- `git log --decorate` adds branch information
- `git log --all` shows all branches
- `git log --graph` creates a visual graph of the branches and merges
- `git log --pretty=format:" %s" --graph` displays the info demanded ("%h" prints the commit hash, "%s" prints the subject) in a visual way showing the branch and merge history.

#### Creating aliases
It is useful to create aliases for long commands (such as the `git log` ones).

```git config --global alias.[alias] "[command]"```
- Creates an `[alias]` for the `[command]` we requested. 

Example: running `git config --global alias.lg "log --oneline --decorate --all --graph"` creates an alias `lg` that will be equivalent of `og --oneline --decorate --all --graph`.

### 1.3 Undoing commit statements
#### Undoing commits on entire project
```git reset --soft```
- Deletes the last commit statement saved on the local repository (the `.git/` folder), but saves the state on the Staging area (that way, if we run `git commit` again the local repository will be back to the point where it was before running `git reset`).

```git reset --hard```
- Deletes the last commit statement saved on the local repository definitely, in a way that is not retrievable (this command should be run once we are completely sure we do not want to keep the last commit).

#### Undoing commits on specific files
```git checkout -- [file]```
- Discards the last changes done to `[file]`, and reverts its state back to where it was in the last `commit` statement.

```git checkout [hashcode] -- [file]```
- Discards the last changes done to `[file]`, and reverts its state back to where it was in the `commit` statement corresponding to the `[hashcode]` entered. Example: `git checkout 8ae67 -- my_file.txt`

```git reset --soft```
- Deletes the last commit statement on the `.git/` folder, but 

## 2. Working with Remote Repositories
### 2.0 Configuring
Before working with any remote repository (in GitHub, for example), it is important to set up correctly the username and email of our account. GitHub will use this data to autheticate us every time we try to push changes to remote repositories.

```git config --global user.name [my-username]```
- Sets up the username to 'my-username'

```git config --global user.email [my.email@example.com]```
- Sets up the email

### 2.1 Cloning remote repositories
Cloning makes a copy of a remote repository in a local file, and allows us to start working immediately. (It is similar to `git init`, but the contents are copied from a remote repository instead of being empty).
```git clone [URL]```
- Creates a new folder in current directory, and makes a local copy of the contents of the repository of the specified URL
- `git clone [URL] [folder_name]`: adding `[folder_name]` creates a new folder (named `[folder_name]`), and clones the content of the URL

### 2.2 Adding/checking remote repositories
```git remote```
- lists the names of the remote repositories you have configured
- adding `-v` (verbose) will print the URLs of each remote repository.
Note: `origin` is the default name for the 'base' project (the repository you cloned the project from).

```git remote show [remote repository name]```
- gives you info about the remote repository

```git remote add [shortname] [URL]```
- adds a new remote repository in the URL specified, with the shortname typed (shortname can be changed) 
Example: `git remote add origin https://github....`

```git remote rename [oldname] [newname]```
- changes the name of the remote file from old to new name


### 2.3 Pulling data from remote repositories
```git fetch [remote repository name] [branchname]```
- updates the local `.git/` folder from the data of a branch in the remote repository (Github). Only the `.git/` file is changed, not the local working files. 
Example: `git fetch origin master`
		
```git merge [repository name] [branchname]```
- takes the data from a branch in the local `.git/` folder and merges it into our local files in the workspace (merging might bring discrepancies - i.e. a line modified in the `.git/` folder & locally, they must be resolved before being able to end the merge command, see Paragraph 3).
Example: `git merge origin master`
		
```git pull [repository name] [branchname]```
- the pull command is equivalent of fetch & merge. The changes on the remote repository are saved in the local `.git/` repository and merget onto our workspace.
Example: `git pull origin maser`

### 2.4 Pushing data upstream
```git push [remote repository name] [branchname]```
- "pushes" or updates the local data to the remote repository. This command will only work if we have access to the repository, and if there are no merge conflicts in the code.
- Note: Adding `-u` (`git push -u ...`) in the statement creates a bond between 'origin/master' (local Git repository) and the virtual 'master' on Github. `-u` needs to be called one time only to do the bonding.

#### Force-pushing (Use very carefully)
In the cases we are absolutely sure that we want to ignore the changes in the remote repository to push code from our local files, we can use the `-f` command added to the push statement. (`git push -f ...`). This will automatically update the remote repository with the changes on the local one, removing any conflicting parts in favor of the local data.

### 2.5 Tagging
```git tag -a [tag] -m [tag message]```
- sets up an annotated tag that will be associated with a specific commit
Example: `git tag -a v1.1 -m 'This is the 1.1 version'`

## 3. Working with Branches
### 3.1 Creating and switching branches
Branching allows us to work in multiple tasks at the same time (see Paragraph 0).
This is a useful [link](https://git-scm.com/book/en/v1/Git-Branching-Basic-Branching-and-Merging) explaining branching.
	
```git branch [newbranch]```
- creates a new branch named 'newbranch' from the last commit of the current branch we are in. If we are not in `master` and want to make a branch FROM it, we must switch back to `master` (command: `git checkout master`) before running the above command and THEN create the new branch.

```git branch -a```
- Tells us the current existing branch names (`-a` stands for 'all', and will output both local and remote branches)

```git checkout [namebranch]```
- Switches to the branch spacified. The way Git handles it is by changing the pointer of the HEAD object, which will make all commits done from now on will go on the branch specified (note that if we have uncommitted changes that clash with the branch we are switching to, Git will not allow us to do the switch; to sort that see the `git stash` command).

Note: once we run `checkout`, the local files on our workspace will also be updated to match the contents of the branch we are swithching to.

```git checkout -b [newbranch]```
- adding `-b` to the checkout command creates a new branch from the current branch AND changes the pointer to work on it

#### Sorting out switching branches issues
Sometimes, the state of our workspace (the local files) does not match the latest commit statement (this happens when we modify our code without committing). At that time, if we try switching branches (with the `checkout` commit), Git will not allow us to do so to prevent losing data. At that point, we have two possibilities: committing the local changes, or using the `stash` and `pop` commands, described below.

```git stash```
- takes a snapshot of the current state of the local workspace, saves it (making it recoverable with the `git pop` command), and reverts the state of the local files to match with the last `commit` statement of the branch. Once the `git stash` command has been done, it will be possible to switch branches (since the local workspace matches the contents of the branch in the `.git/` folder).

```git pop```
- sets back the state of the local workspace as it was before running the `git stash` command.

### 3.2 Merging branches
#### Successful merges
```git merge [branchname]```
- merges the specified branch with the branch you are currently in.

```git branch -d [branchname]```
- This command deletes the branch (`-d`). This should be ran after branches are mergerd.

#### Sorting out merge conflicts
Merge conflicts occur when we merge code to a branch that has been changed since the last time we pulled code from it (for example, we create a `new-branch` from `master`, and someone modified `master` before we merged back the `new-branch` changes-). Not all changes generate merge conflicts, only the ones affecting the same lines of code we modified in our branch. Note that **merging will be blocked until we resolve the merge conflict**.

There are many ways to sort out Merge conflicts, the easiest is using opening our text editor and manually selecting the lines of code we want to keep. A merge conflict looks like this:

``` Python
# This code is unaffected by the merge conflict

<<<<<< HEAD
# These lines were modified since
# the last time we pulled from the branch

=======
# These lines are the ones we modified
# that are conflicting with the lines above

>>>>>> new-branch
```
- To sort out the merge conflict, we must select the lines that we wish to keep (we can select parts of each side), and delete the `<<<<<< HEAD`, `=======` and `>>>>>> new-branch` operators.

Additional [resource](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/resolving-a-merge-conflict-using-the-command-line) on sorting out Merge conflicts.

### 3.3 Rebasing
Rebase is a command used to prevent merge conflicts when pushing code to the remote repository. Conceptually, what `rebase` does is to take the changes done to the base branch (usually `master`), and add them to the branch we are currently working on. 

```git rebase [base-branch]```
- takes the last changes of the `[base-branch]` (usually `master`) and adds it to all commits of the current branch, making it look as if the current branch was created after the last commit of `[base-branch]`. Running this command will tell us if there are merge conflicts. (After this, a PR can be issued.)

**Example of `rebase` usage**: we create a `new-branch` from `master` to start working on a new feature and we start working on it. We commit two times (commits `(b)` and `(c)`). After some time, other members of the team have updated the branch `master` since we created `new-branch` (commits `(d)` and `(e)`): `master` has some changes that `new-branch` does not have. The commit tree looks as shown below:
```text
--- (a) --- (d) --- (e)     master 
       \
        (b) --- (c)         new-branch
```
Now, if we run `rebase`, we will add the changes made to master to our own branch to all commits done to `new-branch` as if we created `new-branch` from point `(e)` instead of point `(a)` (in a sense, it is like 'faking reality' to make it look as if the branch was created at the current point in time). After running `rebase`, both `(b)` and `(c)` commits are modified considering the changes made to `master`, and the commit tree will look as shown below:
```text
--- (a) --- (d) --- (e)                    master 
                      \
                       (b') --- (c')         new-branch
```
Note that all merge conflicts coming from rebasing would have to be sort out manually as well.
