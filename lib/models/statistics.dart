import 'package:equatable/equatable.dart';
import 'package:fitness_tracker/models/statistic.dart';

class Statistics extends Equatable {
  Statistics({
    required this.id,
    required this.data,
  });

  final String id;
  var data = <int, Statistic>{};

  void fromJson() {}
  void toJson() {}

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        data,
      ];
}
