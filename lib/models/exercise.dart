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
  final String duration;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      type: ExerciseTypes.fromJson(
          Map<String, dynamic>.from(json['type'] as Map)),
      createdDate: DateTime.parse(json['createdDate']),
      duration: json['duration'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.toJson(),
        'createdDate': createdDate.toIso8601String(),
        'duration': duration,
      };

  @override
  List<Object?> get props => [
        id,
        type,
        createdDate,
        duration,
      ];
}
