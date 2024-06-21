import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nama extends StatelessWidget {
  final String title;
  const Nama({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.amber.shade300,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Icon(
            Icons.person,
            size: 30,
            color: Color(0xFF1F1D2B),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
