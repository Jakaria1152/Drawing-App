import 'package:flutter/material.dart';
void main()=>runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.grey.shade300,
          padding: EdgeInsets.all(10),
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
