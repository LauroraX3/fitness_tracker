import 'package:fitness_tracker/models/exercises_list.dart';
import 'package:fitness_tracker/screens/exercises_list_screen/exercise_tile.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:fitness_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ExercisesListScreen extends StatefulWidget {
  const ExercisesListScreen({super.key});

  @override
  State<ExercisesListScreen> createState() => _ExercisesListScreenState();
}

class _ExercisesListScreenState extends State<ExercisesListScreen> {
  List<ExerciseList> exercisesGroup = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      exercisesGroup = ExerciseList.fromExercises([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGreen,
      appBar: const CustomAppBar(
        title: 'Historia aktywności',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: exercisesGroup.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    fullDateTimeAsString(exercisesGroup[index].date),
                    style: const TextStyle(color: AppColor.beige, fontSize: 16),
                  ),
                ),
                ...List.generate(
                  exercisesGroup[index].trainings.length,
                  (i) => ExerciseTile(
                      exercise: exercisesGroup[index].trainings[i]),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
