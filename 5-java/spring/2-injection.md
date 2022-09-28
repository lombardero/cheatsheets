# Injections

Follow [this](https://github.com/victorrentea/spring).

How dependency injections work using Spring. As mentioned in the intro, Spring uses annotations to wire the code together.

# 0 - Injection types

### Method injection



### Constructor injection

# 1 - Beans

Beans are ways of configuring classes in Spring. The `@Bean` annotation is used in methods which:
- Will do some configuration (perhaps instantiate an object with some parameters)
- Return it to the Spring context :point_left: now it is available for other classes within spring.

Practical usage:
- Classes that must be pre-configured to run the code
- Add in the Spring context a reference to a class that must be available

Beans are automatically injected when used by in another part of the code:
- Spring uses the class type and the bean name (method name) to wire the code. If you define an argument with a given type and the same name as a bean :point_left: Spring injects the Bean
- If two beans created have the same type, it will try matching the name to inject it
- We can also use the `@Primary` annotation to tell Spring which bean has preference

> :thought_balloon: If not annotated with `@Bean("customName")`, the name of the bean will be the method in camelCase with a lower letter first.

> ⚙️ Beans are created once by the Spring application; the `@Bean`-annotated method is called once. If the bean has already been instantiated (method called), it takes the cached version. This means that the code run in the Bean-annotated method runs only once, even in the class returned is injected in many different parts of the code.


### Singleton by default

Beans are singleton by default in Spring, unless they have state

> :thought_balloon: No state should be kept in singletons, no data should be added. If beans have state (not final), they will not be singleton 

### Prototype beans

Another type of `Bean`, which creates a new instance per injection point. In this one, we can keep request state. Do not use prototypes inside singleton (as they contain state)


### Post-construct

`@PostConstruct` runs after `@Autowired` and `@Value` fields are injected. The `@Transaction` annotation does not work for Post-construct methods, as they are run too early (startup of Spring).


### Accessing all beans

#### Use-case 1: bean verification

We might want to do checks at runtime, once all beans have been loaded. For example: ensuring all Beans with `@RestController` annotation have another one (such as `@Secure`)


#### Use-case 2: debugging
For debugging purposes, we might want to see all beans in our code (or all beans annotated in a certain way). For that, we can define a dummy class using the `BeanPostProcessor`, which is a Spring class containing all beans

```java
@Configuration
public class SearchForMyBean {
    @Bean
    public BeanPostprocessor method() {

        return new BeanPostProcessor() {

        @Override
        public Object postprocessAfterInitialization(Object bean, String beanName) throws BeansException {
            if (bean.isannotated with @RestController) //...
            }
        }
    }
}
```


# 2 - Configuration

## 2.1 Injecting values

The `@Value` annotation will look for a value on a configuration file (inside `resources/` folder, depending on the profile), and pass it as a value to the class.

```java
@Bean
public Person john(@Value("${john.name}") String johnName) {
    return new Person(johnName);
}
```

We can add default values by adding a `:` and some value after:
```java
@Bean
public Person john(@Value("${john.name:#{null}}") String johnName) {
    return new Person(johnName);
}
```
- Note: the `#{}` ensures the `null` type is taken, rather than the string `"null"`

> :thought_balloon: Always 

## 2.2 Configuration files

Live in the `resources/` folder, where values are defined:
- `application.properties`: default properties
- `application.local.properties`: properties overriden in "local" profile
- `application.prod.properties`: properties overriden in "prod" profile

> :thought_balloon: Using an `application.properties` is fine, but having a YAML-based configuration enables extra features, such as references between configured fields!

### Organizing configuration

Define custom configuration for classes with `@ConfigurationProperties`, this enables to define a prefix for all fields in the configuration, and Spring will be smart enough to match the value name with the configured value using the prefix.

For example: `spring.datasounce.hikari.my-value=123` will be injected in any `myValue` field inside `HikariDataSource`. 


Let's see how this is configured in real code:
```java

@Configuration
@ConditionalOnClass(HikariDataSrouce.class) // Use configuration for this specific class

@Bean
@ConfigurationProperties(prefix = "spring.datasource.hikari")
HikariDataSource dataSource(...) {...}
```

### Checking configuration

Spring enables defining type-checks for configuration fields, IntellIJ will flag it.

We can also use the `@Validate` annotation in a `@Bean` definition to check types and existence of paths.

## 2.3 Profiles

Profiles enable to run the code in different ways, with different configs. For example: not needing a crazy authentication parameter for testing locally. The `@Profile` annotation will make sure a piece of code is only run for a given profile.

```java
@Profile("!local")
```

# 3 - Auto-wiring

