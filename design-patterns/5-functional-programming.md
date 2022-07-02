# Functional programing

## Introduction

Functional programming core values:
- Immutabile objects
- Pure functions: it will transform the input, return something but not change anything else (ex: internal state, call something else). This enables:
  - Function can be called many times (ex: a getter from an immutable object)

> The idea of functional programming is to avoid the case where
> swapping functions' order would break the functionality (no compiling) -> bad. An immutable way of doing this is -> Instead of changing the object, return a copy of the object changed (return a new one)

## Architecture

Separate your application in two parts:
- Functional core: core logic of your application -> complex. Keep it purely functional. Do not mutate stuff
- Imperative shell: all the DB calls HTTP requests, keep it isolated -> just get it, and pass it as a parameter to the functional call -> call functions to return a result, then, if needed, call the imperative shell again

> Rule-of-thumb: whatever is very complex deserves to be functional (no access to DB, mutate objects). Never set values!

## Code smells

- Avoid taking a function as a parameter AND returning one (either one or the other)
- Excessive chaining: Break long chains of `.filter(...).map(...)` by creating variables to explain your code!
  - Rule-of-thumb is: break every 3-4 operators!
- Never use Optionals in function arguments! `Optional`s were introduced to be used as return values

