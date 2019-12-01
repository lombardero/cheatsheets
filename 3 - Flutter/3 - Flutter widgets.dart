////////////////////////////////////////////////////////////////////
//      FLUTTER WIDGETS                                           //
////////////////////////////////////////////////////////////////////

// https://flutter.dev/docs/development/ui/widgets

// Widgets are the building blocks of Flutter Apps. Anything that can
// be seen in an App is a Widget (even what holds all widgets 
// together). Some can define large scale parts of the application
//  (Bars, Images, Lists, Buttons...), and some other can
// define very simple elements such as text. The app is built by
// interconnecting and adding widgets onto each other to for the
// widget tree, which adds the complexity.

// Note that widgets are classes in Dart, they need to be defined

// Reminder: press Ctlr + Space in VS code to see the arguments
//           use Alt + Shift + F to auto-format the code
//           use ^ Shift R to make Refactor suggestions

RUNNING THE WIDGETS
    void main() {
      runApp(MyWidget());
    }
        //-> this code uses the 'runApp()' function, which is a
        //   Flutter function that basically generates the UI from
        //   the whole widget tree defined in the Widget 'MyWidget()'.
        // Note: it calls the 'build' method defined on the 'Widget' class,
        //   and builds the visualisation.
    void main() => runApp(MyWidget());
        //-> does the same as the code above, in one line of code
        //   (different and often used syntax)

WIDGETS: STATEFUL vs STATELESS, EXTENDING DART CLASSES
  // Extensions are used to build widgets from Flutter's pre-defined
  // objects. To define a widget we need to extend the StatelessWidget
  // or StatefulWidget class, and override its 'build' function'
    import 'package:flutter/material.dart';
      // This Command imports all Classes defined in the 'material.dart'
      // file (which is in the folder where Flutter is downloaded). The 
      // yaml file declares the dependencies, and here we bring out the
      // widgets from this file, which we can then use to extend our own
      // classes

  // ------- Stateless Widgets ------
  // For Stateless widgets, we need to import or extend only one class
  class MyWidget extends StatelessWidget {
    'all class variables and functions used on the code go here'
    // the names can be re-used later (careful -> in this example we are
    // using a Stateless Widget! therefore it cannot change -> does not
    // usually need functions or variables -> stateful)
    @override
    Widget build(BuildContext context) {
      return MaterialApp(home: Text('Hello world!'));
    }
  }
      //-> this code allows us to create a new class 'MyWidget', built from
      //   StatelessWidget (the most basic Flutter widget).
      // Note0: Stateless Widgets can only change once input data (from outside
      //   the class) is inserted. It does not keep internal state, and therefore
      //   will never get re-rendered based on state.
      // Note1: the '@override' decorator is there to make our code more
      //   readable (good practice). It is a Flutter decorator that says
      //   we are 'overriding' or 're-writing' any of the in-built functions
      //   of the 'StatelessWidget' class (in this case, the 'build()'
      //   function). Flutter actually forces us to override it, so it is
      //   not required (code would still work) but it adds readability
      //   (make sure we are not accidentally overriding)
      // Note2: StatelessWidget needs us to define the 'build()' function
      //   to work (which is called by Flutter when the Widget is loaded).
      // Note3: the function 'build()', expects a 'context' argument,
      //   which is a 'BuildContext' class (defined by Flutter), and
      //   will return a 'Widget' (mentioned before the function name), since
      //   it will output something on the UI. 'build()' is what will be
      //   called to output the UI when 'MyWidget' is run.
      // Note4: 'MaterialApp' is a Google pre-defined widget (accepts args),
      //   which requires us to define the argument 'home' to be run. 'home'
      //   expects a Widget too. In this case, we will put some text.
  
  // ------ Stateful Widgets ------
  // For stateful widgets, we need to create and import from 'material.dart'
  // TWO defined classes: the StatefulWidget AND its State. The State class
  // will keep the state stored. We need to connect both StatefulWidget and
  // state together as follows:
  class MyWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
      return MyWidgetState();
    }
  }
      //-> We first define the StatefulWidget class, and override its State
      //   class by returning 'MyWidgetState()' executed with the 'createState()'
      //   method, which outputs a State object: 'State<StatefulWidget>'
      // Note: this class will return the State of the Widget, which will
      //   ask the app to be re-rendered every time the setState() function
      //   is required to be run.
  class MyWidgetState extends State<MyWidget> {
    var var_used_in_state = 0;
    setState(() {
      var_used_in_state = var_used_in_state + 1;
    })

    @override
    Widget build(BuildContext context) {
      ....
    }
  }
      //-> In the State part, we need to add a pointer to the 'MyWidget' widget
      //   by adding <MyWidget> after extending the State class: it is extending
      //   the State of MyWidget.
      //-> In the State definition, we need to add the variables and functions 
      //   that will affect our state so that flutter knows WHEN it needs to
      //   re-render the App (otherwise it would be super slow, re-rendering
      //   anytime the user inputs something.
      //-> The rest of the application is kept inside the State class
      // Note: setState() is a method that takes in a void function as an
      //   argument, with all the State-modifying elements on it.
      //   setState() will re-run the 'build()' method every time it is
      //   triggered.

