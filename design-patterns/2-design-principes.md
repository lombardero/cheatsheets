# Design Patterns

Table of contents:


Design patterns are a way to protect your code against future changes. Make it simple, enable future changes.

> KISS: Keep it short and simple!

> DRY: Don't Repeat Yourself principle!

> :thought_balloon: Read about [Coupling & Cohesion](https://www.geeksforgeeks.org/software-engineering-coupling-and-cohesion/)

> Check [this GH link](https://github.com/victorrentea/clean-architecture.git), branch `Endavamkd2022_6`

> :thought_cloud: Architecture is the art of drawing lines (separating dependencies)

## Summary of principles

- SRP: keep your classes and methods focused on one thing (apply this when classes/methods start to grow)
- DRY: Do not duplicate business logic!
- Separation by Layers of Abstraction: clean up the high-level logic. Separate layers of abstraction
- Deep Inversion Principle: domain knows nothing about infrastructure
- Avoid Inherintance: favor composition to reuse behavior
- Loosely Coupled Design: easier to reason and test
- Prefer Stateless Classes: logic should not have state (:warning:), it prevents sneaky bugs


# 1 - Coupling

In software design, we want loosely coupled objects. They are robust, mentally simpler, and most importantly: testable!

> Ideally, a good rule-of-thumb is to not mock more than 2-3 classes in unit tests.

You want your code to be used by many, but not dependent on much (or any).

> :japanese_ogre: Tightly coupled dependencies are bad (lots of dependencies) because it is hard to test. High coupling is the reason why many software projects die.

## 1.1 Layered architecture

We want an architecture that works in layers. Which means: the calls come one service downstream to the other. No circular calls

> :thought_balloon: The Controller calls the Service, but not the other way around.

Your Service should not know if you change the way you interact with your DB.

> :exclamation: be very string with this!

### How it is typically done

Typical java layers:
- Controller (API or web layer): gets requests from users
- Service: is called by the Controller
- Repository: is called by Service to -for example- call the DB

> :thought_balloon: If one layer is too complicated, you should add an additional layer. Example: breaking a tightly-coupled Service layer (typically the most coupled) in two:
> - Facade: orchestration layer -should be as thin as possible- that calls the Service object (maybe many at-a-time).
> - Service: a set of logic "cubicles" that are not too dependent and are called by the Facade

Again: work in layers of abstraction! Think about what each layer does, and stick to it.

> Another way of splitting a big application is vertically (by topic), but that only solves scalability issues

### DTOs and Internal entities

Never make your internal entity -your most precious resource- be aware of the DTO coming from the API! This breaks the Onion responsibility principle! - Now your service is aware of your Controller! -> Never do that!

> :exclamation: Always decouple DTOs (Data Transfer Objects) and Domain Entities

> :thought_balloon: You could make your DTOs know about your entities though, but it depends on the Architecture. If you have control over those classes.

> :japanese_ogre: Bad solutions:
> - Auto-generated mappers (like Yolo): maps DTOs and entities with the same name. Bad because devs will try to keep both entities in sync

> :sparkles: Good solution: manual mapping! Construct the object

### Naming services

Use verbs! Services do things. No `CustomerService`, but `CustomerRegistrationService`.

### The flow of logic

We have a set of requirements from business; these transform into logic into the service. From 5 to 10% of that logic can be added to the entities (if it makes sense and it belongs to it). The rest can be taken by the service and facade


## 1.2 OOP Principles

### Encapsulate what varies

Isolate rapidly changing parts of your system! Do not make your code depend on it! Put it out of the class, package, module or even microservice!

### Program to Abstractions

Depend on abstractions rather than implementation. What really matters is the idea!

> :thought_balloon: "Abstractions should create a new semantic level in which to be absolutely precise" - Dijkstra
> - This means that we should think in abstractions, and be precise and simple in our design. At the end, Computer Science is the art of building complexity out of simple things.

Also: avoid deep classes that have parents, grandparents, etc. Go horizontal rather than vertical in dependencies.

Two types of abstractions:
- Low level (I/O, networking, etc)
- High level (Business rules)

### Favor composition over inheritance

```java
// Do this -> More testable
class Duck {
    private Fly fly;

}

// Avoid this.
class Duck extends FlyingAnimal {
}
```
- Only extend abstract classes


Avoid overriding inherited concrete methods (methods from a class that is not an interface)! It is hacking, unexpected, and kills code! It is unexpected that the children change the logic.
- Exception: when you are hacking frameworks :) -> But never in our own code!


# 2 - Cohesion

Highly cohesive code is code that puts together functionalities that belong together. Which means -> Smaller classes with one single role.

> :exclamation: Single Responsibility Principle: most important principle in CS!

## 2.1 DTOs are evil

DTOs contain legacy fields, extra information, weirdly-named fields. Do NOT transfer names or logic from the DTOs into the code!

DTOs are:
- Bloated (many fields)
- Flat
- Different perspective (might be used for different things)
- Anemic
- Unconstrained

In our code, we want:
- Small, cohesive data structres
- A deep domain model
- Names tailored to our problem


> :exclamation: Do not implement complex logic on foreign data structures! (Foreign = from other teams)

### Calling external APIs

Use an `Adapter`! Hide an ugly foreign API from the rest of your code.

> :thought_balloon: An adapter offers to the rest of the code a better API that protects our code from the outside world.

Adapters depend on the infrastructure (which makes our code depend on it). To sort this out, we use Dependeny Inversion!
- We let our code define an Interface of how we expect our API to behave
- We define an Adapter that IMPLEMENTS that interface :sparkles:

> Think about what needs to know about what!


## 3 - The Clean Architecture

## 3.1 - SOLID principles

### Before we start: weaknesses of SOLID

SOLID is great! But also requires being used the right way. If over-used, it can favor over-engineering.

Weaknesses of SOLID:
- It take time to refine (very hard to get it right the first time); for that, the code needs continuous refactoring based on the constantly burgeoning new use-cases
- Unclear level of granularity (should we apply these on the class level? method? all?). Needs thinking through, depends on the case
- More retroactive (after you wrote code) than pro-active

### Sorting these out

To sort these out:
- Use [SRP](#s-single-responsibility-principle-srp) and [OCP](#o-open-closed-principle) when refactoring, AFTER your code covers some of the use-cases (do not code thinking of a future it might never happen)
- Use [ISP](#i-interface-segregation-principle-isp) when your API grows big
- Use [DSP](#d-dependency-inversion-principle) when logic starts being messy

> :bulb: To solve these issues, see the Rules of simple design


### S: Single Responsibility Principle (SRP)

:scroll: This rule says that a component should have one responsibility.

But what does this mean? Is it a class, a module, a microservice?

> :bulb: SRP can be applied to everything

Best way to apply SRP is best applied after we really understood the problem, even after we made our code work!

> :exclamation: Avoid extending concrete -non abstract- classes!

### O: Open-Closed Principle

:scroll: Open for extension, but Closed for modifications.
- "Make your code modular"

This means: write your code so that it can be extended -adding behavior- without editing existing code. Open an API inside of the code enabling components, make it modular :jigsaw:! Leave holes for things that modify.
- For example, `IntellIJ` enables us to extend or change its functionality with 3rd party packages without needing to rebuild the whole product.
- Example: different types of warehouses with the same picking logic

> :bulb: Think about plugins! Think about use-cases for your code

### L: Liskov Substitution Principle

:scroll: Subclasses should fulfill the full contract of their superclass.
- "Do not extend, and if you do, be careful to not breaking the parent class contract"

> :warning: avoid as much as possible to inherit from concrete classes! Try doing so only from interfaces
> - Use `implements` in favor of `extends`

```java

class Rectangle {
    //...
}

class Square extends Rectangle {
    // Bad practice!
}

// Because:
Rectangle r = new Square();
r.setWidth(2);
r.setHeight(3); // what should happen here? (exception?) -> We are not expecting this
a = r.getArea(); // What is the response? 9? 6?
```
- This pattern is broken: as the contract between `setWidth`, `setHeight` and `getArea` is now broken

### I: Interface Segregation Principle (ISP)

:scroll: Multiple small interfaces are better than a single large one.
- "Use one interface per client"

> :though_balloon: Use an interface per use-case. De-couple use-cases and teams using that API.

Think about what to expose to whom. Different clients might have different needs:
- Expose what is necessary (not too much)
- Separate interfaces by use-case / by client where possible (de-couple dependencies!)

> :bulb: Use ISP when faced with heavy clients needing a lot of data or interactions. Make interfaces client-specific.


### D: Dependency Inversion Principle

:scroll: High-level plolicy -the precious Domain model- should not depend on low-lever functionality.

> :exclamation: The Domain model is where the core business logic of your application sits, safeguard it!

> :thought_balloon: Identifying what constitutes the domain model of an application is the main challenge.
> - The Domain Model is where the "core" business logic of the application sits. The "infrastructure" is the low-level functionality.

The Domain Model is the most precious part of the code, it should not depend or know about the Infrastructure (low-level functionality).


:scroll: 5 rules on your domain model; it should:
- not care about the UI (how you present the data)
- not care about the Database (avoid vendor lock-in,)
- be independent of external APIs
- be testable on its own!
- be independent of Intrusive Frameworks
  - Not all frameworks are bad. Moslty, frameworks that can change over time (frameworks that cause pain to switch) or that are too intrusive and lock your architecture to it.


> :bulb: You can add a unit test that checks in every module that you are not importing any external packages -> to enfoce allowed dependencies

## 3.2 - The Rules of Simple Design


:scroll: Rules of Simple design (by Kent Beck) - by importance:
1. If you write serious tests, you design cannot be bad. Write more tests! The earlier the better
   - Most important rule! If your code has many unit tests, your get instant feedback on the code.
   - Instead of thinking about the code: spend time writing more tests!
   - :exclamation: Any line of code changed should make a test fail!
2. Code should express intent (SRP): the names used in the code should match what business wants
3. There is no duplication (DRY)
4. Minimalistic: KISS, YAGNI (do not add any additional unnecessary code). Only if it helps with (2)
- Keep It Short and Simple
- You Ain't Gonna Need It!

> :thought_balloon: All the design patterns in the world can be condensed in these two:
> - SRP: your code should express itself
> - DRY: do not repeat yourself!

## 3.3 - Aspect-Oriented Programming

The problem:
- I want to do the same operation (e. g. logging it) before every action


The idea:
- Abstract-away behavior from the users by intercepting calls


> :japanese_ogre: Need to be careful about using AOP, it might hide unwanted calls (example of hidden extra DB call before all DB calls because of this) -> Careful!

### Proxy pattern

Proxy: a placeholder intermediating interactions with an object.

> A Proxy should intercept a method call and add a functionality to it.


Example: extending `sum` to log something for it:
```java
// Caller code
class MyCode {
    private final Math math;
    
    public void method(){
        System.out.println(math.sum(1, 2));
    }
}

// Original code.
class Math {

    public int sum(first int, second int){
        return first + second;
    }
}

// Proxy.
class MyMathProxy extends Math {

    private final Math math;

    public int sum(first int, second int){
        // My added functionality.
        System.out.println("This is my added log statement!");
        math.sum(first, second);
    }
}
```
- Now the proxy can be used in the caller code instead of `Math` with the added functionality

> :bulb: This is what Spring does actually: adding extra functionalities through Proxies

Let's say we have an Interface that a method calls. We want to add functionalities to that call. A proxy implements that interface, calling the real method but adding functionality.


> :thought_balloon: The idea of proxies is that noone should be aware it is there

### Decorator pattern

The decorator pattern adds functionality to other classes by calling it explicitly. For example, turning a `List` into an `unmodifiableList`.

> :though_balloon: Decorators still call the same code, but here the user is aware of that functionality.
