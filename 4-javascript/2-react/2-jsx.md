# JSX

- [JSX](#jsx)
  - [What is JSX?](#what-is-jsx)
  - [Using CSS in JSX](#using-css-in-jsx)
  - [Javascript in JSX](#javascript-in-jsx)
    - [Functions](#functions)

JSX stands for JavaScript XML: it is XML-looking code that is transformed by react so that
it can be used in JavaScript. It is used by React as a "simplified" structure of the UI
that will run in the browser. React transforms it in a way that it can be interpreted by
the browser.

> Note: JSX code can only have one single root elemet (`<div></div>` section)

The idea of JSX is that, rather than separating closely related elements by technology (HTML / JS)
, JSX allows us to write code in components.

## What is JSX?

JSX is simply a syntax within React. Behind the scenes, a `React` object is called (that is why
in the past it had to be imported), and JSX is interpreted by it and then translated to
actual HTML (which is what we can see in the browser)

> Behind the scenes, React calls `React.createElement()` recursively, parsing all JSX
> code to create the HTML.

## Using CSS in JSX

To use a CSS style, instead of using `class="CSS-class"` in the XML divion, JSX uses
`ClassName` instead:

```js
function CustomComponent() {
  return <div className="CSS-of-component"></div>;
}
```

## Javascript in JSX

Javascript expressions can be used inside JSX to display some value or text, by adding
the expression between brackets: `{}`.

When done so, the expression is turned into a string and placed as part of the JSX code.

JS expressions

```js
<h1>Hello {isAuthenticated && getUserName()}</h1>
```

Attibute values

```jsx
<img className="logo" src>
```

We need to use `()` to write multi-line elements.

```js
function CustomComponent() {
  const printedValue = Math.random();
  return (
    <div className="CSS-of-component">
      <h2>{printedValue}</h2>
    </div>
  );
}
```

Note that all JSX elements must have a parent. We usually use `<div></div>`, but we also can keep the component empty `<></>`, in case we do not want the `<div>` component (may break the UI we want). Keeping it empty will not create an element in the UI.

### Functions

```ts
type AlertProps = {
    readonly children: ReactoNode;
    readonly type: "success" | "error";
};

const Alert: React.FC<AlertProps> = (props) =>
```
