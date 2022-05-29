

# Quickstart

## Create React App

> React Quickstart: [Create React App](https://create-react-app.dev/)
> ```sh
> $ npx create-react-app my-app
> $ cd my-app
> $ npm start
> ```

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
 

## CSS code

All components can use custom CSS: for that, we just need to create a CSS file in the
same folder as the component -with the same name-, and import it to the component file.
