# Dierctives

Directives add additional behavior to elements

Attibute directives:
- directives that change the appearance or behavior of an element

```html
<div [ngClass]="isSpecial ? 'special' : ''">
```

Structural directives:
- directives that change the DOM by adding and removing DOM elements (if, for, switch statements): `ngIf`, `ngFor`, `ngSwitch`

```html
<div>
```

We can also create our own directives (not very common), used for example to ignore the second tap if it came very close in time to the first

```html
<div *ngFor="let person of persons">
    ...
<>
```

## Pipes

Pipes are functions you can use in templates (using -duh!- a pipe `|`). For example: `uppercase`. Pipes can also take arguments:
- See [this](https://angular.io/guide/pipes-overview).

```html
<div>Price: {{ price | currency: 'EUR'}}</div>
```

Pipes can be also defined (usually for very custom data). They are used to transform data and they should not have side effects! (Just a quick and simple transformation)

