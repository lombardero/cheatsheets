# Spring Internals

- [Spring Internals](#spring-internals)
- [1 - Caching](#1---caching)
  - [Types of Caching](#types-of-caching)
  - [When to use caching](#when-to-use-caching)
- [2 - Transactions](#2---transactions)
  - [When are transactions needed](#when-are-transactions-needed)
  - [`@Transactional` on a method](#transactional-on-a-method)
  - [Behind-the-scenes of transactions](#behind-the-scenes-of-transactions)
    - [Exceptions in transactions](#exceptions-in-transactions)
    - [Starting a transaction from a failed transaction](#starting-a-transaction-from-a-failed-transaction)
  - [After-transaction hooks](#after-transaction-hooks)
  - [Transactional events](#transactional-events)
  - [Debugging transactions](#debugging-transactions)


# 1 - Caching

In Spring, anything returned by a method is cached, that might cause problems, for example, if we save something to the DB and want to retrieve it with a method (might retreive a previously cached value). 

In the background, Spring caches the data in a map per returned type:
```java
@Cacheable("all-teachers") // Gives a name to the cache. This defines a Map<Nothing, List<TeacherDto>> allTeachers;
public List<TeacherDto> getAllTeachers() {...}

@CacheEvict("all-teachers", allEntries = true) // Deletes the cache... But careful, without allEntries=true, it only deletes the cache for signatures that match!
public void createTeacher(TeacherDto dto) {...}
```
- This code will only work with `allEntries = true` flag (which blows up the entire `"all-teachers"` cache map)

## Types of Caching

Two ways of caching:
1. Let Spring manage it with `@Cacheable`
2. Do it yourself with a `CacheManager` class (you build it)
## When to use caching

Questions before to ask before caching data:
- Does the data change? NO: Cache
  - YES:
    - How often does it change? (Lot of cache trashing?)
    - Can we find out when it changed?
      - YES
        - a) the changes go through the application. Happy path :point_right: use `@CacheEvict`
        - b) can we listen to events? (register event which does `@CacheEvict`)
      - NO
        - Unhappy path, question: for how long can I lye to my users? (Use a timer to evict cache)
    - Am I deployed in multiple nodes?
      - YES: choose a distributable cache: `redis` (saves the cache in a redis DB instead of memory), `hazelcast`, ...
- Do we need it often enough?
- How often does it change?
- How expensive (time/money) is to retrieve that data?
- Does it fit in my memory?

> :thought_balloon: Cache types (e.g. `redis`) can be defined in the application configuration. The code won't change, but in the background, the caching mechanism will.

> :thought_balloon: There are two main soutions to distribute cache across instances:
> 1. Distribute instances by requests that go together (e.g. for a WCS, one instance per area) a smart load balancer, which knows to which instance to send each request
> 2. Use a `redis` database for distributed caching
> 3. Build your own synchronization protocol :skull:


# 2 - Transactions

A transaction must be ACID:
- Atomic: "all-or-nothing" either all INSERT/UPDATE/DELETE succeed, or none. It can succeed on its entirety, or fail, not partially.
- Consistent: after the transation, the constraints (Foreign keys valid, Not nulls, checks) are respected
- Isolated: only committed changes are seen (two transactions runnin concurrently cannot see the changes of each other)
- Durable: after commit, everything is written in the DB

> :information_source: Spring applications have a configured connection pool of 10 connections with the DB, meaning only 10 connections can be done in parallel. Can be changed configuring it: `hikari.maximum-connection-size`.

## When are transactions needed

- Atomic changes to DB
- Testing

## `@Transactional` on a method

Using `@Transactional` on a method: transforms the method call into a transaction, which means all code inside the method either succeeds or fails. This annotation is used for database calls. Note that transactional calls propagate, meaning that a transactional method which calls another, will make that method also transactional. The use-case for this is mostly database-related (JDBC).

> :information_source: The transactions only commit at the end of the transaction method call.

Example:
```java
@Transactional
public void sendMoney(Person sender, Person receiver, int Amount) {
  sender.decreaseMoney(Amount);
  receiver.addMoney(Amount);
}
```
- Makes sure both `sender.decreaseMoney` and `receiver.addMoney` either succeed or fail.
- If something fails (such as, some DB constraint is not respected), Spring will make sure the transaction is rolled back

> :information_source: Nested transactions use the same transaction. Meaning: a `@Transactional` method calling another `@Transactional` method will be run in the same transaction (meaning: second annotation has no effect - unless we handle exceptions). This also means that if one of them fails, the whole transaction fails.

## Behind-the-scenes of transactions

A new transactional call is started:
- Spring sees no transaction on current thread
- It acquires a database connection from the connection pool
- Opens transaction with auto-commit is false
- Stores JDBC connection on current thread
- Failure/success of current transaction will decide if changes are committed

### Exceptions in transactions

Database exceptions kill transactions, but not all exception types might do! :boom:

> :boom: Checked exceptions going through a `@Transactional` proxy do NOT kill the current transaction! Only Runtime exceptions do. This is considered a VERY BAD standard; comes from what the EJB library did (Spring competitor - 2005).

> :information_source: Catching exceptions might be used to avoid the transaction being rolled back, but that needs careful understanding of transactions, as it might behave differently depending on how nested Transaction calls are structured.

### Starting a transaction from a failed transaction

If we want to start a transaction when our transaction fails (for example, when an exception is raised), we can use another `@Transactional` call, with a `Propagation.REQUIRES_NEW` option, which will then start another transaction (grab a different connection, and commit changes).

> 🧟 A transaction that "failed" (raised an exception) will not be committed, but still walks, still will execute things -even if changes won't be committed. It can still -for example- open a new transaction with `Propoagation.REQUIRES_NEW` and do something.

> :information_source: Everything you do within your thread will reuse the same JDBC connection with a transaction open on it. We can enable a call in a different call with an `@Async` annotation (note that Async should be enabled)

## After-transaction hooks

This feature enables to execute some code (such as communicating the transaction was successful), after the transaction succeeds. Use `@TransactionalEventListener(AFTER_COMMIT)` for this, to do cleanup

## Transactional events

We can also perform this functionality as after-transaction hooks with `@TransactionalEventListener(phase = TransationPhase.AFTER_COMMIT`; the listener will only listen to the event if the transaction was successful. For this, the event emitter must be inside of a transaction.

## Debugging transactions

How to find out when a transaction started?
- Check for the first `@Transactional` annotation in the code
- Use `p6spy` and check logging
