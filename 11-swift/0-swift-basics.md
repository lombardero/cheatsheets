# Basics of Swift

Contents of the file:

**[1 - Basic Variables](#1---basic-variables)**

**[2 - Objects in Swift](#2---objects-in-swift)**



# 1 - Basic Variables
## 1.1 Variable definitions
```swift
var variable
```
- defines a variable, which will be modifiable at runtime

```swift
let constant
```
- defines a constant, which will throw an error if the program tries to modify it at runtime (safer to use `let` when possible).

## 1.2 Basic data types
Swift supports the following basic data types:
- **`Int` or `UInt`**: integer numbers, which can be 32 or 64 bits (for example: `Int32` or `Int64`). `Int` is the signed version (can be negative), and `UInt` is unsigned (cannot be negative).
- **`Float` and `Double`**: the classic float-point numbers (32 bits for `Float`, 64 for `Double`).
- **`Bool`**: the classic boolean variable that can be `True` or `False`.
- **`String`**: an ordered collection of characters, `"This is a string!"`.
- **`Character`**: a single-character string, such as `"C"`.

In swift, we define the data type of a variable with the following syntax:
```swift
var booleanVariable: Bool = false
```
- a `Bool` variable is initiated with the value `false`

## 1.3 Optionals
Swift allows for 'optionals', which are defined using the syntax: `<variable-type>?` (ex: `Int?`). This will simply initialize the variable with a `nil` value. It will remain `nil` if not reassigned.

# 2 Objects in Swift
## 2.1 Predefined Objects
### 2.1.1 Arrays
Official documentation [here](https://developer.apple.com/documentation/swift/array).
#### Initializing arrays
Arrays can be defined with the 'classic' `var` or `let` statements, as follows:
```swift
let array = [1, 2, 3, 4, 5]
```
- defines an array with the variables shown above

Arrays can also be defined as empty objects, to be filled in later in the code:
```swift
var emptyArray: [Int] = []
```
- defines an empty array that can contain only `Int` data types.

Alternative syntax:
```swift
var emptyArray: Array<Int> = Array()
```
- the `Array()` constructor can also be called to build an empty array

```swift
var zeros: Array(repeating:0, count:10)
```
- the `Array()` constructor can be used to build arrays of zeros, for example

#### Array methods
(To be done)


### 2.1.2 Dictionaries
(To be done)

## 2.2 Structures and Classes
Official documentation [here](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html).

Structures and Classes are very similar constructs that allow to define objects in Swift. Unlike other programming languages, in Swift, once an object is defined in a file, it is directly available in all other files:
- `Structures` are usually used to group data together which defines a property of the code, an how it gets rendered
- `Classes` are usually defined as objects that define the "logic" of the code 

```swift
class Person {
    var firstName: String?
    var lastName: String?
    let birthPlace = "Andorra"

    func fullName() -> String {
        var parts: [String] = []
        if let firstName = self.firstName {
            parts += [firstName]
        }
        if let lastName = self.lastName {
            parts += [lastName]
        }
        return parts.joined(separator: " ")
    }
 
}
```
- defines a `Person` class, always born in "Andorra" (it is a constant), with a method that returns the full name if any of the fields `firstName` or `lastName` are entered.
>Note: the `String?` optionals allow us to mention the Class does not require these variables to be initialized, and will work well if no field is entered.


# 3 - Functions

```swift
print("String")
```
- prints `"String"` into the console