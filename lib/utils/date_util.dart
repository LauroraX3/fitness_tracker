import 'package:intl/intl.dart';

String durationToString(int? hours, int? minutes) {
  if (hours == null && minutes == null) {
    return 'brak aktywności';
  }

  String durationTime = '';
  String text = '';

  switch (hours ?? 0) {
    case 0:
      text = '';
    case 1:
      text = 'godzina';
    case 2:
    case 3:
    case 4:
    case 22:
    case 23:
    case 24:
      text = 'godziny';
    default:
      text = 'godzin';
  }

  if (text.isNotEmpty) {
    durationTime += '$hours $text';
    text = '';
  }

  switch (minutes ?? 0) {
    case 0:
      text = '';
    case 1:
      text = 'minuta';
    default:
      final lastCharacter =
          minutes.toString().substring(minutes.toString().length - 1);

      if (lastCharacter.contains('2') ||
          lastCharacter.contains('3') ||
          lastCharacter.contains('4')) {
        text = 'minuty';
      } else {
        text = 'minut';
      }
  }

  if (text.isNotEmpty) {
    if (durationTime.isNotEmpty) {
      durationTime += ' ';
    }

    durationTime += '$minutes $text';
    text = '';
  }

  return durationTime;
}

String fullDateTimeAsString(DateTime datetime) {
  return DateFormat('E d MMMM | y', 'pl').format(datetime);
}
