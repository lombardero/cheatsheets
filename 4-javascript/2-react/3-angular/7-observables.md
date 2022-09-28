# RxJS

Check out the [Academind article](https://academind.com/tutorials/understanding-rxjs) on `rxjs`

# Observables

Observables are an implementation of the observer pattern. Most common use-case is to have several components react to incoming HTTP calls.

To listen to an observer, one must `.subscribe` to it passing the following callables:
- `next: (value: ) => ...`
- `error: (err) => ...`

> :exclamation: Subscriptions to observers should always be cleaned up. Subscribers provide a "Subscription" object, which we should store and clean up when the component is done. 

> Alternatively, we can use a pipe to automatically subscribe
> ```html
> <div>
>   Value: {{ value$ | async }}
> </div>
>
> <!-- Alternatively-->
> <div *ngIf="value$ | async as blue">
>   Value: {{ blue.hello }}
> </div>
> ```

## Pipe functions

We can chain operations in values returned by observers by using `.pipe()` (before we subscribe to the observable):
- `map(value => ...)`: Does an operation to the value
- `mergeMap()`: Does an operation keeping all previous values (useful to get information from two HTTP requests, for example)
- `concatMap()`: Do one thing at a time (only start we)
- `flatMap()`
- `switchMap()`
- `tap(value => ...)`: Does an operation with the original value ignoring all transformations (useful for logging the original value received, for example)
- `take(value)`: takes a given number of values returned from the observable
- `takeUntil(...)`: waits until a certain amount of values got received

```ts

```

# Subjects

Subjects are types of observables that emit events, and allow to notify something has happened.


- `ReplaySubject(number)`: Get the X last events emitted by the observers 
