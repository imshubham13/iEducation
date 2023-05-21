import 'package:flutter/material.dart';
import 'package:user/constant.dart';

class StaffProfileWidgetScreen extends StatelessWidget {
  const StaffProfileWidgetScreen(
      {Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: primarycolor, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(value, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Divider(
                color: background,
                thickness: 1.0,
              ),
            ),
          ],
        ),
        const Icon(
          Icons.lock_outline,
          size: 10,
        ),
      ],
    );
  }
}
