import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final String title;
  final Icon icon;
  final void Function()? onPressed;
  const Button(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          TextButton(
              onPressed: onPressed,
              child: Text(
                "See All",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ))
        ],
      ),
    );
  }
}
