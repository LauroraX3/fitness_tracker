import 'package:fitness_tracker/models/exercise_goals.dart';
import 'package:fitness_tracker/models/exercises_types.dart';
import 'package:fitness_tracker/screens/exercises_list_screen/exercises_list_screen.dart';
import 'package:fitness_tracker/screens/home_screen/widgets/exercise_card.dart';
import 'package:fitness_tracker/screens/home_screen/widgets/goal_chips.dart';
import 'package:fitness_tracker/screens/home_screen/widgets/statistic_card.dart';
import 'package:fitness_tracker/utils/image_util.dart';
import 'package:fitness_tracker/widgets/section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Section(
              title: 'Ostatnie aktywności',
              icon: Icons.arrow_forward,
              iconFunction: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ExercisesListScreen(),
                  ),
                );
              },
              content: SizedBox(
                height: 165,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: exercisesTypesData
                      .map((e) => ExerciseCard(
                            imageBytes: fromBase64ToBytes(e.image),
                            name: e.name,
                            time: DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              1,
                              15,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Section(
              title: 'Cele treningowe',
              icon: Icons.add,
              content: Wrap(
                children: exercisesGoalsData
                    .map((e) => GoalsChips(
                        trainingTitle: e.trainingTitle, time: e.time))
                    .toList(),
              ),
            ),
            Section(
              title: 'Statystyki',
              content: StatisticCard(
                calories: 44,
                totalTrainingTime: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  1,
                  15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
