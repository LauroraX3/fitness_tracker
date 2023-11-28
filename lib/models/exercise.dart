import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  const Exercise({
    required this.id,
    required this.typeId,
    required this.createdDate,
    required this.duration,
  });

  final String id;
  final String typeId;
  final DateTime createdDate;
  final DateTime duration;

  void fromJson() {}

  void toJson() {}

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        typeId,
        createdDate,
        duration,
      ];
}
