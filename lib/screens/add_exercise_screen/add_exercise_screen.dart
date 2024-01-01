import 'package:fitness_tracker/models/exercises_types.dart';
import 'package:fitness_tracker/screens/add_exercise_screen/add_exercise_tile.dart';
import 'package:fitness_tracker/screens/home_screen/home_screen.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});

  @override
  AddExerciseScreenState createState() => AddExerciseScreenState();
}

class AddExerciseScreenState extends State<AddExerciseScreen> {
  late TextEditingController _exerciseTimeRangeController;

  ExerciseTypes? selectedExercise;

  @override
  void initState() {
    super.initState();
    _exerciseTimeRangeController = TextEditingController(
        text: (DateFormat('HH:mm').format(DateTime.now())).toString());
  }

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
      appBar: const CustomAppBar(
        title: 'Dodaj aktywność',
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
                          onTap: () async {
                            TimeRange? pickedTimeRange =
                                await showTimeRangePicker(
                              fromText: 'Od',
                              toText: 'Do',
                              backgroundColor: AppColor.lightGreen,
                              selectedColor: AppColor.darkGreen,
                              handlerColor: AppColor.darkGreen,
                              strokeColor: AppColor.darkGreen,
                              labelStyle: TextStyle(color: Colors.black),
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
                                durationRange = endDateTime
                                    .add(const Duration(days: 1))
                                    .difference(startDateTime);
                              } else {
                                durationRange =
                                    endDateTime.difference(startDateTime);
                              }

                              final hours = durationRange!.inMinutes ~/ 60;
                              final minutes = durationRange!.inMinutes % 60;

                              setState(() {
                                _exerciseTimeRangeController.text =
                                    '${hours}h ${minutes}m';
                              });
                            }
                          },
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Czas trwania',
                              floatingLabelStyle: TextStyle(
                                  color: AppColor.beige, fontSize: 18),
                              suffixIcon: Icon(Icons.access_time_filled),
                              suffixIconColor: AppColor.beige,
                              fillColor: AppColor.lightGreen,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.lightGreen,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              _exerciseTimeRangeController.text,
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
                      ? () {
                          Navigator.of(context).pop(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
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
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: exercisesTypesData.length,
                  itemBuilder: (context, index) {
                    var exerciseTypesItem = exercisesTypesData[index];
                    return AddExerciseTile(
                      exerciseTypesItem: exerciseTypesItem,
                      isSelected: selectedExercise == exerciseTypesItem,
                      onSelected: _onExerciseTap,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
