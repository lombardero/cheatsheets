# Unit testing in Angular

Angular uses Karma (test runner) & Jasmine out-of the box (they can be changed)
- Spec files are placed next to the file that they test
- CLI can create a test skeleton
- Run tests using `ng test`

## Jasmine

Jasmine is a test framework.
- Test suite starts with "describe"
- Individual tests start with "it"
- Support for `beforEach`, `beforeAll`
- Can add "d" in fron of

Most basic unit test ever:
```ts
describe('Component',
    () => {
        it('should be true',() => {expect(true).toBeTruthy();});
    }
);
```

# Component testing

Testing a component with dependencies:
- Mock dependencies
- Use `TestBed` to set providers of dependencies to use the mock
- Service with dependencies can be tested the same way

## Testing the DOM

We can call the HTML elements that are generated through the component to do "shallow integration tests".

