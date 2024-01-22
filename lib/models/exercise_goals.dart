import 'package:equatable/equatable.dart';

class ExerciseGoals extends Equatable {
  const ExerciseGoals({
    required this.id,
    required this.trainingTitle,
    required this.time,
  });

  final String id;
  final String trainingTitle;
  final String time;

  factory ExerciseGoals.fromJson(Map<String, dynamic> json) {
    return ExerciseGoals(
      id: json['id'] as String,
      trainingTitle: json['trainingTitle'] as String,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'trainingTitle': trainingTitle,
        'time': time,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        trainingTitle,
        time,
      ];
}
