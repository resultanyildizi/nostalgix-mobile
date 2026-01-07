import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage._();

  static MaterialPageRoute<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return HomePage._();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nostalgix'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Hello, world. Hi, chat!',
            ),
          )
        ],
      ),
    );
  }
}
