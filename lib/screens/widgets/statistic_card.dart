import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticCard extends StatelessWidget {
  StatisticCard(
      {super.key, required this.calories, required this.totalTrainingTime});

  final String currentDate = DateFormat("dd.MM.yyyy").format(DateTime.now());
  final double calories;
  final DateTime totalTrainingTime;

  String caloriesName(double calories) {
    final roundedCalories = calories.round();

    return switch (roundedCalories) {
      == 1 => 'kaloria',
      == 12 || == 13 || == 14 => 'kalorii',
      _ => (roundedCalories % 10).toString().contains(RegExp('[2-4]'))
          ? 'kalorie'
          : 'kalorii'
    };
  }

  @override
  Widget build(BuildContext context) {
    var caloriesInt = calories.round();
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Card(
        color: AppColor.beige,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ćwiczenia  $currentDate',
                style: const TextStyle(color: AppColor.darkGreen),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.sunny,
                    color: AppColor.green,
                  ),
                  Text(
                    ' $caloriesInt ${caloriesName(calories)}',
                    style: const TextStyle(color: AppColor.darkGreen),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: AppColor.green,
                  ),
                  Text(
                    ' ${durationToString(totalTrainingTime)}',
                    style: const TextStyle(color: AppColor.darkGreen),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
