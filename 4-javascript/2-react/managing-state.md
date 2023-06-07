# Managing State

- [Managing State](#managing-state)
- [Using state](#using-state)
  - [Passing state to child components](#passing-state-to-child-components)
- [Hooks](#hooks)
  - [UseState](#usestate)
  - [UseEffect](#useeffect)

Stateful components are those requiring to remember some state. In general, that happens when we aim to change parts of the display based on user input.

For example:

- a check-box, which needs to remember whether it is in checked state or unchecked
- a button triggering a title change
- a filter to display a set of entries in a list view. Let's build a filter that displays:

# Using state

We will need to import `useState` React hook.

`useState` allows us to create a "special" variable which will trigger re-rendering of the component. This function returns two elements -which it expects us to define:

- the name of the variable
- the setter fuction name of the variable (note that once this is called, the change will be scheduled, but not yet effective, might take some ms)

```tsx
import React, { useState } from 'react';

type EventsFilterProps = {};

export const EventsFilter: React.FC<EventsFilterProps> = () => {
  // State:
  const [title, setTitle] = useState(props.title);

  const clickHandler = () => {
    setTitle('Hehe');
    console.log('Title changed to Hehe');
  };

  // component:
  return (
    <div>
      <h2>{title}</h2>
    </div>
    <button onClick={clickHander}>Change Title</button>
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
