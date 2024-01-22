import 'package:equatable/equatable.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:flutter/material.dart';

enum DifficultyLevel {
  easy('Łatwy', AppColor.lightGreen),
  medium('Średni', AppColor.yellow),
  hard('Trudny', AppColor.red);

  const DifficultyLevel(this.label, this.labelColor);

  final String label;
  final Color labelColor;
}

class ExerciseTypes extends Equatable {
  const ExerciseTypes({
    required this.id,
    required this.name,
    required this.calories,
    required this.difficultyLevel,
    required this.image,
  });

  final String id;
  final String name;
  final int calories;
  final DifficultyLevel difficultyLevel;
  final String image;

  factory ExerciseTypes.fromJson(Map<String, dynamic> json) {
    return ExerciseTypes(
      id: json['id'] as String,
      name: json['name'] as String,
      calories: json['calories'] as int,
      difficultyLevel: DifficultyLevel.values.byName(json['difficultyLevel']),
      image: json['image'] as String,
    );
  }

  static List<ExerciseTypes> fromJsonList(
          List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => ExerciseTypes.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'calories': calories,
        'difficultyLevel': difficultyLevel.name,
        'image': image,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        calories,
        difficultyLevel,
        image,
      ];
}
