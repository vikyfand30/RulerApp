import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class RulerScreen extends StatefulWidget {
  const RulerScreen({super.key});

  @override
  State<RulerScreen> createState() => _RulerScreenState();
}

class _RulerScreenState extends State<RulerScreen> {
  double verticalPosition = 150.0;
  double horizontalPosition = 150.0;
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PhotoView(
                minScale: PhotoViewComputedScale.contained,
                backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
                imageProvider: AssetImage('assets/berat-usia-0-36-laki.webp'),
              )),
        ),
        Positioned(
          top: 0,
          left: verticalPosition,
          child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  verticalPosition += details.delta.dx;
                });
              },
              child: DraggableVerticalLine()),
        ),
        Positioned(
          top: horizontalPosition,
          left: 0,
          child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  horizontalPosition += details.delta.dy;
                });
              },
              child: DraggableHorizontalLine()),
        ),
        ...points.map((point) => Positioned(
              left: point.dx,
              top: point.dy,
              child: const CircleAvatar(
                radius: 2,
                backgroundColor: Colors.black,
              ),
            )),
      ]),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              checkIntersection();
            },
            child: Container(
                color: Colors.blue,
                height: 100,
                width: 100,
                child: Center(child: Text('pencet'))),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                points.removeLast();
              });
            },
            child: Container(
                color: Colors.blue,
                height: 100,
                width: 100,
                child: Center(child: Text('hapus'))),
          ),
        ],
      ),
    );
  }

  void checkIntersection() {
    // Check if vertical and horizontal lines intersect
    if (verticalPosition <= 0 || horizontalPosition <= 0) {
      return; // Lines are not intersecting within the visible area
    }

    final intersectionPoint = Offset(verticalPosition, horizontalPosition);
    setState(() {
      points.add(intersectionPoint);
    });
  }
}

class DraggableVerticalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
    );
  }
}

class DraggableHorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
    );
  }
}

class ContainerWithCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Adjust the width of the line
      height: 30, // Adjust the height of the line
      child: CustomPaint(
        painter: LineWithCirclePainter(),
      ),
    );
  }
}

class LineWithCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw the line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width - size.height / 2, size.height / 2),
      linePaint,
    );

    // Draw the circle at the end of the line
    canvas.drawCircle(
      Offset(size.width - size.height / 2, size.height / 2),
      size.height / 2,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
