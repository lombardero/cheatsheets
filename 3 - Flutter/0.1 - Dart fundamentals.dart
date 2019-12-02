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
    void // in Dart, this is a datatype that means 'empty'
         // (not the same as 'null', which is the same as 'None' in
         // Python)
    List // list (with capital L) datatype
    List<int> // list of integers
    ['this','is','a','list',]
    <String>['this','is','a','list',]
        //-> the <String> allows us to tell Dart that the list
        //   should only accept strings on it.
    list[i]
        //-> outputs the (i-1)th element of the list (indexes start
        //   at zero)

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
    if(boolean_expression){ 
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