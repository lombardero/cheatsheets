# Routing in react

[React Router Dom](https://reactrouter.com/en/main) is a library introducing routing.

It works by introducing a `BrowserRouter` component, we need to wrap our app with. Using JSX, we define which components to load on each route.

## React routing
```jsx
<BrowserRouter>
    <AppBar position="sticky">
        {/* Something */}
    </AppBar>
    <Routes>
        <Route path="/" element={<Navigate to="/events" replace={true} />} />
        <Route path="events" element={<EventStcreen />}/>
        <Route path="events/:id" element={<EventDetails />}/>
    </Routes>
</BrowserRouter>
```
- `Route` can be used to define:
  - Which components to load when a given endpoint is called
  - Redirects

> :bulb: React Router is smart enough to know it needs to load subsets of the page, meaning the whole page

## Links

We can use the `Link` element to redirect
```tsx
<ButtonBase component={Link} to {"events/" + event.id}>
```
