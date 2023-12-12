import 'package:fitness_tracker/models/exercises_types.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/utils/image_util.dart';
import 'package:flutter/material.dart';

class AddExerciseTile extends StatefulWidget {
  const AddExerciseTile({
    super.key,
    required this.exerciseTypesItem,
    required this.onSelected,
    this.isSelected = false,
  });

  final ExerciseTypes exerciseTypesItem;
  final void Function(ExerciseTypes exercise) onSelected;
  final bool isSelected;

  @override
  State<AddExerciseTile> createState() => _AddExerciseTileState();
}

class _AddExerciseTileState extends State<AddExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelected(widget.exerciseTypesItem),
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected
              ? AppColor.green.withOpacity(0.6)
              : AppColor.lightGreen,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(
              fromBase64ToBytes(widget.exerciseTypesItem.image),
              height: 50,
            ),
            Text(
              widget.exerciseTypesItem.name,
              style: const TextStyle(color: AppColor.beige),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
