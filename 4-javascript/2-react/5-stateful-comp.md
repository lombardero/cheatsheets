# Managing State

- [Managing State](#managing-state)
  - [Passing state to child components](#passing-state-to-child-components)
- [Hooks](#hooks)
  - [UseState](#usestate)
  - [UseEffect](#useeffect)

Stateful components require to remember state. For example, a check-box, which needs to remember whether it is in checked state or unchecked.

Another example is a filter to display a set of entries in a list view. Let's build a filter that displays:

```tsx
type EventsFilterProps = {};

export const EventsFilter: React.FC<EventsFilterProps> = () => {
  // State:
  const [isFreeEntryChecked];

  // component:
  return (
    <Chip
      label="Free entry"
      color="primary"
      variant={isFreeEntryChecked ? "filled" : "outlined"}
      onClick={() => setIsFreeEntryChecked(!isFreeEntryChecked)}
    />
  );
};
```

## Passing state to child components

We can do that via the props:

```tsx
type EventsFilterProps = {};

export const EventsFilter: React.FC<EventsFilterProps> = ({
  isFreeEntryCheckked,
}) => {
  // component:
  return (
    <Chip
      label="Free entry"
      color="primary"
      variant={isFreeEntryChecked ? "filled" : "outlined"}
      onClick={() => setIsFreeEntryChecked(!isFreeEntryChecked)}
    />
  );
};
```

The chi

# Hooks

Hooks let you define behavior when something happens, without writing too much logic. See [documentation](https://reactjs.org/docs/hooks-overview.html)

Two rules:

- Can be called by the top-level (not inside loops), or by other hooks

## UseState

Allows you to define state that your app will use.

## UseEffect

`useEffect` allows us to define some effect needing to happen every time React re-renders the UI (see [this](https://reactjs.org/docs/hooks-overview.html))

See the [official documentation](https://beta.reactjs.org/reference/react/useEffect)
