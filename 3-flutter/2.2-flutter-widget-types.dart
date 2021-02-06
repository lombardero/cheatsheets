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

// Good practice: one widget per file. (helps performance and
//                readability).

// Reminder: press Ctlr + Space in VS code to see the arguments
//           use Alt + Shift + F to auto-format the code
//           use ^ Shift R to make Refactor suggestions

OUTPUT & INPUT WIDGETS (BASIC, VISIBLE)
// These widgets are 'Visible', and output something on the UI, they
// can be used as 'leaves' of the UI tree
    Text('text goes here', style: TextStyle(...), *args)
        //-> defines a text entry (simple), expects a string
        style: TextStyle(fontSize: 28)
          //-> defines the 'style' of the text thanks to a 'TextStlye'
          //   object, which takes in arguments such as fontSize
          //   To learn more: 
          //   https://api.flutter.dev/flutter/painting/TextStyle-class.html
        textAlign: TextAlign(...)
        textAlign: TextAlign.center
          //-> defines the Alignment of the text, can be defined with
          //   details through the 'TextAlign' object, or set to some
          //   'typical' values with the help of '.center', '.left' 
          //   or '.end'
    Title('Text goes here')
        //-> title is a different type of Widget than text
    AppBar(title: Text('title'),)
        //-> defines an 'AppBar' (top bar of the app) widget, which
        //   expects many other widgets such as 'Title', and by
        //   default will be a blue bar.
        title: Text(...)
          //-> expects a 'Text' widget, and will be placed in the
          //   center of the App Bar by default.
    RaisedButton(child: Text(...), onPressed: null)
        //-> is a widget to output a rectangular button (default)
        color: Color(hexcode) // or Color.blue
          //-> will color the button with the indicated color, this
          //   argument expects a Color class.
          //   Colors.blue is a static property of the class (pre-
          //   defined value on the class) -> does not create an
          //   instance of the class, only an object (optimized)
        textColor: Color(hexcode) // or Color.white
          //-> sets the color of the text, expects a 'Color' object
        child: Widget
          //-> will allow to add anything to the button (text,
          //   color, whatever we want)
        onPressed: function
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
    Container(
      width: double.infinity,
      child: Widget...,
    )
        //-> containers are 'Rectangles' that wrap another widget inside,
        //   The main content is the child Widget, which gets wrapped
        //   by a Padding around it until the container Border (which
        //   can also have width), and a Margin between the container
        //   and other Outside Widgets.
        child: Widget
          //-> defines the widget that will be wrapped inside of it,
          //   expects a 'Widget' object.
        width: num
          //-> defines the width of the container, it can be set to 
          //   infinity 'double.infinity' to make sure it takes as
          //   much space as it can
        margin: EdgeInsets
        //example -> margin: EdgeInserts.all(10)
          //-> margin defines the spacing between the container and 
          //   any neighbouring Widgets, it can be set to some value
          //   using 'EdgeInserts.all()' (all directions) or
          //   'EdgeInserts.only()' (one direction only)
      

    Row()

    Column(children: <Widget>[Widget1, Widget2, Widget3,...])
      //-> allows to put widgets on top of each other by listing them
      children:
        //-> expects a list of Widgets, which will be placed on top of
        //   each other
    ListView()
