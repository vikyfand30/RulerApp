import 'package:flutter/material.dart';
import 'package:rulerapp/main_no_ruler.dart';
import 'package:rulerapp/main_ruler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnTapCallbacksExample()));
              },
              child: Text('Tanpa Ruler')),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnTapCallbacksRuler()));
              },
              child: Text('Dengan Ruler'))
        ]),
      ),
    );
  }
}
