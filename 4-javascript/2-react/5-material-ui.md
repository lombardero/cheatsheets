# Material UI

- [Material UI](#material-ui)
- [Common components](#common-components)
  - [Chip](#chip)
  - [Box](#box)
  - [Stack](#stack)
  - [Icon button](#icon-button)
- [General components](#general-components)
  - [Theme provider](#theme-provider)
  - [App bar](#app-bar)

[MaterialUI](https://mui.com/material-ui/getting-started/overview/) is a very useful library which introduces a large set of commonly-used UI components such as top-bars, buttons, sliders, and more (see docs) that we can reuse in our application.

Use `yarn` to install it, see the command [here](https://mui.com/material-ui/getting-started/installation/).

# Common components

## Chip

Chips are callout buttons that can be "enabled" or "disabled". Syntax goes like this:

```tsx
<Chip
  label="Free entry"
  color="primary"
  variant={isFreeEntryChecked ? "filled" : "outlined"}
  onClick={() => setIsFreeEntryChecked(!isFreeEntryChecked)}
/>
```

## Box

A wrapper of `<div>` allowing to add extra properties.

## Stack

Stack allows us to create a horizontal display of sub-elements.

## Icon button

Example syntax:

```tsx
<IconButton
    onClick={(event) => {
        event.preventDefault();
        onFavoriteButtonClick && onFavoriteButtonClick();
    }}
    onMouseDown={(event) => event.stopPropagation()}
>
```

- `onMouseDown`: Material UI allows us to perform some action when we [press a button in the mouse](https://www.w3schools.com/jsref/event_onmousedown.asp). In the above example, we are preventing an effect.

# General components

## Theme provider

Material UI provides a default (blue) theme. The Theme can be overrided by overriding the context introduced by Material UI. This is done in `App`:

```tsx

const App: React.FC = () => {
    const theme = createTheme({palette: {primary:{main: "#e1171e"}}});

    return (
        <ThemeProvider theme={theme}>
            <App>
        </ThemeProvider>
    )
}
```

## App bar

Classic horizontal bar at the top of the page.
