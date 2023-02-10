# Forms

Forms can be:

- Uncontrolled: state of the element is kept within it.
- Controlled: react keeps the state

## Uncontrolled forms

This is actually the recommended approach. What happens in this approach is that we need to synchronize React with the state of the form. We do that by creating some state, and triggering its change on the `onChange` trigger of the form, such as:

```tsx
const inputElement = useRef<HTMLInputlement>(null);

const handleSubmit = (event: FormEvent) => {
    event.preventDefault();
    console.log(value);
}

<form onSubmit={handleSubmit}>
    <input type="text" value={value} onChange={(event) => setValue(event.target.value)} >
</form>
```

- `value` is what is displayed
- `onChange` is that happens when we change (if this is not set, the changes would reach the DOM only, React would not know about it)
