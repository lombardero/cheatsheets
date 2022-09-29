# Spring concepts

- [Spring concepts](#spring-concepts)
  - [Learning spring](#learning-spring)
  - [Sping Annotations](#sping-annotations)
  - [How does it work](#how-does-it-work)
  - [Spring weaknesses](#spring-weaknesses)

Spring is a framework, not a library, as you do not control it, it controls you! It controls the way you must write your application.

Spring was born to avoid needing to declare all the objects your code uses, in order to reduce boilerplate code. It injects dependencies; the main thing you need to do as developer is to wire the dependencies together.

## Learning spring 

Leaning spring:
- Spring in action (book)
- Udemy for spring certification
- baledung.com
- Lighter version of the Spring docs :point_right: [here](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/).
- [Eugenp tutorials](https://github.com/eugenp/tutorials)
- Best way of learning spring: remove annotations from your code, and try re-adding them all Googling

## Sping Annotations

Spring works with the below annotations:
- `@Service`: business logic (domain rules)
- `@Repository`: DB access
- `@Controller`: not used anymore, old way of generating webpages
- `@RestController`: REST APIs
- `@Configuration`: contains `@Bean` definitions, not application code

 objects and injects them i dependency injection, it 

> 🫘 Beans are classes managed by the Spring framework. The `@Bean` annotation tells spring a method returns a Bean class to be managed by Spring. If the `@Bean` annotation is used, the class returned by this method will be automatically injectable by spring.

> :thought_balloon: Annotations are not compiled; the compiler does not care about them, they are only used by Spring to wire the code and compile it! 

> :exclamation: do not:
> - use `getBean` to get a class, let Spring manage the code
> - use `ApplicationContext`, let Spring manage the injections. It adds risk

## How does it work

Spring works by instantiating a base class `SpringBootApplication`, whose sub-classes (those who are in the sub-packages, called `@Bean`s) are automatically discoverable -detected by the framework, and injected.

> :thought_balloon:  Ways of starting a Spring application:
> - Create a `CommandLineRunner` which has a `run()` method
> - Create an `@EventListener` and react to some event, ushc as `ApplicationStartingEvent` (sent by default by Spring)

## Spring weaknesses
- Long startup time (20-40 seconds) vs Quarkus (everything is at compile-time + native image > executable code with startup time in <1second : fast elastic scale up). In Spring, elastic scale up is slower (has a boot time of 30 seconds)
- Everything happens at runtime (proxies): which makes is slightly less performant, a very long startup time, and ugly stack traces
- Implicit magic: marketing :point_right: "look how easy it is! Integrate with Kafka in 40 minutes"
