String durationToString(DateTime duration) {
  String durationTime = '';
  String text = '';

  final hours = duration.hour;

  switch (hours) {
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

  final minutes = duration.minute;

  switch (minutes) {
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
