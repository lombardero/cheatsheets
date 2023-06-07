# Reacting to events

Some -interactive- HTML elements emit events, such as "Clicks", React has built-in listeners for these events; they all start with `on`-something. For example, buttons can listen to "click" events by:

`button` example
```jsx
<button onClick={() => console.log('Clicked')}>This is a button </button>
```
- `on<Action>` expects a function
