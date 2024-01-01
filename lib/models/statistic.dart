import 'dart:ffi';

import 'package:equatable/equatable.dart';

class Statistic extends Equatable {
  const Statistic({
    required this.calories,
    required this.totalTrainingTime,
    this.image,
  });

  final double calories;
  final DateTime totalTrainingTime;
  final String? image;

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
        calories: json['calories'] as double,
        totalTrainingTime: json['totalTrainingTime'] as DateTime,
        image: json['image'] as String);
  }

  Map<String, dynamic> toJson() => {
        'calories': calories,
        'totalTrainingTime': totalTrainingTime,
        'image': image,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        calories,
        totalTrainingTime,
        image,
      ];
}
