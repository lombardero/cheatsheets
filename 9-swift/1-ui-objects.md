# Predefined Objects used in swift

## View
Requires a body

`some` is an operator that allows the variable "acti like" a struct or class without being exactly that class (it can call the same methods)

```swift
VStack {
    Object1
    Object2
}
```
- Arranges vertically whatever is inside


```swift
Button(action:{}){
    ObjectDisplayed
}
```
- 

## Defining the state
Whenever we want some object to interfere with the "State" of our application (example: we want to activate/deactivate some functionality in our app), we need to create a state variable.
```swift
struct ContentView: View {

    @State var variableModifyingState:_Bool = false

    var body: ...
}
```
- a `ContentView` struct is defined with a variable associated to it that will modify the state of the instance 
>Note: the `@State` operator binds the variable to the State of the class, each time the `variableModifyingState` is modified, the `ContentView` object (or rather, its `body`) will be re-rendered.
>Note 2: whenever a part of the code modifies `variableModifyingState`, we need to use a `$` operator: `$variableModifyingState = true` successfully modifies the state of the app.