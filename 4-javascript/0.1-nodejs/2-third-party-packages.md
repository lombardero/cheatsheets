# 2 - WORKING WITH THIRD PARTY PACKAGES

## 2.1 Using the Node Package Manager (NPM)
NPM allows us to use 3rd party packages and to define script shortcuts.

We can check out the third party packages available through the 'npm Repository' (can be accessed [here](https://www.npmjs.com/)), and can be installed and managed via `npm` using the command `npm install <package>` on the terminal.
### 2.1.1 Initialize NPM
```npm init```
- Will intialize NPM, asking for default values and creates the `packages.json` file, with the basic data of the profile.

Example of `packages.json` file:
```json
{
    "name": "nodejs-project",
    "version": "1.0.0",
    "description": "My description",
    "main": "app.js",
    "scripts": {
        "test": "echo \"Error: no test specified\" && exit1",
        "start": "node app.js"
    },
    "author": "lombardero",
    "license": "ISC"
}
```

### Setting up script shortcuts
We can use the `packages.json` file to set up default scripts (Node will look for global and local versions of scripts, meaning NodeJS will be able to run packages installed locally).

```json
{
    //...
    "scripts": {
        "start": "node app.js",
        "other-shortcut": "commands"
    },
    //...
}
```
- Sets up the `start` script (which is a special one) shortcut. The script defined (in the above case we chose `node app.js`) once the command `npm start` is run on the terminal
- We can set up any other shortcuts (such as `other-shortcut`, without spaces) as additional elements on the `scripts` list. These commands will need the additional `run` keyword as the following example: `npm run other-shortcut`.

### 2.1.2 Development vs Production dependencies
It is important to 'mention' to NPM if the dependency installed will be used in the dev environment (`nodemon`, for example, is very useful for dev but undesirable for prod), some in the prod environment, and some globally. We must indicate the use of each package using the additional commands `--save-dev`, `--save`, and `-g`

- `npm install <package> --save-dev`: installs the dependy as a dev one (this will install into the local workspace, not locally on the machine). Installing the package updates the `package.json` file and downloads its dependencies on the `node_modules` folder.
- `npm install <package> --save`: installs the dependy as a prod one
- `npm install <package> -g`: installs the dependency globally on the machine (can be used anywhere)

Note: once a dependency is added onto the `package.json` file, nodeJS will check if it is installed (and do so if it is not) every time the command `npm install` is ran.

## 2.2 Nodemon
The `nodemon` package allows us to automatically update the nodeJS server with the changes of the code we just made without having to exit the server with `ctrl + C` and running it again; it is very useful in the dev environment (package can be found [here](https://www.npmjs.com/package/nodemon))

### 2.2.1 Installing
```npm install nodemon --save-dev```
- Installs nodemon in as a Dev dependency

### 2.2.2 Running `nodemon`
To use `nodemon` (usually installed locally), we must add it to the `"scripts"` part of out `package.json` file. Assuming our main file is called `app.js`:

```json
{
    //...
    "scripts": {
        "start": "nodemon app.js",
        "regular-start": "node app.js"
    },
    //...
}
```
- `nodemon` will be run once `node start` command is launched, and the server will be updated each time we change our local files. (note: the `nodemon app.js` command in the terminal will not work if we did not isntall the package globally!)

### 2.2.3 Enabling `nodemon` in debug mode
Enabling `nodemon` for debug mode will re-launch the entire code every time time we change a line of code on the text file.

- Go to `Debug > Add configuration...` on VS Code to create a `launch.json` folder on a `.vscode` folder, which will configure the debugger for this project.
- To enable `nodemon` and the restart of the code after each modification, we need to add the following lines to the `launch.json` file:
```json
{
    "configurations": [
        {
            //... (default lines of code)
            "program": "${workspaceFolder}/app.js",
            "restart": true,
            "runtimeExecutable": "nodemon",
            "console": "integratedTerminal"
        }
    ]
}
```
Notes on the code above:
- Adding the `"${workspaceFolder}/app.js"` will allow the Debugger to know which 'core' file needs to be run (always first) so the server can be started
- `"restart": true` will allow the Debugger to restart after a change is done (to run with this, nodemon needs to be enabled)
- `"runtimeExecutable": "nodemon"` enables `nodemon` for the debugger (note that `nodemon` needs to be installed globally for it to run in the debugger)
- `"console": "integratedTerminal"` enables an integrated terminal (different from the debugging terminal) that will allow us to start and halt the `nodemon` process that is required to run the debugger.