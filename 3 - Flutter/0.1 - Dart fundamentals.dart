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
    List // list (with capital L) datatype
    List<int> // list of integers
    bool // Boolean datatype

OPERATORS
    = // 'equal to': sets a variable equal to something
    == // 'is equal to?': boolean condition
    != // 'is not equal to?': boolean expression
    > // 'greater than?' boolean expression
    < // 'smaller than?' boolean expression
    >= // 'greater or equal than?' boolean expression
    <= // 'smaller or equal than?' boolean expression
    && // 'and' boolean statement
    || // 'or' boolean statement

VARIABLE TYPES
    // Dart stores all data in memory, and all declared variables are
    // saved as pointers to the location in memory where the data is
    // stored.
    // It is good practice to be as explicit as possible with our
    // intentions for variables so we do not screw up our code.
    null
      //-> 'null is an empty value in Dart (similar to 'None' in Python),
      //   that means the variable does not point to any value in memory,
      //   the variable is in an 'uninitialized state.

    var a
      //-> this variable can change during the course of our program.
      //   the address in memory where this variable will point to can
      //   change without problem
    void a
      //-> this, in Dart, indicates an 'empty' pointer to memory
      //   (allows to tell the program that we do not need anything
      //   to be stored in memory, such as for functions not returnin
      //   anything)
    final a
      //-> this indicates the variable will not change once the part of
      //   code depending from it gets run. (run-time constant value)
      //   in Flutter, for example, we can use a 'final string' to generate
      //   the content of a Stateless Widget. When the code is compiled, the
      //   variable is unknown, but when the widget is created, the variable
      //   gets allocated and it never changes, it is 'final'.
    const a
      //-> these are 'complile-time' constant variables. That means
      //   that the variable gets allocated at compile time (does not need to
      //   wait until the code is run). That allows Dart to raise an error if
      //   it detects that we try to associate the name to another variable.
    enum a {'apple', 'orange'}
      //-> enumerations are variables that can accept a value within a set of
      //   pre-defined ones. (on the example above, for example, the variable
      //   can only be 'apple' or 'orange').
      //   Enumerations are useful to be sure that the code behaves as it
      //   should, and increase the runtime at compiling vs a single string
      // Note: behind the scenes, enumerations map each of the values to an
      //   integer index [0, 1, 2, ...]
    var a = const 123
      //-> this specific code is telling Dart that the variable '123' will be
      //   constant at runtime, and therefore unchanged. On the other side, 
      //   'a' is variable, and we will not see an error if 'a' is set equal
      //   to another value.

LISTS
    ['this','is','a','list',]
    <String>['this','is','a','list',]
        //-> the <String> allows us to tell Dart that the list
        //   should only accept strings on it.
    list[i]
        //-> outputs the (i-1)th element of the list (indexes start
        //   at zero)

  LIST FUNCTIONS
      list.map(function);
      list.map((i) {i*2});
          //-> iterates through the list, creating an iterable  
          //   object (same size), applying 'function' element-wise.
      list.length
        //-> returns the length of the list
      list.add(new_element);
        //-> adds 'new_element' at the end of the list (same as python .append())
      iterable.toList();
          //-> transforms iterable into list
      ...list
      [a, ...[b, c], d, e]
          //-> 'unwraps' a list (inside of a list) onto the outer one
          //   the output from the example is: [a, b, c, d, e]
      

MAPS // same as Python Dictionaries
    {1: 'this', 2: 'is', 3: 'a', 4:'map'}
    map.length
      //-> returns the length of the map (number of keys)


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

LOGIC STATEMENTS
    if(bool){ 
      // statement(s) executed if the Boolean expression is true. 
    } else { 
      // statement(s) executed if the Boolean expression is false. 
    } 

BASIC PREDEFINED FUNCTIONS
    main()
      //-> this function will always launched at the start (we define)
    print()
      //-> prints the contents of what is inside
    

DEFINING FUNCTIONS
  // ------- functions with name ------
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
    
  // ------- anonymous functions -------
    (num1, num2) => num1 + num2
    //-> this is called an 'anonymous' function, (similar to lambda
    //   expressions), it generates a function object but does not
    //   save it into memory (usable once)
    (num1, num2) {
      num1 + num2
    }
    //-> 'anonymous' function (same as above) with a different syntax
    (num1, num2) {
      num1 + num2
    }()
    //-> adding parenthesis executes the function