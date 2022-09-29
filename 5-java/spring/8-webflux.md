# Webflux

What is Webflux? Webflux enables Java applications to efficiently use their CPUs.

## The problem

How a normal application works:
- A TCP connection arrives
- Server socker bund (from OS to Web server)
- The requests asks the app to get one of the 200 threads it has available (this can be blocking)
- Once it is available, the application code is called
- Then, the thread might be blocked uselessly when it could do something else, more useful:
  - some REST API :point_right: this can cause delays, as we are waiting for I/O!
  - waiting for the DB to do some work
  
Webflux sorts this out


# 1 - Marshaling

Webflux also uses Marshaling of data -the same as Netty does-, which means that it splits a given request of into small pieces -so that a 1GB request does not take 1GB of memory- to ensure the Memory usage is optimized. Rather than loading the data, once it is available, Webflux pushes it to the network -and ensures it gets combined.

Webflux does this with `Flux` element -a series of the same element-: will enable performing actions one-element-at-a-time (such as storing one item to the DB) rather than waiting for a given quantity.

```java
public Mono<String> realWebFlux(long teacherId) {
    trye{
        log.info("Sending bearer: JOKE");
        Mono<String> stringMono = WebClient.create()
            .get()
            .uri(new URI(reacherBioUriBase + "/api/teachers/" + teacherId + "/bio"))
            .bodyToMono(String.class)
            .doOnNext(body -> log.debug("Got back response : " + body));
        } catch () {
            // ..
        }
}
```

## `Mono` class


[Mono](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Mono.html) is the Webflux equivalent of a Promise, or future. It is a container which tells to the subscriber that one single element will be returned at some point. The computation can happen at that moment.

A `Mono` will return one -and only one- of these three:
- An object
- Void
- An error


> :exclamation: Do not use `Mono` and `Flux` variables.

> :thought_balloon: Use `Mono<Void>` if you want a reactive function that returns nothing. 

> :exclamation: methods returning `Mono` and `Flux` need subscribers! If the method is created but noone subscribes to it, it will not do anything.

## `Flux` class

[Flux](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) is a series of equal objects, which can be processed one-at-a-time. Webflux will submit the objects one-at-a-time so that computation can happen.

## Working with Webflux objects

We can add callbacks to `Mono` and `Flux` objects, such as `doOnTerminate()`, or `then()`, which does some action after the object was propagated.

Example of adding a filter -clean coding :sparkles:- to count the time a request took to process:

```java
public class HttpFilterToCountTime implements WebFilter {

    public Mono<Void> filter(...) {
        return chain.filter(exchange)
            .then(Mono.deferContextual(context -> {
            System.out.println("took" + (currentTimeMillis() - (Long)context.get("t0")));
            return Mono.empty();
        }))
        .then()
        .contextWrite(context -> context.put("t0", currentTimeMillis()));
    }
}
```

## Caching Webflux objects

If we need caching, we should make sure that we cache the _values_ of the `Flux` rather than the Flux itself. We need to use Webflux caching for that.

Here is an example of the syntax:
```java
@Cacheable("languages") // This caches the Flux itself (Spring magic) - still useful to ensure we do not create many fluxes
@Logged
public Flux<ProgrammingLanguage> findAll() {
    return repo.findAll()
        .doOnSubscribe(s -> log.debug("Get langugaes"))
        .cache(); // This caches the values of Flux, telling subscribers the values are available already
}
```

> :thought_balloon: check the documentation of Flux.cache :point_right: [here](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html#cache--).


## Keeping connections open

We can use the `@Tailable` annotation to keep the connection -to an HTTP stream, or to the database- open, and keep listening to incoming records:
- Note that this might cause us to have too many connections open with the DB, for example, we need to add extra monitoring.
