import 'package:equatable/equatable.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:collection/collection.dart';

class ExerciseList extends Equatable {
  const ExerciseList({
    required this.date,
    required this.trainings,
  });

  final DateTime date;
  final List<Exercise> trainings;

  static List<ExerciseList> fromExercises(List<Exercise> exercises) {
    // [e, e, e, e ,e ] -> {d: [e, e, e],d: [e, e],d: [e]}
    final groupedExercises = groupBy(exercises, (p) => p.createdDate);
    return groupedExercises.entries
        .map((e) => ExerciseList(date: e.key, trainings: e.value))
        .toList();
  }

  @override
  List<Object?> get props => [
        date,
        trainings,
      ];
}
