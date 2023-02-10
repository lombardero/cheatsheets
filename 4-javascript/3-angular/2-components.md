# Components

Components are building blocks of Angular applications. Each one as has a TypeScript class, an HTML tempate, and its own CSS scoped specifically by default

```ts
import { Component } from '@angular/core';

@Component({
    selector: 'app-product',
    templateUrl: './product.component.html', // the HTML
    styleUrls: ['./product.component.scss'] // the CSS files
})

export class ProductComponent {}
```

Components need to be declared in the

```html
<div class="main">
    <>
```

Adding a product throught the CLI

```sh
$ ng g component <name>
```

## Decorators

`@Input()`
- Tells angular that this property will be passed by the caller via the template

`@Output()`
- Defines event handlers that callers can hook into

## Component types

- Smart components: contain business logic


```html
<>
<app-person [name]="person.name" [age]="person.age">
```

## Synchronization

Angular automatically handles synchronization, meaning that it makes sure that it keeps everything is sync (objects, etc.)

Angular re-renders the whole UI tree every time something changes (default strategy). For example, every time an input changes. This can be slow, so components have this strategy. For example:
- `ChangeDetectionStrategy.OnPush`: this will re-render the object again ONLY if a new object is passed into the component (not if a property changes). This option should be used by default (for performance). It can be a bit tricky

## Lifecycle hooks

- `ngOnInit`: it is a method used in Components that runs after the constructor (once variables have been loaded)
- `ngOnDestroy`: runs before Agular cleans the component (good to do housekeeping, clean event streams, etc.)
- `onOnChanges`: runs frequently (runs every time every time something changes)
