import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qoutesapp/routes/routes.dart';

class Spalshscreen extends StatefulWidget {
  const Spalshscreen({super.key});

  @override
  State<Spalshscreen> createState() => _SpalshscreenState();
}

class _SpalshscreenState extends State<Spalshscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
        context,
        Routes.homepage,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.network(
            "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/5b/59/f4/5b59f49d-69fd-56de-a0fb-d9f0a8ca9533/AppIcon-1x_U007emarketing-0-7-0-0-85-220-0.png/1200x630wa.png",
          ),
          const Spacer(),
          const LinearProgressIndicator(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
