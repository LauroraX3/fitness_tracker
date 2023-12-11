import 'package:fitness_tracker/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../utils/date_util.dart';

class GoalsChips extends StatelessWidget {
  const GoalsChips(
      {super.key, required this.trainingTitle, required this.time});

  final String trainingTitle;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColor.beige,
      elevation: 20,
      deleteIconColor: AppColor.green,
      labelPadding: const EdgeInsets.all(4.0),
      label: Text(
        '$trainingTitle przez ${durationToString(time)}',
        style: const TextStyle(color: AppColor.darkGreen),
      ),
      onDeleted: () {},
    );
  }
}
