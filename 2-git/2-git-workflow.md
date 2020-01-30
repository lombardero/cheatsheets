# GIT WORKFLOW

This document summarizes the 'typical' workflow of commands used while working with `Git`. This document assumes the use of GitHub.

Note: all the commands listed on this document will work on a terminal after downloading `Git`.

## Step 1: Initialize the project (`git init` or `git clone`)
#### Step 1.1: new Repository
Open a new Repository in GitHub, give it a name.

#### Step 1.2 (possibility A):
 Use `git init` to start the project from scratch. In that case, it is recommended to create `README.md` file and `.gitignore` files. GitHub enables the creation of a defaule `README.md` file for the project, although it is always better to create your own.

#### Step 1.2 (possibility B):
Use `git clone [URL]` to copy an existent project in your local machine. You have then two possibilities:
- You can either use the cloned repository as a 'base' to start one of your own. In this case you will have to add the URL of **your** remote repository using the command `git remote add origin [your-repository-URL]` (it is recommended to use `origin` as a name for the repository as it will be the 'base' one),
- Or you might have cloned to resume working on the repository you cloned from (you might have initialized the `README.md` file on GitHub, or started using a different machine), in that case it is recommended to use `git clone -u [URL]` command instead (`-u` will add the remote repository as a shortcut for 'origin').

## Step 2: Make an initial commit statement to the `master` branch (first time)
Start working on your code, create a 'base' working project with some functionality. Say we created a basic application saved in a file `app.py`. After we verify it works, we add it to the staging area, commit it, and push it to GitHub.

```git status```
- It is always a good idea to check which files `Git` recognizes before adding any one onto the staging area: we might have created files we are not aware of and might want to add it onto the `.gitignore` file.

```git add app.py```
- We add the `app.py` file we just created to the Staging area.

```git commit -m 'first commit'```
- After adding the new file to the staging area, we commit it always adding a descriptor of the commit. (Before committing, we can run `git status` again to check we correctly added all files we wanted -they will appear in green- and did not forget any file).

```git push origin master```
- Updates the `master` branch of the remote repository. Careful: this command is allowed since it is the **first time we commit**, after this time, we should **never** push to the remote `master` branch directly, we should **always** push to another branch, **then** issue a pull request to `master` so others can review.

## Step 3: Create a new branch, update the local repository (usual case)
Break down the improvements to be done to your code into discrete parts, and start working on them one by one. For the first new feature (always matching with a story on the Scrum board), create a new branch:

```git checkout -b new-feature```
- Creates a `new-feature` branch, and moves the `HEAD` pointer (an object that tells GitHub the 'place we are currently working on') to the `new-feature` branch. From now on, the changes we do will be saved on this branch (unless we run `git checkout` again.). Since we were on the `master` branch, now `new-feature` is an exact copy of the contents of `master`.

Then, we start working on the new feature. For example, let's say we add some lines of code to `app.py` and create a new file named `models.py`, where we will store the models that `app.py` will use. After we are done modifying our files, we work as follows:

```git status```
- Again, we run `git status` to confirm everything is fine (we shoud see we modified `app.py` and created a new file `models.py`)

```git add app.py```
```git add models.py```
- We must run the `add` command for all modified and newly created files. After this step we can re-run `git status` to check we have correctly added the files.

```git commit -m 'created a new feature'```
- We then commit, and keep describing what we are doing at each commit statement (so we can understand it when we run commands such as `git log`).

Now that the local branch is updated, it is time to push the code upstream.


## Step 4: Pushing the data upstream and issuing a Pull Request
###  Step 4.1: Verifying if there are merge conflicts before pushing code to the remote repository
It is good practice to sort out merge conflicts on our local repository before pushing them on GitHub.

Note: GitHub also allows to easily solve a Merge Conflict when a Pull Request is issued, directly on the remote repository; if we wish to do so, this whole *Step 4.1* can be ignored. 

This step, however, is considered best practice.

#### Step 4.1.1: update the master branch
There are two ways of ensuring our code does not contain merge conflicts, it starts always with the same step: pulling the last changes done to master. We do so after switching to the master branch and fetching the data from the remote repository `origin/master`:

```git checkout master```
- switches to the master branch (locally)

```git fetch origin master```
- Fetching the last changes from the `master` branch updates the local `.git/` folder (but not the local workspace) with the changes made by other team members. Note that this step can be done with the `pull` command as well.

After updating `master`, we can return to the branch we were working on: `new-feature`:
```git checkout new-feature```
- switches back to the 'new-feature' branch

##### Step 4.1.2: merge master onto the branch or rebase the branch
At this point, we need to choose one of two possibilities: either merging `master` onto `new-branch` or rebasing `new-feature`. In both cases we will need to sort out the merge conflicts manually, as explained in the [cheatsheet](https://github.com/lombardero/nyu-devops-concepts/blob/master/3-git/1-complete-cheatsheet.md#sorting-out-merge-conflicts).

**Possibility A: Merging `master` onto `new-feature`** will create a new commit statement in the `Git` tree, showing what really happened: we were working on a branch, in the meantime, `master` was updated by some team members, and at one point we decided to incorporate these changes in our branch. To implement this step, we use:

```git merge master```
- Merges `master` onto `new-feature` (there might be some merge conflicts)

**Possibility B: Rebasing `new-feature`** will take the latest changes we just pulled from the `master` branch, and apply them to each of the commit statements of `new-feature`, as if we had just started working on `new-feature` right after pulling the changes. In a sense, it is 'faking' time. Check out the ['rebase' explanation in the Git cheatsheet](https://github.com/lombardero/nyu-devops-concepts/blob/master/3-git/1-complete-cheatsheet.md#33-rebasing).

```git rebase master```
- rebases `new-feature` into the latest fetched commit of the `master` branch.

### Step 4.2: pushing data upstream
Now that we have ensured our code will not create a Merge Conflict in the remote repository, we can push the data upstream:

```git push origin new-feature```
- This command pushes the code onto a new branch of the remote repository called `new-feature` (it is important to be specific with names so other team members do not use the same branch name). 

Once this command is run, the pull request can be issued (it is easier to do so in GitHub directly).