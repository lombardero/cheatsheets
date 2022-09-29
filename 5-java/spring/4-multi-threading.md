# Multi-threading

Check [this](https://github.com/victorrentea/spring/tree/master/spring-app/src/main/java/victor/training/spring/async) example.

- [Multi-threading](#multi-threading)
- [Using `@Async`: the problem it solves](#using-async-the-problem-it-solves)
  - [Optimization 1: adding futures](#optimization-1-adding-futures)
  - [Optimization 2: adding control to the threadpool](#optimization-2-adding-control-to-the-threadpool)
  - [Optimization 3: return the future](#optimization-3-return-the-future)
- [Using `@Scheduled`](#using-scheduled)

# Using `@Async`: the problem it solves

Let's say we have different servers serving different data, modelled by this barman which pours drinks:
```java
@Service
public class Barman {
   public Beer pourBeer() {
      log.debug("Pouring Beer (SOAP CALL)...");
      ThreadUtils.sleepq(1000);
      return new Beer();
   }
   public Vodka pourVodka() {
      log.debug("Pouring Vodka (REST CALL)...");
      ThreadUtils.sleepq(1000);
      return new Vodka();
   }
}
```

And a client interested in getting both elements the server gives:
```java
@RestController
public class DrinkerController {
   @Autowired
   private Barman barman;

   // TODO [1] inject and submit work to a ThreadPoolTaskExecutor
   // TODO [2] mark pour* methods as @Async
   // TODO [3] Build a non-blocking web endpoint
   @GetMapping("api/drink")
   public DillyDilly drink() throws Exception {
      log.debug("Submitting my order");
      long t0 = currentTimeMillis();

      Beer beer = barman.pourBeer();
      Vodka vodka = barman.pourVodka();

      long t1 = currentTimeMillis();
      log.debug("Got my drinks in {} millis", t1-t0);
      return new DillyDilly(beer, vodka);
   }
}
```
- This, in this state, will take 2 secons to get the data, as the calls are blocking (The problem)


## Optimization 1: adding futures

We solve the issue by doing do two requests in two different threads from the client side by adding futures, like this:
```java
// Server
@Service
public class Barman {
    @Async
   public Beer pourBeer() {
      log.debug("Pouring Beer (SOAP CALL)...");
      ThreadUtils.sleepq(1000);
      return completedFuture(new Beer());
   }
   @Async
   public Vodka pourVodka() {
      log.debug("Pouring Vodka (REST CALL)...");
      ThreadUtils.sleepq(1000);
      return completedFuture(new Vodka());
   }
}

// Client
@RestController
public class DrinkerController {
   @Autowired
   private Barman barman;

   @GetMapping("api/drink")
   public DillyDilly drink() throws Exception {
      log.debug("Submitting my order");
      long t0 = currentTimeMillis();

      // Adding futures.
      CompletableFutur<Beer> futureBeer = supplyAsync(() -> barman.pourBeer())
      CompletableFutur<Vodka> futureVodka = supplyAsync(() -> barman.pourVodka())

      Beer beer = futureBeer.get();
      Vodka vodka = futureVodka.get();

      long t1 = currentTimeMillis();
      log.debug("Got my drinks in {} millis", t1-t0);
      return new DillyDilly(beer, vodka);
   }
}
```

This method has a problem: the global JVM has only 9 threads on its threadpool, and every future consumes one. If threads are busy, by using this method, it could be that the threads are exhausted and the whole application waits for one of the future calls to come back :fire:.

## Optimization 2: adding control to the threadpool

To avoid running-out of threads, we can increase the quantity of them in the code. But that adds another challenge: we are now supplying control of the threadpool size to the quantity of calls to `api/drink` (if 100 calls, 200 threads open! :boom:)

```java
// Server
@Service
public class Barman {
    @Async
   public Beer pourBeer() {
      log.debug("Pouring Beer (SOAP CALL)...");
      ThreadUtils.sleepq(1000);
      return completedFuture(new Beer());
   }
   @Async
   public Vodka pourVodka() {
      log.debug("Pouring Vodka (REST CALL)...");
      ThreadUtils.sleepq(1000);
      return completedFuture(new Vodka());
   }
}
// Client
@RestController
public class DrinkerController {
   @Autowired
   private Barman barman;

   @GetMapping("api/drink")
   public DillyDilly drink() throws Exception {
      log.debug("Submitting my order");
      long t0 = currentTimeMillis();

      // Fixing number of threads our application can use.
      ExecutorService pool = Executors.newFixedThreadpool(2);

      CompletableFutur<Beer> futureBeer = supplyAsync(() -> barman.pourBeer())
      CompletableFutur<Vodka> futureVodka = supplyAsync(() -> barman.pourVodka())

      Beer beer = futureBeer.get();
      Vodka vodka = futureVodka.get();

      long t1 = currentTimeMillis();
      log.debug("Got my drinks in {} millis", t1-t0);
      return new DillyDilly(beer, vodka);
   }
}
```

To avoid that, it is better to use a `ThreadPoolTaskExecutor` bean configured and injected by Spring, and add it to the client. We can even add the qu
```java

// Enabling threads for each use-case
@EnableAsync
@Configuration
public class AsyncConfig {

    @Bean
    public ThreadPoolTaskExecutor beerPool(@Value("${beer.pool.size}") int barPoolSize) {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(barPoolSize);

    @Bean
    public ThreadPoolTaskExecutor vodkaPool(@Value("${vodka.pool.size}") int barPoolSize) {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(barPoolSize);
    }
    }
}

// Server
@Service
public class Barman {
   @Async("beerPool") // Spring creates a proxy, injects the thread pool
   public Beer pourBeer() {
      log.debug("Pouring Beer (SOAP CALL)...");
      ThreadUtils.sleepq(1000);
      return completedFuture(new Beer());
   }
   @Async("vodkaPool") // Spring creates a proxy, injects the thread pool
   public Vodka pourVodka() {
      log.debug("Pouring Vodka (REST CALL)...");
      ThreadUtils.sleepq(1000);
      return completedFuture(new Vodka());
   }
}

// Client
@RestController
public class DrinkerController {
   @Autowired
   private Barman barman;

   @GetMapping("api/drink")
   public DillyDilly drink() throws Exception {
      log.debug("Submitting my order");
      long t0 = currentTimeMillis();

      // Fixing number of threads our application can use.
      ExecutorService pool = Executors.newFixedThreadpool(2);

      CompletableFutur<Beer> futureBeer = barman.pourBeer();
      CompletableFutur<Vodka> futureVodka = barman.pourVodka();

      Beer beer = futureBeer.get(); // This waits until the future beer is collected! It is blocking!
      Vodka vodka = futureVodka.get();

      long t1 = currentTimeMillis();
      log.debug("Got my drinks in {} millis", t1-t0);
      return new DillyDilly(beer, vodka);
   }
}
```
This has a problem still: the `futureBeer.get()` is blocking! Meaning: it blocks the thread until the future is available

## Optimization 3: return the future

```java
// Client
@RestController
public class DrinkerController {
   @Autowired
   private Barman barman;

   @GetMapping("api/drink")
   public DillyDilly drink() throws Exception {
      log.debug("Submitting my order");
      long t0 = currentTimeMillis();

      CompletableFutur<Beer> futureBeer = barman.pourBeer();
      CompletableFutur<Vodka> futureVodka = barman.pourVodka();

      // Combine both futures!
      CompletableFuture<DillyDilly> futureDilly = futureBeer.thenCombine(futureVodka)

      long t1 = currentTimeMillis();
      log.debug("Got my drinks in {} millis", t1-t0);
      return futureDilly; // We return the future, and free up the thread!!
   }
}
```

# Using `@Scheduled`

Scheduled tasks Spring cronjobs, they run every X amount of time.

Syntax:
```java
@Scheduled(cron = "*/5 * * * * *")
public void lookIntoFolder() {
    // ...
}
```

Use-cases:
- Clear local cache: not the best use-case because there can be collisions (delete cache that was just created and is needed) Better: use timestamps for entry and remove automatically (example :point_right: [Ehcache arch](https://www.ehcache.org/documentation/2.7/configuration/data-life.html))
- Retention policy in the DB (ex: every 10 min, delete data older than 1h ago)
- Pull some data from other service
- Alive checks: "health" checks for external API; for apps under our control, we use Spring Boot Actuator!

