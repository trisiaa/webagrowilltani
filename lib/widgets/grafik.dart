import 'package:flutter/material.dart';
import 'package:webagro/widgets/custom_appbar.dart';

class Grafik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('Welcome to the Grafik'),
      ),
    );
  }
}