OUTPUT & INPUT WIDGETS (BASIC, VISIBLE)
// These widgets are 'Visible', and output something on the UI, they
// can be used as 'leaves' of the UI tree
    Text('text goes here')
      //-> defines a text entry (simple), expects a string
    Title('Text goes here')
      //-> title is a different type of Widget than text
    AppBar(title: Text('title'),)
      //-> defines an 'AppBar' (top bar of the app) widget, which
      //   expects many other widgets such as 'Title', and by
      //   default will be a blue bar.
      title:
        //-> expects a 'Text' widget, and will be placed in the
        //   center of the App Bar by default.
    RaisedButton(child: Text(...), onPressed: null)
        //-> is a widget to output a rectangular button (default)
        child:
          //-> will allow to add anything to the button (text,
          //   color, whatever we want)
        onPressed:
          //-> defines the action to be taken if the button is
          //   pressed. It expects a void function, which can be
          //   defined right on the spot, or named and re-used in
          //   many buttons
            onPressed: () => print('Button pressed!')
              // 
            onPressed: function 
              // onPressed expects a function (which needs to be
              // the name itself without parenthesis, since otherwise
              // Flutter will execute it when the Widget is built, and
              // we only want to execute it once the button is pressed
              // Note: 'function' should be defined inside of the class
              // where it belongs to, usually before the '@override' of
              // the 'build' function.
              void function() {
                // do something
                print('Button pressed!')
              }
                //-> will create a function that prints 'Button pressed!'
                //   on the logger of the terminal (do not see in the app)
            onPressed: () => print('Button pressed!')
              //-> generates a nameless function directly for the button
              //   (takes no arguments and prints something)
            onPressed: () {
              print('Button pressed!')
              }
              //-> same as preceding line (different syntax)
            onPressed: null 
              // will disable the button (will not do anything)

    Card()

LAYOUT or 'BUILDING BLOCK' WIDGETS (NOT VISIBLE)
// These widgets are a bit more complex than the basic ones, and 
// allow us to assemble the basic UI components. They are
// usually placed close to the 'root' of the UI tree, and expect
// other widgets as arguments.
    MaterialApp(
      home: Scaffold(...)
    )
      //-> MaterialApp is a 'building block' widget in Flutter, it
      //   usually sits at the root of the UI tree and expects many
      //   other widgets as arguments to build the App.
    Scaffold(
      appBar: AppBar(...),
      body: Text('Default text'),
    )
      //-> One of Flutter's classic Widgets, it accepts many other
      //   widgets as arguments such as appBar, body, etc.
      appBar:
        //-> expects an 'AppBar' widget, which by default is a blue
        //   top bar with some text on it.
      body:
        //-> is the remaining part of the display, by default, the
        //   background will be white and the written text will be
        //   dark grey.
        // Note: 'body' only accepts one Widget as output, in case
        //   we wanted to input more Widgets, we need to use a
        //   layout widget
    Container()

    Row()

    Column(children: <Widget>[Widget1, Widget2, Widget3,...])
      //-> allows to put widgets on top of each other by listing them
      children:
        //-> expects a list of Widgets, which will be placed on top of
        //   each other
    ListView()