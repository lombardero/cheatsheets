# Testing

## Testing Microservices

The pyramid of testing (unit test - component - UI) is getting overriden as we migrate to microservices. Our aim here test entire flows as much as possible, but these are feature-based, testing an entire flow without minding which microservice we care about, from the API perspective :point_right: check Honeycomb testing.

Note that Microservices should contain the _right amount_ of complexity.

# 1 - Testing in Spring

We have several ways of testing applications with external dependencies -such as data needed in the DB:
- Using mocks (`@Mock` / `@MockBean`)
- Using a test container with the DB (`@Testcontainers`)

Annotations:
- `@SpringBootTest`: loads test in a Spring context
- `@Testcontainers`: starts a Docker container with Junit, uses it in the test
- `@Transactional`: Wrap each test case in a transaction, and rolls it back once it is completed. Super nice! Does not apply changes to external resources such as DB, and ensures a clean state after the test (no cleanup needed).

Syntax (incomplete):
```java
@SpringBootTest // Load spring
@Testcontainers // Use the test container
@Transactional // Use transactions for test cases.
public class ProductServiceTest {

    @Container
    static public PostgreSQLContainer<?> foo() {...}
}
```

## Isolating test cases

Some tests might have secondary effects -such as adding data to the mock DB. To avoid that, we need to make sure our test starts with a clean state. For example: cleaning the data in the DB _before_ our test starts.

We can do that with the `@BeforeEach` annotation:
```java
@BeforeEach
final void before() {
    supplierRepo.deleteAll();
    productRepo.deleteAll();
}
```

BUT, best solution is to use `@Transactional` annotation for the test class :point_right: this will enable each test case in the class runs in transactional mode, meaning the changes will not be committed to the Database!
- :boom: Note that this will not work to test code that breaks the current transaction and starts a new one, as it will not see the changes from the previous transaction.
- Also note that the tests should work in one signle thread and one signle transaction

## Mockin beans

Mock bean replaces the Mockito objects in spring. But remember: use it carefully. `@MockBean` requires a special test context, which means that a new "test Spring" will boot for this annotation to work.
- `@MockBean` should either be used in all test cases, or not used at all

## Optimizing Spring Boot tests

What to do to speed tests:
- Tune the JVM: `-ea -mx2g -noverify -XX:TieredStopAtLevel=1`
- Reuse between test classes (Spring context)
- Parallelize :point_right: see [this](https://www.baeldung.com/junit-5-parallel-tests).
- Move slower tests to the night build `@Tag("nightly")`

Other optimizations:
- Disable parts of Spring :poin_right: check [this](https://spring.io/blog/2016/08/30/custom-test-slice-with-spring-boot-1-4).
  - If not testing with REST, annotate with `@SpringBootTest(webEnvironment = NONE)`
- Lazy-load only tested beans with `spring.main.lazy-initialization=true` (not so helpful if testing everything)

