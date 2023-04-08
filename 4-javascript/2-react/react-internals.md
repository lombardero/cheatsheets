# React internals

# DOM

The DOM is the tree of HTML elements that are rendered in the browser. Changes in the DOM are expensive in time.

What React introduces is a virtual DOM (abstraction of the DOM), which is used by react to keep track of the changes. When state is changed, React updates its virtual DOM -stored in memory-, and uses its own algorithm to compute the minimum amount of changes to the DOM to update the state. This algorithm is `O(n)`

For example, when we press a button that updates some count, React knows that it only needs to change:

- The element showing the count
- The state of the counter

All the remaining components are untouched
