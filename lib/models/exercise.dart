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

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json['id'] as String,
        type: json['type'] as ExerciseTypes,
        createdDate: json['createdDate'] as DateTime,
        duration: json['duration'] as DateTime);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'createdDate': createdDate,
        'duration': duration,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        type,
        createdDate,
        duration,
      ];
}
