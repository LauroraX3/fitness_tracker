import 'package:firebase_database/firebase_database.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/models/exercise_goals.dart';
import 'package:fitness_tracker/models/statistic.dart';
import 'package:fitness_tracker/screens/add_exercise_screen/add_exercise_screen.dart';
import 'package:fitness_tracker/screens/exercises_list_screen/exercises_list_screen.dart';
import 'package:fitness_tracker/screens/home_screen/widgets/exercise_card.dart';
import 'package:fitness_tracker/screens/home_screen/widgets/goal_chips.dart';
import 'package:fitness_tracker/screens/home_screen/widgets/statistic_card.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/utils/image_util.dart';
import 'package:fitness_tracker/widgets/section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            const HomeExercisesSection(),
            const HomeExerciseGoalsSection(),
            StreamBuilder<Statistic>(
              stream: _statisticStream(),
              builder: (context, snapshot) {
                final statistic = snapshot.data;

                return Section(
                  title: 'Statystyki',
                  content: StatisticCard(statistic: statistic),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Stream<Statistic> _statisticStream() {
    final ref = FirebaseDatabase.instance
        .ref('/statistics')
        .child(DateFormat('d-MM-y').format(DateTime.now()));
    return ref.onValue.map(
      (e) => Statistic.fromJson(
          Map<String, dynamic>.from(e.snapshot.value as Map)),
    );
  }
}

class HomeExercisesSection extends StatelessWidget {
  const HomeExercisesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
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
        child: StreamBuilder<List<Exercise>>(
            stream: _exercisesStream(),
            builder: (_, snapshot) {
              final exercises = snapshot.data ?? [];

              if (exercises.isEmpty) {
                return const Center(
                  child: Text(
                    'Brak aktywności dzisiaj',
                    style: TextStyle(
                      color: AppColor.beige,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: exercises
                    .map((e) => ExerciseCard(
                          imageBytes: fromBase64ToBytes(e.type.image),
                          name: e.type.name,
                          duration: e.duration,
                        ))
                    .toList(),
              );
            }),
      ),
    );
  }

  Stream<List<Exercise>> _exercisesStream() {
    final ref = FirebaseDatabase.instance.ref('/exercise');

    //[m, n].map -> najpierw m, a potem n
    //Stream<U>.map => Stream<enum>
    //exercise = {} (Map)

    return ref.onValue.map(
      (e) => (e.snapshot.value as Map)
          .entries //ok.entries ( {"a": 4, "b": 13} => [{"a": 4}, {"b": 13}]   )
          .map((e) => Exercise.fromJson(Map<String, dynamic>.from(e.value)))
          .toList(),
    );
  }
}

class HomeExerciseGoalsSection extends StatelessWidget {
  const HomeExerciseGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExerciseGoals>>(
      stream: _goalsStream(),
      builder: (context, snapshot) {
        final goals = snapshot.data ?? [];

        return Section(
          title: 'Cele treningowe',
          icon: Icons.add,
          iconFunction: () => _addGoal(context),
          content: goals.isEmpty
              ? const Center(
                  child: Text(
                    'Brak celi treningowych na dzisiaj',
                    style: TextStyle(
                      color: AppColor.beige,
                      fontSize: 16,
                    ),
                  ),
                )
              : Wrap(
                  children: goals
                      .map(
                        (e) => GoalsChips(goal: e),
                      )
                      .toList(),
                ),
        );
      },
    );
  }

  Future<void> _addGoal(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            const AddExerciseScreen(action: ExerciseTypeAction.goal),
      ),
    );
  }

  Stream<List<ExerciseGoals>> _goalsStream() {
    final ref = FirebaseDatabase.instance.ref('/goal');
    return ref.onValue.map(
      (e) => (e.snapshot.value as Map)
          .entries
          .map(
              (e) => ExerciseGoals.fromJson(Map<String, dynamic>.from(e.value)))
          .toList(),
    );
  }
}
