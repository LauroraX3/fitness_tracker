import 'package:fitness_tracker/screens/add_exercise_screen/add_exercise_screen.dart';
import 'package:fitness_tracker/screens/home_screen/home_screen.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('pl', 'PL'),
      supportedLocales: const <Locale>[Locale('pl', 'PL')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Monitor kondycji',
          ),
          body: const HomeScreen(),
          backgroundColor: AppColor.darkGreen,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.lightGreen,
            foregroundColor: AppColor.beige,
            elevation: 8,
            highlightElevation: 12,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddExerciseScreen(),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
