import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTableRow extends StatelessWidget {
  final String title;
  final String content;
  const CustomTableRow({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      border: TableBorder.all(
        borderRadius: BorderRadius.circular(8.0),
      ),
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                content,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
