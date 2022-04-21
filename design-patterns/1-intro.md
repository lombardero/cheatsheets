# Introduction


## Encapsulate when possible

Encapsulate what changes and separate it from the rest of the code (so then it can be
extended without affecting the rest).

> This means: keep the code as flexible and modular as possible (easily extendable)

## Avoid implementations

Program to an interface, not an implementation.

> Abstract away the details of the code, expose interfaces, not their implementations

This means: given an object, identify the different interfaces it has with different
components, isolate them, and combine to create such objects.

> Note that an interface here means a supertype.

```python
# First interface gives some behavior.
class MouthInterface(ABC):

    def make_sound(self):
        ...

# Second interface gives some other unrelated behavior.
class LegInterface(ABC):

    def move(self):
        ...

# Class using such interfaces.
class Dog(Mouthinterface, LegInterface):

    def make_sound(self):
        self._bark()
    
    def _bark(self):
        print("Bark!")

    def move(self):
        ...
```
- This enables the caller of `Dog` to not be aware of its implementation, leveraging
  polimorphism to do: `dog.make_sound()` rather than having to a specific call.

## Think ahead

Imagine how the code could be extended or re-used in the future, and allow such
extensions in your design.
