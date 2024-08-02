import 'package:flutter/material.dart';
import 'package:flutter_tic_toc/screens/home._screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}
