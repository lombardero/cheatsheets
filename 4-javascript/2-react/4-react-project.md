# Setting up a React project

- [Setting up a React project](#setting-up-a-react-project)
  - [Create React App](#create-react-app)
- [File organization](#file-organization)
  - [Folders](#folders)
  - [CSS code](#css-code)

## Create React App

React Quickstart: [Create React App](https://create-react-app.dev/)

_Create base app using `npx`_

```sh
$ npx create-react-app my-app
```

_Create base app using `yarn`_

```sh
$ yarn create react-app my-app
```

- See [yarn](../6-yarn.md)

> :information_source: `yarn` and `npx` are virtual environmentmanagers

_Start the app_

```sh
$ cd my-app
$ npm start
```

# File organization

The `/src`

- `index.js`: the entrypoint of our app
- `App.js`: The code of our app (?)
- `index.css`: CSS styles

The `/public` folder:

- `index.html`: the HTML entrypoint of the app

> Our react app will be displayed in the element -usually a `div` is chosen
> we select, for example:
> """js
> const root = ReactDOM.createRoot(document.getElementById('root'));
> """
> that will display the app in the element with id `root`

> Note: it is considered good practice to have one component by file.

## Folders

It is good practice to create sub-folders for components. A generic `UI` folder could be
created, for example, for generic UI components and feature-specific ones.

## CSS code

All components can use custom CSS: for that, we just need to create a CSS file in the
same folder as the component -with the same name-, and import it to the component file.
