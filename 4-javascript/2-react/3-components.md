# React Components

Components are the building blocks of UIs in React applications; many of them are
re-used. The goal here is modularity and re-using of components.

Components in react are just a composition of HTML, CSS & JavaScript enabling to display
a particular element in a UI. HTML to get the structure, JavaScript so they can react
to user inputs, CSS so they look good.

## Declarative approach

React uses a declarative approach, which means that you should define and "end state"
and the set of conditions in which such state should be displayed.

## Component syntax

Components are functions returning `JSX` code (JavaScript XML). Components can be used
as regular XML code -> Components inside other components

```js
import CustomComponent from './components/CustomComponent';

function App() {
    /**
     * Application entrypoint.
     */
    return (
        <div>
            <h2>This is the application!</h2>
            <CustomComponent></CustomComponent>
        </div>
    )
}
```

# Props
"Props" are variables we can pass to Components as arguments. We can pass as many
key-value pairs as we want in the code calling the component. Inside the component,
these attributes will be passed as a dictionnary of arguments.

> This can be used to reuse components

The syntax for props is as follows:
```js
// Component code:
function CustomComponent(props) {

    return (
        <div>
            <h2>props.title</h2>'
            <p>props.paragraph</p>
        </div>
    )
}

// Caller of the component:

function CallerComponent() {

    return(
        <div>
            <CustomComponent
            title="I am a title!"
            paragraph="I am a paragraph!">
            </CustomComponent>
        </div>

    )
}
```

# Wrapper components

Wrapper components are components that store outline logic -such as color, contour
and shadow. It is a good practice to use them to enable composition and avoid code
duplication.

An example of such wrapper components is a `Card` element, which defines the contour
of each component. The syntax is shown below:
```js
// Defining the wrapper component.
function Card(props) {
    // Adding the children CSS styling to the component's.
    const className = "card-css " + props.className;
    return (
        <div className={className}>
            {props.children}
        </div>
    )
}
```
- The `Card` component uses two built-in arguments passed as `props` by default:
  - `props.className`: the `className` used by the user of this component to enable adding more style
  - `props.children`: the children JSX code passed inside of the wrapper

Syntax of the code using the wrapper:
```js
function myComponent(props) {

    return (
        <Card>
            <h2 className="myStyle">This is a Title!
            </h2>
        </Card>
    )
}

```
