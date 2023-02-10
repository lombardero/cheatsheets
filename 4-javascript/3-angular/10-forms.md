# Forms

# Template driven forms

Check [this resource](https://angular.io/guide/forms-overview).

Simpler to add than reactive forms, controlled by a template. Not as scalable. 

# Reactive forms

Check [this resource](https://angular.io/guide/reactive-forms).

Reactive forms allow to change the display of a UI dynamically as the user types something in. It is done through direct access via the underlying form.

The model is defined in the component class with `FormControl` or variations of such. Angular has built-in validator


### Reactive form example

We add a form control in the component with this code:
```ts
export class AppComponent {
    favoriteColorControl = new FormControl('', [Validators.required])

    ngOnInit() {
        // the value passed can be gethered here
        this.favoriteColorControl.valueChanges.subscribe(value => {
            console.log(value);
        })
    }

    // We can also set the value to the controller
    setColorToBlue() {
        this.favoriteColorConttroller.setValue('blue');
    }
}
```

> :excalamention: the form control can change anything from the object at runtime. The user controls everything. Super useful! (e. g. to make a filtered list of products change as you add new fields)

We can also access the value throught the HTML:
```html
Favorite color: <input type="text" [FormControl]="favoriteColorControl" />

<p *ngIf="favoriteColorControl.valid"Valid></p>
<p *ngIf="favoriteColorControl.invalid"Invalid></p>
```

## Data flow

The data flow can go from user to component, such as:
- User types the input
- Input element emits latest value
- `FormControl` emits that value on `valueChanges` observable
- Subscribers get the latest value


It also can go the other way around:
- Value changes programmatically in component
- `FormControl` emits new value through `valueChanges` observable
- Subscriber get latest value
- The form element updates with latest value

## Form Groups

We can create a group of controllers for a complex input (e. g. Name, surname, street, city...)

```ts
{
    userControl = new FormGroup({
        name: new FormControl(''),
        address: new FormGroup({...})
    })
}
```
