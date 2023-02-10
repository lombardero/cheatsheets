# Reactive basics

Understand reactive with rxmarbles.com

# Why Reactive?

Reactive Programming is a paradigm which uses declarative code (similar to functional programming) in order to build asynchronous processing pipelines. It is an event-based model where data is pushed to the consumer, as it becomes available: we deal with asynchronous sequences of events.

Main ingredients:

- Functional programming - usually simple
- Large ecosystem - docs, libraries
- Performance for high I/O tasks
  - Non-blocking (async)
  - Streaming :sparkles:

The reactive approach enables to take the most out of the CPU to make sure it is used where needed (similar to `asyncio`). It is designed to enable concurrency.

When reactive does not work:

- CPU-bound tasks
- Sequential processing

# What is reactive based upon?

## Observer

Reactive is based on the `Observer` pattern, which is good for Efficient Async Push. However, it brought some issues:

- Not sure where does the call stack end
- Not clear how to unsubscribe
- Composition is hard

## Iterator

Since streaming deals with sequences of events, hence we reactor is based on `Iterator`

# Reactive in Java :coffee:

## Library #1: Reactive

Reactive combines Observer + Iterator to generate the below main interfaces:

- `Observable`: producer

  - `subscribe()`

- `Observer`: consumer

  - `onNext`
  - `onError`
  - `onComplete`

- `Subscription`:
  - `unsubscribe()`

It also adds a bit of Functional pepper in the recipy as design choice.

## Library #2: Reactive streams

Originally, in Java :coffee:, reactive streams started as a different library

- `Publisher`:

  - `subscribe()`

- `Subscriber`: consumer

  - `onNext`
  - `onError`
  - `onComplete`

- `Subscription`:
  - `cancel()`
  - `request()`

## Reactive systems

Reactive systems are Message Driven: which makes it resilient & elastic

### Resilient

The way of making distributed systems resilient:

- Isolation: isolate pieces :point_right: a component is isolated if it can work without requiring another service
  - Use circuit breakers, timeouts, fallbacks, default values
- Pieces must provide a fallback -error handlers- if they fail (what to do if things fail)
