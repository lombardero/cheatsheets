# Security in Spring
- [Security in Spring](#security-in-spring)
- [0 - Security basics](#0---security-basics)
  - [Authentication vs Authorization](#authentication-vs-authorization)
  - [Types of authentication](#types-of-authentication)
  - [Cookies & Keycloak](#cookies--keycloak)
- [1 - Spring security](#1---spring-security)
  - [1.1 Basic authentication](#11-basic-authentication)
    - [Legacy setup](#legacy-setup)
    - [Enhanced setup](#enhanced-setup)
    - [From Roles to Authorities](#from-roles-to-authorities)
  - [1.2 Spring security architecture](#12-spring-security-architecture)
  - [1.3 Other features](#13-other-features)
  - [Extracting the user details from request](#extracting-the-user-details-from-request)
  - [Disabling functionalities for given roles](#disabling-functionalities-for-given-roles)
# 0 - Security basics

Ways of authenticating a request:
- API Key
- JWT ([JSON Web Tokens](https://jwt.io/introduction))
- `X-Authenticated-user`

## Authentication vs Authorization

- Authentication (`401`): identify who the client is (usually implelkented via shared library)
- Authorization (`403`): determine what the client can do (responsibility of the server)

## Types of authentication

- Form Login
- Basic: system to system calls `apiKey` or secret
- Digest
- Certificate: 2-SSL, Kerberos
- [OAuth](https://www.youtube.com/watch?v=996OiexHze0) (watch it!) + OpenID 
- Pre-authentication via Request header (X-user)

## Cookies & Keycloak

Cookies make sure your session keeps active. The browser keeps some cookies, but Keycloak also does (uses SSO - Single-Sign-On), remembers cookies for a day. This is how it works:
- You call entrypoint of app
- Entrypoint redirects to login
- Login redirects to Keycloak
- Keycloak uses cookie, authorizes, and redirects again to app, this time authorized

# 1 - Spring security

## 1.1 Basic authentication

### Legacy setup

Spring has an `HttpSecurity` object enabling to set up security; this is how authentication used to be set up, but it SHOULD NOT BE USED as it is very error-prone! We often forget to update the URLs in this part when we change them (opening them to unwanted users).
```java
@Override
protected void configure(HttpSecurity http) throws Exception {
    super.configure(http);

    http.authorizeRequests()
        .mvcMatchers(HttpMethod.DELETE, "/api/admin/**").hasRole("ADMIN")
        // More restrictive on top, only this role can access this URL or call DELETE HTTP method
        .mvcMatchers("/api/**").authenticated() // Check that user is authenticated for
        .mvcMatchers("/sso/**").permitAll()
        .anyRequest().permitAll()
        and()
        .csrf().disable() // if only REST APIs expose, it is okay to do
}
```
- Requires authorizations for all URLs like `api/%`

> :exclamation: The top-most used security breach issue is when backends still expose actions (usually via endpoints) that are hidden disabled in the fronted (still accessible via `cURL` or Postman)

### Enhanced setup

Spring allows us to keep the role annotation close to the function that uses it via the `@Secured` annotation! We can authorize methods or classes with specific roles! Less error-prone.

```java
@Secured({"ADMIN"}) // Same as `@PreAuthorize("hasRole('ADMIN')")`
public void someAuthorizedMethod() {};
```

> :thought_balloon: This setup still has a challenge, it does not scale well with number of roles. This setup will make us repeat ourselves

### From Roles to Authorities

Feature-based authority: we flip the problem. Instead of listing the roles that can access an action in the code, we define the actions -called "Authorities"- that each user can perform.

Basically, we are creating a mapping `Role` to `List<Authority>`. This is how Keycloak works!

In our application, we create a mapping from role to authorities (features) in one central place:
```java
public enum UserRole {
    USER("example.search");
    ADMIN("exampke.search", "example.edit", "example.delete")
}
```

> :information_source: In this setup, Authentication works by sending authority tokens in the headers.

## 1.2 Spring security architecture

Spring's security works by a superposition of [filters](https://docs.spring.io/spring-security/reference/servlet/architecture.html), which means **order is important**!

## 1.3 Other features

## Extracting the user details from request

Spring has a `SecurityContextHolder` which holds the authentication details.

This enables us to deliver features in a per-use-case basis, such as for example displaying or not certain buttons to enable certain actions in the UI.
```java
Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
String userName = authentication.getName();

String role = authentication.getAuthorities()
                .stream().map(ga -> ga.toString())
                .findFirst().get(); // Users can have many roles
```

> :information_source: By convention, in Sprin, all roles are called `"ROLE_<role name>"`, so `.hasRole("ADMIN")` actually looks for `"ROLE_ADMIN"`.

## Disabling functionalities for given roles

We often want our applications to expose different features for each type of user (for example: admininstrator vs user).

We can disable certain requests or URLs per user using `autheorizeRequests` (see above), but we can also:
