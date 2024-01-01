import 'package:equatable/equatable.dart';
import 'package:fitness_tracker/models/statistic.dart';

class Statistics extends Equatable {
  const Statistics({
    required this.id,
    this.data = const <int, Statistic>{},
  });

  final String id;
  final Map<int, Statistic> data;

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
        id: json['id'] as String, data: json['data'] as Map<int, Statistic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'data': data,
      };

  @override
  List<Object?> get props => [
        id,
        data,
      ];
}
