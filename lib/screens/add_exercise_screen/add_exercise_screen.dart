import 'package:fitness_tracker/models/exercises_types.dart';
import 'package:fitness_tracker/screens/add_exercise_screen/add_exercise_tile.dart';
import 'package:fitness_tracker/screens/home_screen/home_screen.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});

  @override
  AddExerciseScreenState createState() => AddExerciseScreenState();
}

class AddExerciseScreenState extends State<AddExerciseScreen> {
  late TextEditingController _timeController;
  ExerciseTypes? selectedExercise;

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController(
        text: (DateFormat('HH:mm').format(DateTime.now())).toString());
  }

  @override
  void dispose() {
    _timeController.dispose();
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
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColor.darkGreen,
                                  onPrimary: AppColor.beige,
                                  onSurface: AppColor.green,
                                ),
                                dialogBackgroundColor: AppColor.beige,
                              ),
                              child: MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              ),
                            );
                          },
                        );

                        if (pickedTime != null) {
                          String formattedTime = pickedTime.format(context);
                          setState(() {
                            _timeController.text = formattedTime;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Czas',
                          floatingLabelStyle:
                              TextStyle(color: AppColor.beige, fontSize: 18),
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
                          _timeController.text,
                          style: const TextStyle(color: AppColor.beige),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
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
                  onPressed: _timeController.text.isNotEmpty &&
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
