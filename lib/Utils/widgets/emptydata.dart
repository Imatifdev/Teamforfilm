import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListData extends StatelessWidget {
  final String message;

  const EmptyListData({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Lottie.asset('assets/icons/no_data.json'),
            Text(
              textAlign: TextAlign.center,
              message,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ))
      ],
    );
  }
}
