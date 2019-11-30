//////////////////////////////////////////////////////////////////
//      FLUTTER BASICS                                          //
//////////////////////////////////////////////////////////////////


GENERAL
    flutter doctor
    //-> checks that all parts are installed as they should
    //   In case they are not, follow the instructions: 
    //   https://flutter.dev/docs/get-started/install

STARTING PROJECTS
    cd <project_directory>
    open -a Simulator
    //-> opens the Simulator (in a Mac device)
    flutter run
    //-> runs Flutter on the simulator

CODE ORGANIZATION
    void main()
    //-> main is the function that runs when the app is launched 
    //   (by definition in Dart), in Flutter, we use it to load
    //   whatever we want to launch at the start
    void main() {
      runApp(MyWidget());
    }
    //-> this code uses the 'runApp()' function, which is a
    //   Flutter function that basically generates the UI taking
    //   the whole Widget tree.


    