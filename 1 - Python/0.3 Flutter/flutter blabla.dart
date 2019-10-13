
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';


class PuzzleFour extends StatelessWidget {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  void onGroupPressed(BuildContext context) => Navigator.pop(context);
  Color hexToColor(String code) => Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  
  @override
  Widget build(BuildContext context) {

  Widget _buildInnerBottomWidget() {
    //....
        // copy from Google meetup
          Transform.rotate( // create a transformation (rotation), which will be applied to the child
            angle = pi/4 // rotation angle
            child: Container( // used to create "something" in flutter (button, whatever)
            width: 34, // 34 pixels
            height: 34,
            decoration: BoxDecoration(
              color: Colors.orange, // color of the box
              borderRadius: BorderRadius.circular(6),
              bocShadow: [
                BoxShadow(contextblu)
              ] // adding round tips (square)
            ),
            child: Center( // adding an icon
              child: Transform.rotate(
                angle: -pi/4, // re-rotating it to be vertical "if it works, it works"
                child)
            )
          // different thing:
          AspectRatio( // allows you to leave some space between "widgets"? (buttons) : apply to each
          // with the same aspectRatio for the same spacing
            aspectRatio: 4.0/3
            child: activeTab()
          )
          )
        ),
      ),
      Drawer(
        child: CustomPaint(c))
    );
  }
  
}
// extend class to create the background paint for the drawer (which we want orange and with circles)
class DrawerPainter extends CustomPainer {

  DrawePainter() : backgroundPaint = Paint()..color = const Colot(0xFFEA224)
  smallCirclePain = Paint()..color = const Color(0xFFF4C67E) // Create an instance to paint a small circle
  // double points chains methods together
  // example
  // Class()..method1
  //      ..method2

  final Paint smallCirclePaint;


  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(....)) // avoids the figures to 'go further' than the limit
                                         // of the rectange (in thei case, the droor)
    canvas.drawRect(Rect,fromLTWH(0,0,size.width,.....))
  }
}
// create this to create a "diamond button" widget (widget, sure?)
class DiamondButton extends StatelessWidget  {
  DiamondButtin({
    this.icon,
    this.backgroundColot,
    this....
  })
}