import 'package:fitness_tracker/style/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.imageBytes,
    required this.name,
    required this.duration,
  });

  final Uint8List imageBytes;
  final String name;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 80,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.lightGreen,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: AppColor.green,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.memory(
              imageBytes,
              width: 55,
              height: 55,
            ),
            const Spacer(),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColor.beige,
              ),
            ),
            const Spacer(),
            Text(
              duration,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColor.beige,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
