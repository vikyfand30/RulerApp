import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewContainer extends StatefulWidget {
  const PhotoViewContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhotoViewContainerState createState() => _PhotoViewContainerState();
}

class _PhotoViewContainerState extends State<PhotoViewContainer> {
  List<Offset> points = [];

  PhotoViewControllerBase? controller;
  void onTapUp(TapUpDetails details) {
    points.add(details.localPosition);
    setState(() {});
  }

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
        title: Text('Tanpa Ruler'),
      ),
      body: Stack(
        children: [
          PhotoView.customChild(
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            enableRotation: false,
            child: Center(
              child: GestureDetector(
                  onTapUp: onTapUp,
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/berat-usia-0-36-laki.webp'),
                      ...buildTouchPoints(),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
