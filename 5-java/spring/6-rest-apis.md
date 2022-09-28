# REST APIs with Spring

## Rest Controller

The `@RestController` will handle all requests sent to the `@RequestMapping("url")`, example syntax:
```java
@RestController
@RequestMapping("api/examples")
public class ExampleController {

    @Autowired
    private ExampleService exampleService;

    @GetMapping public List<ExampleDto> getAllExamples() {
        return exampleService.getAll()
    }

    @GetMapping("{id}")

}
```

### Validating user input

It is considered good practice to validate the Dtos the user adds. Those validations should not be scattered in the code.

The way validations work in Spring is by using a a `@Validated` annotation when a value is passed, and then defining those validations as annotations such as `@NotNull` in the object.

See example syntax:
```java
// Caller code
public void createExample(@Validated ExampleDto dto) throws ParseException {
    if (exampleRepo.getByName)
}

// Dto definition
public class ExampleDto {
    public Long id;
    @NotNull // Valida the name 
    @Size(min = 3, max=50)
    public Sting name;
}
```

> :bulb: Validations can be turned on and off based on the flow (by using `@Validated(ExampleDto.ForCreateFlow.class)`), for example, to enable validation only for the create flow.

### Creating a search endpoint

Spring comes with a "search" functionality built-in, which enables to understand search criteria off-the-shelf on the query. Spring will translate that into a filter to the known records

```java
@GetMapping("examples")
public List<ExampleDto> search(ExampleDto dto) {
    //...
}
```

### Passing a body


A more complex search might need a `POST` call :(, as `GET` does not accept body. We use `@RequestBody` to look for the `ExampleDto` in the `@RequestBody`
```java
@PostMapping("examples")
public List<ExampleDto> search(@RequestBody @Validated ExampleDto dto) {
    //...
}
```

