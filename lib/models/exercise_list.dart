import 'package:equatable/equatable.dart';
import 'package:fitness_tracker/models/exercise.dart';

class ExerciseList extends Equatable {
  const ExerciseList({
    required this.date,
    required this.trainings,
  });

  final DateTime date;
  final List<Exercise> trainings;

  // ExerciseList groupExercises(List<Exercise> exercise){
  //   return ExerciseList(date: DateTime.now(), trainings: trainings);
  // };
  @override
  // TODO: implement props
  List<Object?> get props => [
        date,
        trainings,
      ];
}
