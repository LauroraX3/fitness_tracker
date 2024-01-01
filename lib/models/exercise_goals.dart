import 'package:equatable/equatable.dart';

class ExerciseGoals extends Equatable {
  const ExerciseGoals({
    required this.id,
    required this.trainingTitle,
    required this.time,
  });

  final String id;
  final String trainingTitle;
  final DateTime time;

  factory ExerciseGoals.fromJson(Map<String, dynamic> json) {
    return ExerciseGoals(
        id: json['id'] as String,
        trainingTitle: json['trainingTitle'] as String,
        time: json['time'] as DateTime);
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

final exercisesGoalsData = [
  ExerciseGoals(
    id: '0001',
    trainingTitle: 'Jazda rowerem',
    time: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 1, 0),
  ),
  ExerciseGoals(
    id: '0002',
    trainingTitle: 'Bieganie',
    time: DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 20, 0),
  ),
  ExerciseGoals(
    id: '0003',
    trainingTitle: 'Pływanie',
    time: DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 1, 30, 0),
  ),
  ExerciseGoals(
    id: '0004',
    trainingTitle: 'Piesze wędrówki',
    time: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 1, 0),
  ),
  ExerciseGoals(
    id: '0005',
    trainingTitle: 'Ćwiczenia siłowe',
    time: DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 2, 45, 0),
  ),
  ExerciseGoals(
    id: '0006',
    trainingTitle: 'Joga',
    time: DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 15, 0),
  ),
];
