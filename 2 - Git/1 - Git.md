# GIT COMMANDS CHEATSHEET

This document lists useful commands to be used while using `Git`: from the basic Unix commands to work with branches and pushing code to GitHub. This file assumes no previous background.

## 0 - Basic navigation (Unix commands)
### 0.0 Get help
```<command> --help```
- Will output the guidelines for any command

### 0.1 File and folder navigation
#### Move through folders
```cd <path>```
- cd stands for "change directory", moves to the specified path. Example: `cd /folder` moves to `folder`.
Note: use `cd `, and press `Tab` to jump to possible options

```cd ..```
- moves to the upwards (or 'preceding') directory

```pwd```
- stands for "print Working Directory": returns address of current directory

#### Show folder contents
```ls```
- lists current directory contents (prints the filenames)
Options:
- use `ls -l` to output the file details. `-l` stands for 'long' listing format.
- use `ls -a` to print all files (normal files and hidden ones). `-a` stands for 'all'
- use `ls -la` to combine above 

#### Create, Update, Delete
```rm directory/file.txt```
			-> removes file.txt in directory 

```rm -r directory1/directory2```
			-> removes directory2 in directory1 (-r : "Recursive")

```mv directory_old/file.txt directory_new/file.txt```
			-> moves file.txt from directory_old to directory_new

```mv file_old.txt file_new.txt```
			-> renames file_old.txt into file_new.txt

```mkdir new_directory```
			-> creates new_directory in current location

```code filename```
			-> opens the file in the text editor (VS code)

## 1. Git: Working in the Local Repository
### 1.0 Initializing
```git init```
			-> creates an empty Git repository ('.git') (to gather all committed files from the working document)

### 1.1 Adding, Removinf and Modifying files in the Staging Area
Conceptually, the Staging Area is what `Git` calls the list of 'files to be added later to my code'. 
The Staging Area allows us to keep track of the current changes of our code in real time. When a file added to the staging area, `Git` will save a snapshot of that file; `Git` will then be able to know if we have made changes on that file
Once it is on the staging area, the file will be ready to be Committed (Saved on the `Git` tree, see point 1.2).
```git status```
- compares the current state of the local files with the files on the staging area and outputs the differences. It will also let you know the branch you are currently working on, and the files already added to the Staging area.

```git add <file>```
- adds snapshot of `file` to the staging area (Snapshot of file is taken, and will be added to the Git repository next time we run `commit`) (Note that if you modify `<file>` again before committing, only the version added to the Staging area will be considered. To update the modified version, run the add command again with the same file)

```git add -A```
- adds all files of the current folder in the Staging area
    
```git rm <file>```
- Remove: Tells `Git` to not keep track of changes in `<file>` anymore (removes it from the `Git` tree)

```git mv <previous_file_name> <new_file_name>```
- Updates the name of the file from v1 to v2 (so `Git` can keep track of the changes since the beginning). 
Note: if you remove the file (`git rm <previous_file_name>`) then add it again with another name(`git add <new_file_name>`), `Git` will still figure out the file is being renamed, but the `mv` command is the explicit way of doing so (preferred way).

