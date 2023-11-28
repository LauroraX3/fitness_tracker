import 'package:flutter/material.dart';

import '../style/app_color.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.title,
    this.icon,
    this.iconFunction,
    this.content,
  });

  final String title;
  final IconData? icon;
  final Function? iconFunction;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColor.beige,
                fontSize: 16,
              ),
            ),
            if (icon != null)
              IconButton(
                onPressed: () {},
                icon: Icon(icon),
                color: AppColor.lightGreen,
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (content != null) content!,
        const SizedBox(height: 16),
      ],
    );
  }
}
