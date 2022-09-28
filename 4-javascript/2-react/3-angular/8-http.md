# HTTP in angular

Angular comes with a built-in `HttpClient` to make HTTP calls. It supports the classic HTTP methods, and returns an observable.

```ts
getArtigleInfo(id: string): Observable<DecantInformation> {
    return this.http.get<DecantInformation>(
        `${this.decantUrl}/articles/${id}`,
        HttpLoggerService.LOGGING_ENABLED_HEADER_CONFIG
    );
}
```

Note that types are not checksed at

# HTTP Interceptors

Angular enables us to configure HTTP interceptors, which can intercept HTTP calls and perform some function on them. It can:
- Do something in an outgoing request (e. g. adding Headers)
- Do something in an incoming response (e. g. parsing Dtos into objects, transforming string to datetime, error handling, ignoring the request)

```ts
intercept(
    request: HttpRequest
    next: ...
)
```
