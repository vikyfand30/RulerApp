import 'package:flutter/material.dart';
import 'package:rulerapp/photoview_no_ruler.dart';

class OnTapCallbacksExample extends StatelessWidget {
  const OnTapCallbacksExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PhotoViewContainer(),
          )
        ],
      ),
    );
  }
}
