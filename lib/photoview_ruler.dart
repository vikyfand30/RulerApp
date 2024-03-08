import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewRuler extends StatefulWidget {
  const PhotoViewRuler({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhotoViewRulerState createState() => _PhotoViewRulerState();
}

class _PhotoViewRulerState extends State<PhotoViewRuler> {
  List<Offset> points = [];
  List<Offset> pointsNew = [];
  double verticalPosition = 150.0;
  double horizontalPosition = 150.0;
  PhotoViewControllerBase? controller;
  // void onTapUp(TapUpDetails details) {
  //   points.add(details.localPosition);
  //   setState(() {});
  // }

  List<Widget> buildTouchPoints() => points.map(pointToWidget).toList();

  Widget pointToWidget(Offset point) {
    return Positioned(
      top: point.dy,
      left: point.dx,
      child: Container(
        width: 5,
        height: 5,
        decoration:
            const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dengan Ruler'),
        ),
        body: Stack(
          children: [
            PhotoView.customChild(
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              enableRotation: false,
              child: Center(
                child: GestureDetector(
                    // onTapUp: onTapUp,
                    child: Stack(
                  children: <Widget>[
                    Image.asset('assets/berat-usia-0-36-laki.webp'),
                    Positioned(
                      top: 0,
                      left: verticalPosition,
                      child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              verticalPosition += details.delta.dx;
                            });
                          },
                          child: const DraggableVerticalLine()),
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
                          child: const DraggableHorizontalLine()),
                    ),
                    ...buildTouchPoints(),
                  ],
                )),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
          child: const Text('Press'),
          onPressed: () => checkIntersection(),
        ));
  }

  void checkIntersection() {
    // Check if vertical and horizontal lines intersect
    if (verticalPosition <= 0 || horizontalPosition <= 0) {
      return; // Lines are not intersecting within the visible area
    }

    double intersectionX = verticalPosition;
    double intersectionY = horizontalPosition;

    final intersectionPoint = Offset(intersectionX, intersectionY);

    setState(() {
      points.add(intersectionPoint);
    });
  }
}

class DraggableVerticalLine extends StatelessWidget {
  const DraggableVerticalLine({super.key});

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
  const DraggableHorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
    );
  }
}
