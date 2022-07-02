# Refactoring

# 1 - Refactoring

Bad code is usually written in PoC, to start up a project and get feedback on it. After
some time, when we know the code will stay for a long time, we should refactor it to
make it readable.

## How to refactor

You start with code

If it is too big, create methods out of it

If these methods are still too big, turn them into classes that share an interface

## 1.1 When to refactor

- Continuously! Boy-scout rule

> Boy scout rule: always leave the campground cleaner than you found it. Frequenntly
> read code gets continuously better (small). For ex: rename small variable.
> - Make sure to trace all the calls of a function! (Brute-force the search, your IDE
> might be missing a call!)

- Before adding an important feature: once you have understood the code you are about
  to change


### Refactoring a deep "if" field

Refactoring:
- Put "guard" conditions -> Things that make the function raise an exception at the start to avoid distracting the user
- Return directly rather than setting a  `result` local variable and then return it

### Refactoring for loops

Refactoring:
- Avoid `continue` (ignore the rest) statements by an `else`
- Break the for loop into pieces, and replace them by streams (like list comprehensions) -> Do the transformation "on the go" `list.stream()...`

### Refactor function arguments

To refactor a method with bad arguments:
1. Define a method with the same name as the one refactored, but with a different signature
2. Call the refactored method from the old one
3. Use Inline: `Refactor > Inline...` in IntellIJ to correct all old calls of the function to the new
4. Get rid of old function

> Note: The Inline functionality pushes the body of a function upstream.

### Refactoring classes that are too big

How to split a class:
- By functionalities
- By depth: separate unrelated entrypoints

## 1.2 Refactoring to-dos

- Do not be afraid! You need to simply overcome the fear to break things and create a mess!
- Do use `Ctrl-Z`! Revert your changes! (Even if you have worked on it for 6h+)
- Use the Mikado method :)
  - Try to implement the prerequesite naively
  - Try -> Fail?
  - Try again with a simpler prerequisite until succeed
  - Start again
