import 'package:flutter/material.dart';
import 'package:rulerapp/photoview_ruler.dart';

class OnTapCallbacksRuler extends StatelessWidget {
  const OnTapCallbacksRuler({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PhotoViewRuler(),
          )
        ],
      ),
    );
  }
}
