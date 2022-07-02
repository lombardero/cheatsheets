# Design patterns

Table of contents:
- [Design patterns](#design-patterns)
  - [Practical use of Patterns](#practical-use-of-patterns)
    - [Use them when](#use-them-when)
    - [Do not use patterns when](#do-not-use-patterns-when)
    - [Anti-patterns](#anti-patterns)
- [1 - Observer pattern](#1---observer-pattern)
- [2 - Command pattern](#2---command-pattern)
  - [2.1 Rest vs Messages](#21-rest-vs-messages)
      - [What to use when](#what-to-use-when)
  - [2.2 Command vs Event](#22-command-vs-event)
    - [Orchestration vs Choreography architecture](#orchestration-vs-choreography-architecture)
- [3 - Strategy pattern](#3---strategy-pattern)
  - [Strategy pattern using `switch`](#strategy-pattern-using-switch)
  - [Strategy pattern using a `Map`](#strategy-pattern-using-a-map)
- [4 - Chain of Responsibiltiy pattern](#4---chain-of-responsibiltiy-pattern)
  - [CRP Practical example](#crp-practical-example)
- [5 - Visitor pattern](#5---visitor-pattern)
  - [Use-case example](#use-case-example)
- [6 - State pattern](#6---state-pattern)

## Practical use of Patterns

### Use them when

Where do we use design patterns in patterns:
- Micro-design patterns, usually used in application code (we use it in our day-to-day life):
  - Adapter/Facade: used to orchestrate the code, and make the caller of the code only see its "Facade", a nice interface to the deeper details
  - Passign a Block (Loan)
  - Strategy
  - Factory Method
  - Decorator
- Used by frameworks (less common, we usually do not implement those)
  - Factories
  - Singleton
  - Proxy (Spring uses this heavily, many frameworks)
  - Chain of Responsibility (Filters, usually used by HTTP request libraries to filter requests)
  - Decorator
  - Visitor
- Macro-design patterns (usually intra-system):
  - Observer/Command
  - Choreography/Orchestration (how do microservices talk to each other)
  - Saga

### Do not use patterns when

- Chain of Responsibility: do not use when the filters rarely change, or are few
- Strategy: do not use when the alternative logic is small or if the API is drametically different
- Adapter: do not use when the data conversion is trivial or not too complex (use a separate methid)
- Template: do not use if the missing step is a simple piece of logic -> Pass a function
- Proxy: do not use if you need to wrap code just wound several method
- Never use Builder with immutables (that means your design is weak). Use immutables :sparkles:

### Anti-patterns

Never do:
- The "God class", the blob, swiss army knife
- The Spaghetti code (too many and unclear dependencies)
- The "Lasagna" (over-engineered, too many layers and not enough "meat" on each)
- Circular dependencies (merge them and split what needs)
- The Bike Shed Effect: do not spend too much time thinking about the code, simply do it and move on (refactor it later)

# 1 - Observer pattern

The observer pattern is a class whose role is to observe messages and forward them to any listeners by iterating through them.

Key points:
- The observer should not know about the listeners (nor the order in which they subscribe)
- Multiple listeners can receive the same event (called topic in CS -> the term "topic" assumes more than one receiver)
- Chain events when their order matters (use trace IDs to ease debugging!)

> :warning: Observers cannot ensure any type of order in which listeners receive events. If we need order, we should do event chaining (events trigger events)

```java
public class ObserverInTheNeighborhood {
}


class OldLady {
    private final List<Listener> listeners = ner ArrayList<>();

    public void addListener(Listener listener) {
        listeners.add(listener);
    }

    public void findOutSmth(String gossip) {
        for (Listener listener : listeners) {
            listener.notify(gossip)
        }
    }
}

interface Listener {
    void notify(String gossip)
}
```

Typical uses:
- UI
- Framework hooks
- inter-app messaging

> :thought_balloon: Spring uses an extreme version of the Observer pattern, one in which no part knows about the listeners. Services sending an event do not know who will listen to it. 
> - This has a problem: we cannot ensure order -> To sort this out, we use event chaining! (Services calling each other) 

> :warning: Debugging is hard with events. When services talk to each others with events, it can be hard to identify why a certain piece of code was called with certain parameters. To sort that out, we use trace IDs or [Spring Sleuth](https://spring.io/projects/spring-cloud-sleuth) (which traces calls with such IDs).

# 2 - Command pattern

:scroll: Encapsulate an instruction into a `Command` object so that these can be queued and executed in a thread pool. This allows:
- Handling traffic spikes
- Send the command to some other service (scaling-up applications)
- Undo that command (this is what IntellIJ and Word uses to do `Ctrl + Z`)

> :thought_balloon: This solves spikes in traffic, such as for black friday. This pattern allows to "queue" requests and serve them when the service is ready.

## 2.1 Rest vs Messages

> :exclamation: Te Command patten turns REST calls into Messages. Let's compare them.

REST:
- Rest is simple
- but also Syncronous and block threads (unless we are we are using reactive programming)
- Contention: load spkes can kill a server
- It is Fast,
- But also Unreliable

> :warning: If REST APIs are called one after the other (a rest call triggers the service to do another rest call, etc.) it can slow down the system quite a lot, or even worse -> Some rest calls might be lost!

Messages (`Command` pattern)
- Messages are not blocking (threads, or memory -> Send it, and forget it)
- Are harder to deal with (more complex) but asyncronous
- Are naturally load-balanced
- Also fast
- Guaranteed delivery (whereas REST might not be -> Can be lost)

#### What to use when

:white_check_mark: Use Rest for reading data
- Usage spikes can take you down
- Retryable endpoints must be idempotent (debounce duplicates via unique client request ID)
- Common-sense algorithims ("just received a second order with same details")

:white_check_mark: Use Queues to send critical updates:
- Send Command messages instead of Posts
- Events are less coupled
- Or even better, use Event-Carried State Transfer (event contains all data a service needs to perform an action):
  - Can go back in time
  - Can check "what if" conditions

:white_check_mark: Move from Choreography to Orchestration in complex flows.
- Centralize coordination and automatic error recovery ([Saga pattern](https://microservices.io/patterns/data/saga.html))
- Systems should receive Commands and reply with Events

> :scroll: Event-Carried State Transfer architecture (send events with state - kind of like `git`): 
> - produce events with all the information systems will ever need (e. g. new stock created in the warehouse, new order made by a customer). Allow applications to subscribe to such events
> - keep a log of those events: applications which need can get back the information they lost without needing other systems
> - This allows:
>   - to go back in time
>   - check "what if" conditions


## 2.2 Command vs Event

The command pattern can be used in two ways, based on the two ways we can structure Messages (in-app): either in Events or Commands. 

Here is the difference:
- an `Event`: indicates something happened in the past
  - can have many receivers,
  - structure is defined by publisher
- a `Command`: instruction to do something in the future
  - only has a single receiver,
  - structure is decided by receiver

### Orchestration vs Choreography architecture

The control of "what runs when" in applications can have two approaches: Orchestration (one single component decides), or Choreography (no clear leader).

:violin: **Orchestration** architeture works with a "Boss", a Service Facade, which controls which services are called at which time.

:dancers: **Choreography** architecture does not have a Facade, it has decentralized control (services call each other).
- :warning: What happens if a call fails? Handling becomes decentralized, it becomes quiite nasty with nested calls (use trace IDs)


# 3 - Strategy pattern

:scroll: Select the algorithm dynamically at runtime.
- Separate different ways of performing a task by adding an interface and selecting the implementation at runtime (e. g. sorting, heuristics, handling a mesage, sending a notification, load config...)

> :thought_cloud: In Java, we would usually use `switch`, in `python` usually a dictionnary with a lambda

Another example of use-case of Strategy pattern: selecting a sorting algorithm at runtime based on the input data (one might be faster based on the data type)

## Strategy pattern using `switch`

Example: compute the Customs Tax for an order given the country.
- Once the logic becomes quite heavy, we can consider every country needs its own class. We can use a `switch` clause to select the implementation based on the country code input at runtime
```java
// Caller code:

class CustomsService {
    public double calculateCustomsTax(String originCountry, int tobaccoValue, int regularValue) {
        TaxCalculator calculator = switch (originCountry) {
            case "US" -> new USTaxCalulator();
            case "FR", "ES", "RO" ->  new EUTaxCalculator();break;
            default -> throw new IllegalArgumentException("Not a valid country ISO2 code: " + originCountry)
        };
        return calculator.calculate(tobaccoValue, regularValue);
    }
}


interface TaxCalculatorInterface {

    public int calculate(int tobaccoValue, int regularValue);
}

class EUTaxCalculator implements TaxCalculatorInterface {

    // Price to pay for polymorphism, some arguments might not be needed for some of the classes
    public int calculate(int tobaccoValue, int regularValue_NotUsed)
    // 50+ lines of code
}

class USTaxCalculator implements TaxCalculatorInterface {

    public int calculate(int tobaccoValue, int regularValue)
    // 50+ lines of code
}
```


## Strategy pattern using a `Map`

This can also be achieved using a map, however:
- :warning: This might be worse because you get a `NullPointerException` if the country code is invalid
- :lightbulb: Maps however allow us to define that mapping (country code - tax calculator) in configuration :party_popper:! This is the reason why we might want to use them istead of `switch`
```java
class CustomsService {
    private static final Map<String, Class<? extends TaxCalculator>> calculators = Map.of(
        "US", USTaxCalculator.class,
        "FR", UETaxCalculator.class
    );

    public double calculateCustomsTax(String originCountry, int tobaccoValue, int regularValue) {
        TaxCalculator calculator = calculators.get(originCountry);
        calculator.calculate(tobaccoValue, regularValue);
    }
}
```

Using configuration to externalize the association (we can change this without touching the code :party_popper:)
```yaml
tax.calculators:
    ES: tech.example.strategy.EUTaxCalculator
    RO: tech.example.strategy.EUTaxCalculator
```

# 4 - Chain of Responsibiltiy pattern

> :exclamation: also called `filter` travel

:scroll: Each *filter* can process a request, or not
- We ask different parties weather we care about a call or not

> :thought_balloon: This pattern works as follows: a component gets a request, see if it has something to do about it, and if so, do it. Examples:
> - Using different filters (as transformations) to compute the final price of a product -depending on many inputs-

It has:
- Low coupling (each filter does not care who follows it)
- :warning: Order can matter (applying multiple filters)


Implementation forms:
- `.accepts(work):Boolean`: (for example, using a `match` function -> see [example](#crp-practical-example))
- `.process(work) {work.done=true}`: used by Internet Explorer in handling events (clicks)
- `.doFiler(work.chain) {chain.doFilter(...)}`: what web filters do in spring
- `.process(work) {work.veto()}`: this is how security works

## CRP Practical example

Let's see an example of how we can use the chain pattern to reduce the logic exposure of the `TaxCalculator` exposed in [point 3](#3---strategy-pattern)

> :bulb: Note that we can also use the [OCP](2-design-principes.md#o-open-closed-principle) principle by pushing the definition of the country inside of the `TaxCalculator`

 ```java
 class CustomsService {
    public double calculateCustomsTax(String originCountry, int tobaccoValue, int regularValue) {
        TaxCalculator calculator = allCalculators.stream()
           .filter(c -> c.match(originCountry))
           .findFirst().orElseThrow();
        return calculator.calculate(tobaccoValue, regularValue);
    }
}

 interface TaxCalculatorInterface {
 
   public int calculate(int tobaccoValue, int regularValue);

   boolean match(String countryCode);
 }

 @Component // This will make spring Inject this class as a component
 class USTaxCalculator implements TaxCalculatorInterface {

    public int calculate(int tobaccoValue, int regularValue)
    // 50+ lines of code
   boolean match(String countryCode) {
       return "CN".equals(countryCode); // Yoda annotation to avoid NullPointerException
   }
}
 ```

# 5 - Visitor pattern

:scroll: Encapsulate an operation on different element types in one class, by enabling such element types to be "visited", by adding an `accept(Visitor)` method.

> :warning: The visitor pattern is one of the most dangerous patterns, it does add several restrictions. Avoid when possible

> :exclamation: Also called the "double dispatch" pattern, because the polymorphism goes two ways (the way of the visitor, and of the sub-types enabling)

> :thought_balloon: It is similar to some sort to the [Composite pattern](https://refactoring.guru/design-patterns/composite), where objects pass themselves in methods


When to use it:
- when we can't change the data model (maybe it is owned by someone else?)
- When the classes we want to add the behavior are too big, and we want to avoid extending them
- Feature added implements lots of shared code cross-class (DRY). We might consider the logig of this specific feature belongs in a class of its own rather than be separated in the sub-classes

> :thought_balloon: In Java, the visitor pattern makes sure that we implemented the logic for all sub-types of the class (compiling will fail otherwise)

> :bulb: In Java 21, this problem will be sorted with `sealed interface` (which will enable only a certain amount of sub-classes), and `switch(Class) {case(SubClass)}`

## Use-case example

Let's say we want to compute the total perimeter of a set of shapes. The perimeter is computed in different ways. The usual way of working would be to change the `Shape` interface, adding a `getPerimeter` method which is implemented by each class. Let's assume that this is not possible (because, for example, these classes come from our client). Here is where the Visitor pattern can help us: every time a new type of `Shape` is created (all the shapes need to implement the `accept` method), the compiler will fail if the visitor did not implement the logic for one of the classes, guarding from forgetting to add it.

```java
// Our code using the objects
public class VisitorPlay {

    public static void main(String[] args) {
        List<Shape> shapes = Arrays.asList(
            new Square(10),
            new Circle(5),
            new Square(5)
        );
    }

    public double getPerimeter() {
        double totalPerimeter = 0;
        PerimeterCalculatorVisitor perimeterCalculatorVisitor = new PerimeterCalculatorVisitor();
        for (Shape shape: shapes) {

            // The visitor gets passed into the shapes, accumulating the perimeter
            shape.accept(perimeterCalculatorVisitor);
        }
        return perimeterCalculatorVisitor.getTotal();
    }
}


// This is what we need to build
public interface ShapeVisitor {
    
    void visit(Square square);

    void visit(Circle circle)
}


// For that, the objects must accept a visitor:
public class Square implements Shape {

    provate final in edge;

    public Square(int edge) {
        this.edge = edge;
    }

    // The objects are passed the visitor, and the visitor gets the object back
    public void accept(ShapeVisitor visitor) {
        visitor.visit(this);
    }
}


// Now, we can build a visitor with some logic based on the object type that called it:
public class PerimeterCaculatorVisitor implements ShapeVisitor {

    private double total;

    @Override
    public void visit(Square square) {total += suqare.getEdge();}

    @Override
    public void visit(Circle circle) {totall += circle.getRadius()*Math.PI*2}

    public double getTotal() {return total;}
}
```

# 6 - State pattern

:scroll: Extract-away the behavior of the code depending on state in a separate class.

> :thought_balloon: The state pattern is very useful when objects in the code transition between states, and the code behavior depends on such state


The state pattern acts like a shopping cart in a supermarket -those with a coin-, it can be in a locked state or an unlocked one:
- The interface has two methods: lock and unlock (following the shopping cart metaphor: "put coin" or "try to push")
- When the state is "locked", putting coin will unlock it, and trying to push will not do anything (the locked object will be returned)
- When the state is "unlocked", the opposite happens

Let's see an example:
```java
interface ShoppingCartState {

    public ShoppingCartState coin();

    public ShoppingCartState push();
}


class LockedState implements ShoppingCartState {
    @Override
    public ShoppingCartState coin() {return new UnlockedState();}

    @Override
    public ShoppingCartState push() {return this;}
}

class UnlockedState implements ShoppingCartState {
    @Override
    public ShoppingCartState coin() {return this;}

    @Override
    public ShoppingCartState push() { return new LockedState();}
}
```
