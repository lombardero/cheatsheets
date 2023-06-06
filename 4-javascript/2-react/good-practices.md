
- Functions used by components should be defined _before_ the `return` statement.
```jsx
const MyComponent = (props) => {
    const clickHandler = () => {
        console.log('hehehe');
    };
    return (
        <button onClick=(clickHandler)>Hehe</button>
    );
};
```
