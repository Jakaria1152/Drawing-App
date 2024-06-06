import 'dart:ui';

import 'package:flutter/material.dart';
void main()=>runApp(const myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawingBoard(),
    );
  }
}

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  State<DrawingBoard> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  List<DrawingPoint> drawingPoints = [];
  List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.green,

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details){
         setState(() {
           drawingPoints.add(
               DrawingPoint(details.localPosition,
                   Paint()..color = selectedColor
                     ..isAntiAlias = true
                     ..strokeWidth = strokeWidth
                     ..strokeCap = StrokeCap.round   // change to square to see effect

               )
           );
         });
        },
        onPanUpdate: (details){
         setState(() {
           drawingPoints.add(
               DrawingPoint(details.localPosition,
                   Paint()..color = selectedColor
                     ..isAntiAlias = true
                     ..strokeWidth = strokeWidth
                     ..strokeCap = StrokeCap.round   // change to square to see effect

               )
           );
         });
        },
        // onPanEnd: (details){
        //   drawingPoints.add();
        // },
        child: CustomPaint(
          painter: _DrawingPainter(drawingPoints: drawingPoints),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.grey.shade300,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(colors.length, (index)=>_buildColorChoose(colors[index]),),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildColorChoose(Color color) {
    bool isSelected = selectedColor == color;

    return GestureDetector(
      onTap: ()=>setState(() => selectedColor = color
)
      ,
      child: Container(
                height:isSelected? 47:40,
                width: isSelected?47:40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border:isSelected ?Border.all(color: Colors.white,
                  width: 3):null
                ),
              ),
    );
  }
}


class _DrawingPainter extends CustomPainter{
  final List<DrawingPoint> drawingPoints;
  _DrawingPainter({required this.drawingPoints});
  List<Offset> offsetList = [];
  @override
  void paint(Canvas canvas, Size size) {
for(int i=0; i<drawingPoints.length; i++)
  {
    if(drawingPoints[i] != null && drawingPoints[i+1] != null)
      {
        canvas.drawLine(drawingPoints[i].offset, drawingPoints[i+1].offset, drawingPoints[i].paint);
      }
    else if(drawingPoints[i]!=null && drawingPoints[i+1] == null)
      {
        offsetList.clear();
        offsetList.add(drawingPoints[i].offset);

        canvas.drawPoints(PointMode.points, offsetList, drawingPoints[i].paint);
      }
  }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class DrawingPoint{
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}