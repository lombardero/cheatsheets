# Project Reactor

Reactor is a Java library which enables reactive programming.

Check out [this](https://www.baeldung.com/reactor-core)

:point_left: Instructor's GH [here](https://github.com/OlegDokuka/reactive-programming-course-preview)

# Publishers

## Mono & Flux

Monos and Fluxes are generators of data. They are the core elements in reactive programming. Both are objects that will return data asynchronously in the future.

### Mono

`Mono` objects guarantee that they will return one message maximum. It "promises" all its subscribers to emit zero to one messages to any subscriber. Once a message was sent, the subscriber will unsubscribe from the publisher, as it promised a max of 1 element to be sent (anything extra the publisher sends will be discared).

### Flux

Fluxes are generators
Methods returning `Flux` types guarantee that it will deliver zero to infinite messages to its subscribers. We can add `onNext(value)` for every incoming value from the flux, and do `onComplete()` when it finishes, or `onError()` when it fails.

The particularity of Flux, is that many messages might be required for them to complete.

## Generating vs Creating

There is an important between _creating_ `Flux` or `Mono` and _generating_ them. (See [this](https://www.baeldung.com/java-flux-create-generate))

### Generating

Generating Fluxes or Monos is

### Creating

A very simple data-generating `Flux` (or `Mono`) can be created, for example with `.delay()`

```

```

## Generating values

It is important to make the data producers generate data

### Defer

`Mono.defer(callable)` and `Flux.defer(callable)` make sure that the execution of the callable only happens when there are subscribers.

# Transformations

There are synchronous and asynchronous transformations.

## Async Transformations

- `.flatMap(Function<T, Publisher>)`
- `.concatMap(Function<T, Publisher>)`
- `.switchMap(Function<T, Publisher>)`
- `.then(Publisher)`
- `.filterWhen(Publisher)`
- `.skipUntilOther(Publisher)`
- `.scanWhen(Publisher)`
