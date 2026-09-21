import 'package:flutter/material.dart';
import 'package:vlr/services/custom_text.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Shopping Screen"),
      ),
      body: Center(
        child: CustomText("Shopping Screen"),
      ),
    );
  }
}
