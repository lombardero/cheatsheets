# Routing

Routing refers to the URL of a page which loads a specific component. See [this official resource](https://angular.io/tutorial/toh-pt5).

The 2 most important components of a route are:
1. the Path
2. the Component

## The Routing outlet

The routing outlet is an angular object which enables to define the routes of a component. Any component can have one:
```ts
const routes: Routes = [
    {
        path: 'path-of-first-component',
        component: FirstComponent,
        children: [
            {
                path: 'child-a';
                component: ChildAComponent,
            },
            {
                path: 'child-b',
                component: ChildBComponent
            },
        ]
    }
]
```

### Base routing outlet

The base routing outlet is the one that is used by the Main application component.

> :exclamation: for the routing to work, the `routing-outlet` component needs to be declared in the root of the app (`app.component.html`):
> ```html
> <routing-outlet></routing-outlet>
> ```

The `app-routing.module.ts` file defines which components to load at which path. Example:
```ts
const routes: Routes = [
    { path: 'heroes', component: HeroesComponent }
];
```

### Redirecting & default route

Adding routes to your app:
- Find your routing module
- Add your route (JS object with "path" & "component" -> Order is important here, first match wins)


Can add a "redirect" (needs to be last) route:
```ts
const routes: Routes = [
    {
        path: "not-found",
        component: NotFoundComponent
    },
    {
        path: "**",
        redirectTo: "not-found"
    }
```

### Adding parameters to route

```ts
const routes: Routes = [
    {
        path: 'first/:id',
        component: FirstComponent
    }
```
- The first component can then access the `id`

### Lazy loading

Lazy loading allows Angular to only download the code for a route at the moment it is requested. Keeps the initial bundle size small. Useful for large applications with lots of routes

```ts
const routes: Routes = [
    {
        path: 'customers',
        loadChildren: () => import('./customers/customers.module').then(m => m.CustomerModule)
    },
]
```
- Lad the `CustomerModule` only when the customer URL is loaded

### Redirecting though a component

We can also create a "hyperlink" by making a component call the router to move to a given URL

```ts

export class FirstComponent {
    constructor(private router: Router) {}

    toUrl() {
        this.router.navigate(['next-url']);
    }
}
```

### Route gards

Route guards are functions run before navigating to a specific guard. If the guard returns false, navigation to that route is cancelled. It prevents routes from being accessed when they should not be, for example if data not loaded or user without permissions

### Router links

Router links can add links to routes with `routerLink` directive (kind of a hyperlink). Takes the path as an argument

```html
<div class="header">
    <a routerLink="/first">First</a>
    <a routerLink="/second">Second</a>
</div>
```
