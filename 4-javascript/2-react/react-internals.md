# React internals

# DOM

The DOM is the tree of HTML elements that are rendered in the browser. Changes in the DOM are expensive in time.

What React introduces is a virtual DOM (abstraction of the DOM), which is used by react to keep track of the changes. When state is changed, React updates its virtual DOM -stored in memory-, and uses its own algorithm to compute the minimum amount of changes to the DOM to update the state. This algorithm is `O(n)`

For example, when we press a button that updates some count, React knows that it only needs to change:

- The element showing the count
- The state of the counter

All the remaining components are untouched.

# State

JSX components are evaluated by React as functions (which return other components or JSX elements), these functions are called recursively until all the DOM tree is formed. This is run at the start -when the App is loaded.

To trigger re-evaluations of that DOM, React works with [State](managing-state.md). We can use `useState` to trigger re-rendering of components once `setState` is called.
