import 'package:firebase_database/firebase_database.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:fitness_tracker/models/exercise_goals.dart';
import 'package:fitness_tracker/models/exercises_types.dart';
import 'package:fitness_tracker/models/statistic.dart';
import 'package:fitness_tracker/screens/add_exercise_screen/add_exercise_tile.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

enum ExerciseTypeAction {
  exercise,
  goal,
}

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({
    super.key,
    this.action = ExerciseTypeAction.exercise,
  });

  final ExerciseTypeAction action;

  @override
  AddExerciseScreenState createState() => AddExerciseScreenState();
}

class AddExerciseScreenState extends State<AddExerciseScreen> {
  final _exerciseTimeRangeController = TextEditingController();
  ExerciseTypes? selectedExercise;

  late final _exerciseTypeListFuture = _exerciseTypeList();

  @override
  void dispose() {
    _exerciseTimeRangeController.dispose();
    super.dispose();
  }

  void _onExerciseTap(ExerciseTypes exercise) {
    setState(() {
      if (selectedExercise == exercise) {
        selectedExercise = null;
      } else {
        selectedExercise = exercise;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGreen,
      appBar: CustomAppBar(
        title: widget.action == ExerciseTypeAction.exercise
            ? 'Dodaj aktywność'
            : 'Dodaj cel treningowy',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _onTapExerciseTime,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: _exerciseTimeRangeController.text.isEmpty
                                ? null
                                : 'Czas trwania',
                            floatingLabelStyle: const TextStyle(
                                color: AppColor.beige, fontSize: 18),
                            suffixIcon: const Icon(Icons.access_time_filled),
                            suffixIconColor: AppColor.beige,
                            fillColor: AppColor.lightGreen,
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.lightGreen,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Text(
                            _exerciseTimeRangeController.text.isEmpty
                                ? 'Czas trwania'
                                : _exerciseTimeRangeController.text,
                            style: const TextStyle(color: AppColor.beige),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Wybrana aktywność',
                        style: TextStyle(color: AppColor.beige, fontSize: 16),
                      ),
                      if (selectedExercise != null)
                        Text(
                          selectedExercise!.name,
                          style: const TextStyle(
                              color: AppColor.beige, fontSize: 16),
                        ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _exerciseTimeRangeController.text.isNotEmpty &&
                        (selectedExercise != null)
                    ? _save
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.beige,
                  foregroundColor: AppColor.darkGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                  ),
                ),
                child: const Text(
                  'Zapisz',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Aktywności',
                style: TextStyle(color: AppColor.beige, fontSize: 16),
              ),
            ),
            FutureBuilder<List<ExerciseTypes>>(
              future: _exerciseTypeListFuture,
              builder: (context, state) {
                if (state.connectionState != ConnectionState.done) {
                  return const Center(
                    child:
                        CircularProgressIndicator(color: AppColor.lightGreen),
                  );
                }

                final data = state.data ?? [];

                return Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var exerciseTypesItem = data[index];
                      return AddExerciseTile(
                        exerciseTypesItem: exerciseTypesItem,
                        isSelected: selectedExercise == exerciseTypesItem,
                        onSelected: _onExerciseTap,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapExerciseTime() async {
    TimeRange? pickedTimeRange = await showTimeRangePicker(
      fromText: 'Od',
      toText: 'Do',
      backgroundColor: AppColor.lightGreen,
      selectedColor: AppColor.darkGreen,
      handlerColor: AppColor.darkGreen,
      strokeColor: AppColor.darkGreen,
      labelStyle: const TextStyle(color: Colors.black),
      context: context,
    );

    if (pickedTimeRange != null) {
      final startTime = pickedTimeRange.startTime;
      final endTime = pickedTimeRange.endTime;

      final now = DateTime.now();
      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        startTime.hour,
        startTime.minute,
      );
      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        endTime.hour,
        endTime.minute,
      );

      Duration? durationRange;

      if (endDateTime.isBefore(startDateTime)) {
        durationRange =
            endDateTime.add(const Duration(days: 1)).difference(startDateTime);
      } else {
        durationRange = endDateTime.difference(startDateTime);
      }

      final hours = durationRange.inMinutes ~/ 60;
      final minutes = durationRange.inMinutes % 60;

      setState(() {
        _exerciseTimeRangeController.text = '${hours}h ${minutes}m';
      });
    }
  }

  Future<List<ExerciseTypes>> _exerciseTypeList() async {
    final ref = FirebaseDatabase.instance.ref('/exercise_type');
    final data = await ref.get();

    return ExerciseTypes.fromJsonList(
      (data.value as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
    );
  }

  Future<void> _save() async {
    if (widget.action == ExerciseTypeAction.exercise) {
      final ref = FirebaseDatabase.instance.ref('/exercise');

      final refKey = ref.push().key!;
      final exercise = Exercise(
        id: refKey,
        type: selectedExercise!,
        createdDate: DateTime.now(),
        duration: _exerciseTimeRangeController.text,
      );

      await ref.update({refKey: exercise.toJson()});
      await _updateStatistics();
    } else {
      final ref = FirebaseDatabase.instance.ref('/goal');

      final refKey = ref.push().key!;
      final goal = ExerciseGoals(
        id: refKey,
        trainingTitle: selectedExercise!.name,
        time: _exerciseTimeRangeController.text,
      );
      await ref.update({refKey: goal.toJson()});
    }

    Navigator.of(context).pop();
  }

  Future<void> _updateStatistics() async {
    final duration = _exerciseTimeRangeController.text;
    final durationSplit = //"1h 40m" => [1, 40]
        duration.split(' ').map((e) => e.substring(0, e.length - 1)).toList();

    final hours = int.parse(durationSplit.first);
    final minutes = int.parse(durationSplit.last);

    final now = DateTime.now();
    final dayNow = DateFormat('d-MM-y').format(now);
    final ref = FirebaseDatabase.instance.ref('/statistics').child(dayNow);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final statistic =
          Statistic.fromJson(Map<String, dynamic>.from(snapshot.value as Map));

      final totalMinutes = ((statistic.trainingTimeInHours + hours) * 60) +
          statistic.trainingTimeInMinutes +
          minutes;

      final updatedStatistic = Statistic(
        id: statistic.id,
        calories: statistic.calories +
            (((hours * 60 + minutes) * selectedExercise!.calories) ~/ 60),
        trainingTimeInHours: totalMinutes ~/ 60,
        trainingTimeInMinutes: totalMinutes % 60,
      );

      await ref.set(updatedStatistic.toJson());
    } else {
      final pushedRef = ref.push();

      final statistic = Statistic(
        id: pushedRef.key!,
        calories: ((hours * 60 + minutes) * selectedExercise!.calories) ~/ 60,
        trainingTimeInHours: hours,
        trainingTimeInMinutes: minutes,
      );

      await ref.set(statistic.toJson());
    }
  }
}