## 1.2 Comitting files from Staging area
```git commit -m '<commit description>'```
- Copies all "snapshots" of the files added in the staging area, and saves a copy in to the local Git repository (The snapshot is the way Git stores the data. Once a list of files have been committed, they can be retrieved at any point.
Note: In the background, what `Git` does on each `commit` is saving the changes done to the files at each step in an optimized format. The files do not get copied over and over, what is saved are the changes done to the previous file. That way, files can be 're-built' following the steps of each `commit` statement, from the initial state.
- `-m` lets you add a comment to the commit (Important, so you can keep track of what you did in that commit). Note that `Git` will force you to add the message if it is not included.

	Ignoring data (.gitignore file)
		.gitignore
			-> a file stating all ignored files by Git (not listed in status or added to the staging area)
			ex: ignore all files ending in '.a'
			*.a
			ex2: ignore all files in directory 'folder'
			folder/
	Getting info
		git status
			-> shows status of files in your current directory
			   (will tell you which branch are you in,
			   which files are on staging area: "Changes to be committed",
			   and which files have been modified since the last commit: "Changes not staged for commit")
		git diff
			-> tells you the files you've changed but not yet staged
	Commit History
		git log
			-> displays the commit history of the repository
		git log --pretty=oneline
			-> displays the info in one line
		git log --pretty=format:"%h %s" --graph
			-> displays the info demanded ("%h" prints the commit hash, "%s" prints the subject) in a 
			   visual way showing the branch and merge history
	Rebase: updates the position of your branch after new changes of master
		(while at branch different from master)
		git rebase master
			-> (after pulling to master last remote master changes) takes the HEADER and puts it into the 
			   latest version of master, which updates the position of the branch to the latest of master,
			   this will tell you if there are merge conflicts. After this, a PR can be issued.

GIT - REMOTE REPOSITORIES
	Cloning files
		git clone [URL]
			-> creates a new folder in current directory, and copies all information of the specified URL
		git clone [URL] name
			-> adding 'name' creates a folder with named 'name', and clones the content of the URL
	Adding/checking remote repositories
		git remote
			-> tells you the names of the remote repositories you have configured
			-> adding -v (verbose) will tell you the URL
			   (origin is the default name of the repository you cloned your local file from)
		git remote show [remote repository name]
			-> gives you info about the remote repository specified
		git remote add [shortname] [URL]
		ex: git remote add origin https://github....
			-> adds a new remote repository in the URL specified, with the shortname typed
			   (shortname can be changed)
		git remote rename [oldname] [newname]
			-> changes the name of the remote file from old to new name
	Pulling data from remote repositories
		git fetch [remote repository name] [branchname]
		ex: git fetch origin master
			-> updates the 'origin/master' local Git folder from the data of the 'master' remote repository
			   (Github). Only the .git file is changed, not the working directory
		git merge [repository name] [branchname]
		ex: git merge origin master
			-> takes the data from the 'origin/master' local .git folder to the 'master' local working folder 
			   (merging might bring discrepancies - i.e. a line modified in the .git folder & locally, they 
			   must be resolved before being able to end the merge command)
		git pull [repository name] [branchname]
		ex: git pull origin maser
			-> the pull command is equivalent of (fetch & merge)
	Pushing data upstream
		git push [remote repository name] [branchname]
			-> "pushes" or updates the local data to the virtual repository.
			   (will only work if you have access and if nobody has pushed since the last time you pulled code.
			   If the code has been updated, you'll need to pull the code, change it, and then push it.)
			-> '-u' creates a bond between 'origin/master' (local Git repository) and the virtual 'master'
			   on Github. '-u' needs to be called one time only to do the bonding
	Tagging
		git tag -a [tag] -m [tag message]
		ex: git tag -a v1.1 -m 'This is the 1.1 version'
			-> sets up an annotated tag that will be associated with a specific commit
BRANCHING & MERGING
https://git-scm.com/book/en/v1/Git-Branching-Basic-Branching-and-Merging
Branching allows you to work in multiple tasks at the same time. For example: you are building some feature
for an app. You create a branch "feature 1", and start working on it; the main "production" branch (Master) is
unchanged. Then, you need to start working on another urgent feature. You create a branch from the master 
and start working on it.
	git branch [newbranch]
		-> creates a new branch named 'newbranch' from the last commit of the current branch you are in
		   (if you are not in Master and want to make a branch FROM master, switch back to Master and 
		   THEN create the new branch)
	git checkout [namebranch]
		-> changes the pointer of the HEAD object, and all commits done from now on will go on the branch
		   specified
		   (note that if you have uncommitted changes that clash with the branch you are switching to,
		   Git will not allow you to do the switch)
	git checkout -b [newbranch]
		-> adding -b to the checkout command creates a new branch from the current branch AND changes the
		   pointer to work on it
	git merge [branchname]
		-> merges the specified branch with the branch you are currently in (ex: to merge with master you
		   need to checkout to master then merge)
	git branch -d [branchname]
		-> after the branch is merged, the branch pointer can be erased as it is useless