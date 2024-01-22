import 'package:equatable/equatable.dart';

class Statistic extends Equatable {
  const Statistic({
    required this.id,
    required this.calories,
    required this.trainingTimeInHours,
    required this.trainingTimeInMinutes,
  });

  final String id;
  final int calories;
  final int trainingTimeInHours;
  final int trainingTimeInMinutes;

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      id: json['id'] as String,
      calories: json['calories'] as int,
      trainingTimeInHours: json['trainingTimeInHours'] as int,
      trainingTimeInMinutes: json['trainingTimeInMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'calories': calories,
        'trainingTimeInHours': trainingTimeInHours,
        'trainingTimeInMinutes': trainingTimeInMinutes,
      };

  @override
  List<Object?> get props => [
        id,
        calories,
        trainingTimeInHours,
        trainingTimeInMinutes,
      ];
}
