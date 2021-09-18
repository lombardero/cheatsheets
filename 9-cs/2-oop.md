# Object-oriented programming in C#

# 1 - Defining classes

Classes in C# are defined through the `class` keyword. By convention, the constructor
of the class is a method shaing the same name as the class. Example:

```cs
class Person
{
    public string name;

    public Person(string name)
    {
        this.name = name;
    }
}
```
