# JSX

JSX stands for JavaScript XML: it is XML-looking code that is transformed by react so that
it can be used in JavaScript. It is used by React as a "simplified" structure of the UI
that will run in the browser. React transforms it in a way that it can be interpreted by
the browser.

> Note: JSX code can only have one single root elemet (`<div></div>` section)

## Using CSS in JSX

To use a CSS style, instead of using `class="CSS-class"` in the XML divion, JSX uses
`ClassName` instead:
```js
function CustomComponent() {
    return (
        <div className="CSS-of-component">
        </div>
    )
}
```

## Outputting Javascript in JSX

Javascript expressions can be used inside JSX to display some value or text, by adding
the expression between brackets: `{}`. When done so, the expression is turned into a
string and placed as part of the JSX code.
```js
function CustomComponent() {
    const printedValue = Math.random()
    return (
        <div className="CSS-of-component">
            <h2>{printedValue}</h2>
        </div>
    )
}
```