- Use IntellIJ! [See this](https://www.youtube.com/watch?v=ZiOMQRujfMM)

> IntellIJ (or PyCharm) has many great commands to refactor code, use them!
> - Install SonarLint (connected to CI pipeline) and have it check the code
> - Install KeyPromoter X to learn shortcuts
> - Challenge: do the trivia kata
> - Challenge: No mouse for a week!

# 2 - Code smells

- Defining variables "up" in the file, far away from where the variable is used
- Deep functions: big "if" trees
- Booleans in functions that activates or deactivates some logic

## Classic code smells

- **Code Smell #1: Stuff that grew too big**:
  What is a large function? A function larger than your screen. A good rule-of-thumb is:
  - Method: 
    - max max 20 lines -> Can you break it down more?
    - maximum depth 2 or 3
    - extract as much as possible
  - Class:
    - less than 200 lines
  - Lambda:
    - more than a one-liner (if >1 line, it deserves a name!)

- **Code smell #2: Primitive obsession**
    Rather than using primitive types such as `Long`, `String`, etc. Use `record` for commonly used types that represent a given thing.
    - Too much arguments call

Rather than:
```java
// With primitives
redeemCoupon(Long, Long);

// With records
record customerId() {
}

redeemCoupon(customerId, productId);
```
- Much readable! (It does eat a b)

## Rules-of-thumb
- Forget about micro-optimizations. They are not needed 99% of the time
- Do not use Tuples for stuff of more than a line! Use [`record`](1-4-records.md) instead. Check how to refactor [here](#refactor-function-arguments).
- Use deep arguments that make business sense. Do not use generic types in a flat model: use objects!
- DTOs are not changeable! You can modify the internal model
- Identify reusable structures and make them models or `record`, add generic functionality to it if needed
  - When you see pieces of data coming together (ex: `start & end`, `firstName & lastName`, etc. -> Join them!)
> In IntellIJ: `Refactor > Introduce Parameter Object`, tell IntellIJ which arguments to group in an object

### Adding functionality to object

Adding behavior next to state (adding methods to a `record` or a data class) is a good practice as long as the record is generic and reusable.

Adding rules to the model is a good practice as long as

```java
record Interval(int start, int end) {

    // Good as it makes sense to add this restriction
    Interval {
        if (start > end) throw new IllegalArgumentException("Start is larger than end!")
    }

    // Good method as it makes sense for the interval.
    public boolean intersects(Interval other) {
        return start <= 
    }
}
```

#### Rules-of-thumb

**Pushing logic into objects**
Do not push logic into objects if:
 a. logic uses dependecies (calls API, repository, other service) Only logic on the object state is allowed
 b. The logic is large (eg 30 lines) and highly specific -> This should be done in the service. Only use small and reusable bits of logic!

**Fields inside objects**
Rule-of-thumb: 20 fields seems a bit too much, they probably can be grouped or br

# 3 - Code principles

## 3.1 General coding principles

- SRP! Single-responsibility principle
- KISS: Keep it Short and Simple
- Keep your code readable today so that you can find the performance bottleneck tomorrow!
- Avoid deep call stacks (function calls, if statemnts, etc.). For that:
  - kill too small functions that add depth
  - separate getting inputs (imperative sheel) and pure functions
- Do not anticipate future features too much; clean dead code first
- Every function should have a verb (except private ones -> ?)
- Think about classes in a responsibility angle: what does it do?
- Think about what objects should be exposed to the outside world
- Interfaces: delete them! 4 only exceptions:
  - Remote API (when you expose it to some other system)
  - Strategy pattern
  - Decorator
  - Test Implementation (is best ro use a mocking framework)
  - Dependency Inversion
- Use the different variable names for things that mean different (sometimes the state changes the use of a variable!)
- Valid reasons to put comments:
  - links to wikis for complex stuff
  - library code that other unknown devs will use (as a Javadoc)
  - warnings ("do not try optimization X")
  - performance tweaks

### Architecture coding principles

- If things stick together:
  - they change together (make it the same class /argument) -> create an "update" together
  - they belong together (create a Class)
  - present it together in the UI

- Feature Envy: (behavior outside of the data class) stick behavior that belongs to state together (keep logic close to the class it belongs)
- Avoid adding presentation and infrastructure-related logic in objects. Keep objects:
  - as close to business logic as possible
  - as clean from anything else as possible

### Syntax good practices

In Java 17, if you need to do some computation based on an enum, you can define the enum on-the fly by doing `return(switch(enum))`:
```java
return (
    int price = switch (movie.getPriceCode())) {
    case FANTASY -> 7;
    case SCIENCE_FICTION -> 9;
}
```

## 3.2 Code smells

### Detailed

- Use as tiny refactoring steps as possible
- Splitting a for in two won't harm performance
- Do not use headless lambdas (without name)
- Use Pure functions! (No passing callables as arguments)
- Prefer little data structures with fields
- Use streams rather than for loops
- No booleans in arguments
- Keep call stacks in class flat
- Keep functions flat (1-2 tabs deep max)
- Keep logic next to state! OOP
- Use guard clauses to avoid deep functions (throw/return trivial cases out right from the start)
- Immutable types avoid dirty fixes by mutating state deep in a flow
- Do not change DTOs
- A function that changes stuff should return void
- Do not couple (add dependency b/w classes) for things that change usually! Do couple it if it makes sense
- Initialize variables outside of constructor if possible
- Never change the state of an object outside of it. Keep state close to logic! Use a method to do that!
- Do not use Checked Exceptions in Java
- Avoid `return;`, `throws`, `break;`, `continue;`
- Do not use Optionals as parameters for functions! Only as return values
- Do not use booleans as parameters enabling/disabling code for functions either!

### Immutability

Never use:
- Mutable data in hard-core flows :skull:
- Mutable data with multi-threading :skull:

Solution:
- Immutable objects (Do not make them too large - eats a lot of memory)

> We need to create a new class if we want to modify something, to do that,
> we create a "whither"

#### "Wither"

Withers enable us to create a new immutable class with a different field in a less verbose syntax:
```java
class Immutable {
  @With
  private final int x;
  private final int y;
}

Immutable oldImmutable = new Immutable(3, 5);
Immutable newImmutable = oldImmutable.with(4); // Creates a copy of `oldImmutable` changing one field
```


## 3.3 Hands-on stuff

### Using variables
Constants
- Lterals shared with other systems (add them as Enums!)

### Not-to-do

- Never do computations (non-pure functions) after boolean expressions (`||`). This is very error-prone
