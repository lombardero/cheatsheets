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

BASIC WIDGETS
    Text()
      //-> defines a text entry (simple)
    

EXTENDING CLASSES
  // Extensions are used to build widgets from Flutter's pre-defined
  // widgets.
    import 'package:flutter/material.dart';
      // This Command imports all Classes defined in the 'material.dart'
      // file (which is in the folder where Flutter is downloaded). The 
      // yaml file declares the dependencies, and here we bring out the
      // widgets from this file, which we can then use to extend our own
      // classes
  class MyWidget extends StatelessWidget {
    Widget build(BuildContext context) {
      return MaterialApp(home: Text('Hello world!'));
    }
  }
      //-> this code allows us to create a new class 'MyWidget', built from
      //   StatelessWidget (the most basic Flutter widget).
      // Note1: StatelessWidget needs us to define the 'build()' function
      //   to work (which is called by Flutter when the Widget is loaded).
      // Note 2: the function 'build()', expects a 'context' argument,
      //   which is a 'BuildContext' class (defined by Flutter), and
      //   will return a 'Widget', since it will output something on the UI.
      // Note 3: 'MaterialApp' is a Google pre-defined widget (accepts args),
      //   which requires us to define the argument 'home' to be run. 'home'
      //   expects a Widget too. In this case, we will put some text.

RUNNING THE WIDGETS
    void main() {
      runApp(MyWidget());
    }
    //-> this code uses the 'runApp()' function, which is a
    //   Flutter function that basically generates the UI from
    //   the whole widget tree defined in the Widget 'MyApp()'.
    // Note: it calls the 'build' method defined on the 'Widget' class,
    //   and it builds it.