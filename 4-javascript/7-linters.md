# Linters


## Prettier

```sh
$ prettier --write
```


## Eslint
```sh
$ eslint --fix
```


## Husky

Allows to run pre-commit commands, such as linting ones :sparkles:. It creates a `pre_commit` file which enables to run the `lint-staged` command. The `lint-staged` command is configured in the `package.json` file, and enables to define:
- Which commands to run
- Which types of files to run it for

Example:
```json
},
  "lint-staged": {
    "*.{ts,tsx}": [
      "prettier --write",
      "eslint --fix"
    ]
```
- Runs `prettier` and `eslint` for files with `.ts` and `.tsx` extensions 

