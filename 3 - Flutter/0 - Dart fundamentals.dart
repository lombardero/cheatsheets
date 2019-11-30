//////////////////////////////////////////////////////////////////
//      DART FUNDAMENTALS                                       //
//////////////////////////////////////////////////////////////////

// try out Dart code in: https://dartpad.dev/


DATA TYPES
    "this is a string";
    'this is also a string';
    String // string (with capital S) datatype
    int // integer datatype
    double // 'double' or 'float' datatype
    num // dynamic 'numeric' value which accepts both 'int' and 
        // 'double'
    void // in Dart, this means 'nothing' or 'None'

DEFINING VARIABLES
    var new_variable;
        // creates 'new_variable'. The command 'var' tells Dart
        // to allocate a space in memory for the variable defined.
    var new_varible = 8;
        // defines variable and sets it up to a value
        // Note: data types can also be specified directly,
        //   although Dart has datatype inheritance.
        //   (good practice: use 'var' if you specify value assigned)
    int new_varible;
    double new_varible;
        //-> are both a way to define a new 'int' or 'double' variable
        //   (good practice: define data type if no value is assigned on
        //   the line it is defined)

OBJECT ORIENTED PROGRAMMING (CLASSES)
    // As an OOPL, all variables are 'classes' in Dart. New classes can be
    // defined and used
    
    // ------ Basic syntax (defaults)------
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
    
    // ------ Using the constructor (empty classes) ------
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
    
    // ------ Optional, not ordered arguments ------
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
    

BASIC FUNCTIONS
    main()
      //-> this function will always launched at the start (we define)
    print()
      //-> prints the contents of what is inside
    

DEFINING FUNCTIONS
    void myfunction(int num1, int num2) {
      print(num1 + num2);
    }
    //-> defines a function called "myfunction" that prints the sum
    //   of the two inputs of the function
    // Note1:  it is key to introduce a ";" after each line of code
    //   inside the function
    // Note2: Dart becomes a dynamic language if no datatype is specified
    //   in the argument. In our, case 'int' are specified: Dart will
    //   raise an error if we enter any other data type such as string
    //   or float (it becomes static)
    // Note3: the 'void' command specifies the type of output of the 
    //   function defined. Here, we do not return anything, therefore
    //   the type is 'void'. It would work without it, but it is clearer
    //   if we use this command. (this means function cannot be printed)
    double myfunction(double num1, double num2) {
      return num1 + num2;
    }
    //-> this function will return a 'float' number as a result
    