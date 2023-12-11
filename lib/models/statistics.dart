import 'package:equatable/equatable.dart';
import 'package:fitness_tracker/models/statistic.dart';

class Statistics extends Equatable {
  const Statistics({
    required this.id,
    this.data = const <int, Statistic>{},
  });

  final String id;
  final Map<int, Statistic> data;

  void fromJson() {}

  void toJson() {}

  @override
  List<Object?> get props => [
        id,
        data,
      ];
}
