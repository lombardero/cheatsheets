//////////////////////////////////////////////////////////////////
//      DART FUNDAMENTALS                                       //
//////////////////////////////////////////////////////////////////

// try out Dart code in: https://dartpad.dev/

// As an OOPL, all variables are 'classes' in Dart. New classes can be
// defined and used
    
BASIC SYNTAX
    class Person {
      String name = 'Default';
      var age = 28;
    }
        //-> defines a class 'Person' with two properties (or attributes)
        //   pre-defined
    var pers1 = Person();
        //-> defines a 'person1', which is an instance of 'Person' class
        //   (values are set to the default ones)
    pers1.age
        //-> will return the 'age' property of the instance 'pers1' 
    pers1.name = 'Manu'
        //-> updates the 'name' propery to 'Manu'
    
USING THE CONSTRUCTOR (EMPTY CLASS)
    class Person {
      String name;
      int age;

      Person(String inputName, int age) {
        name = inputName;
        this.age = age;
      }
    }
        //-> this code allows us to define an "empty" class, which will
        //   require two inputs to initialize (name and age)
        // Note1: In dart, inside of the class, we need to define a
        //   function (in Dart it takes the same name as the class, so
        //   for the class 'Person', the constructor function is also
        //   called 'Person()'), which will be initialized every time
        //   the class is called, and takes two inputs (which will be
        //   set equal to the class inputs)
        // Note2: to set the inputs of the class, we can use a different
        //   name in the constructor, or we can use 'this.arg' to refer
        //   to the argument of the Class (this.age is the 'age' arg of
        //   the Person class, and age is the arg of the constructor).
    class Person {
      String name;
      int age;

      Person(this.name, this.age);
    }
        //-> this code performs the same as the preceding line. It is an
        //   in-built Dart 'shortcut' to build the class easily.
        // Note: we need to use 'this' + 'dot' + name of the variables
        //   in the class definition.
    person1 = Person('Manu', 28);
        //-> Creates an instance of the 'Person' class

DEFINING UTILITY CONSTRUCTORS
    //-> utility constructors are ways we can use to quickly define
    //   class instances in Dart (useful, for example, if we need a
    //   lot of instances with very similar proprieties)
    class Person {
      String name;
      int age;
      Person(this.name, this.age);

      Person.newBorn(this.name) {
        age = 0;
      }
    }
        //-> the code above would let us define very easily a 'newborn'
        //   by typing the name: 
    baby = Person.newBorn('Eve')
        //-> creates a new 'Person' instance called 'Eve' 0 years old

DEFINING NON-ORDERED ARGUMENTS
    class Person {
      String name;
      int age;

      Person({this.name = 'Default', @required this.age}) {
      }
    }
        //-> adding '{}' to the arguments of the constructor makes them
        //   non-positional and optional. This is very useful when dealing
        //   with a lot of arguments; it also allows to add default values.
        // Note: if the argument is required, by adding '@required' in the
        //   constructor for the argument will make it return 'Error', if
        //   it is not mentioned when the instance is created.
        //   Instances are created as follows:
    person1 = Person(name: 'Manu', age: 28);
        //-> since we used '{}', now we need to specify the names of the
        //   arguments of the constructor to define an instance.
    
PRIVATE CLASSES
    class _Person {
      ...
    }
        //-> adding '_' at the beginning of the class name transforms the class
        //   into a private one, making it only accessible by the current working
        //   file (not importable). This is helpful to 'protect' classes from
        //   being modified and avoids bugs.
    