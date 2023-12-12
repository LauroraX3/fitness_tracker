import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:fitness_tracker/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Card(
        color: AppColor.lightGreen.withOpacity(0.5),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Image.memory(
            fromBase64ToBytes(exercise.type.image),
          ),
        ),
      ),
      title: Text(exercise.type.name),
      titleTextStyle: const TextStyle(color: AppColor.beige, fontSize: 18),
      subtitle: RichText(
        text: TextSpan(
          style: TextStyle(color: exercise.type.difficultyLevel.labelColor),
          children: [
            TextSpan(
              text: '${exercise.type.difficultyLevel.label},  ',
            ),
            TextSpan(
                text: '${formatDuration(exercise.duration)} ',
                style: const TextStyle(color: AppColor.beige)),
          ],
        ),
      ),
      subtitleTextStyle:
          TextStyle(color: exercise.type.difficultyLevel.labelColor),
      trailing: Text(DateFormat('Hm', 'pl').format(exercise.createdDate)),
      leadingAndTrailingTextStyle: const TextStyle(color: AppColor.beige),
    );
  }
}
