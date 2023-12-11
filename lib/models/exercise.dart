import 'package:equatable/equatable.dart';
import 'package:fitness_tracker/models/exercises_types.dart';

class Exercise extends Equatable {
  const Exercise({
    required this.id,
    required this.type,
    required this.createdDate,
    required this.duration,
  });

  final String id;
  final ExerciseTypes type;
  final DateTime createdDate;
  final DateTime duration;

  void fromJson() {}

  void toJson() {}

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        type,
        createdDate,
        duration,
      ];
}
