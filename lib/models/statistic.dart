import 'package:equatable/equatable.dart';

class Statistic extends Equatable {
  const Statistic(
      {required this.calories, required this.totalTrainingTime, this.image});

  final double calories;
  final DateTime totalTrainingTime;
  final String? image;

  void fromJson() {}

  void toJson() {}

  @override
  // TODO: implement props
  List<Object?> get props => [
        calories,
        totalTrainingTime,
        image,
      ];
}
