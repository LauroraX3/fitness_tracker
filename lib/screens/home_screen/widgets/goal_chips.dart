import 'package:firebase_database/firebase_database.dart';
import 'package:fitness_tracker/models/exercise_goals.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:flutter/material.dart';

class GoalsChips extends StatelessWidget {
  const GoalsChips({
    super.key,
    required this.goal,
  });

  final ExerciseGoals goal;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColor.beige,
      elevation: 20,
      deleteIconColor: AppColor.green,
      labelPadding: const EdgeInsets.all(4.0),
      label: Text(
        '${goal.trainingTitle} przez ${goal.time}',
        style: const TextStyle(color: AppColor.darkGreen),
      ),
      onDeleted: () async {
        FirebaseDatabase.instance.ref('/goal').child(goal.id).remove();
      },
    );
  }
}
