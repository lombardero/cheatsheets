# Spring Boot actuator

- [Spring Boot actuator](#spring-boot-actuator)
- [Configuration](#configuration)
  - [Enable spring boot actuator](#enable-spring-boot-actuator)
  - [Configuring ports](#configuring-ports)

Overview of what is it :point_right: [here](https://www.baeldung.com/spring-boot-actuators).

Spring-boot adds production-ready features to the applications, such as:
- [Changing log level at runtime](https://www.baeldung.com/spring-boot-changing-log-level-at-runtime)
- Monitoring (free Micrometer metrics from JVM, Memory, etc.)
- See an overview of predefined endpoints
- Adding health indicators such as health groups (apps which the service expects to be running, such as RabbitMq, etc.)
- Creating an info endpoint

# Configuration

## Enable spring boot actuator

To add the Spring boot starter actuator, import `spring-boot-starter-actuator` in the `pom` file (delete the version that gets added by default, let the version be controlled by the version manager), then we can add the below configuration in our `properties` to enable spring boot actuator:

```prop
management.endpoints.web.exposure.include=*
```

## Configuring ports

By default, the port of Spring applications is `8080`, this can be changing by configuration:

```prop
service.port=8082
```
