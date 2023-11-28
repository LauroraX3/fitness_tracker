import 'package:fitness_tracker/screens/home_screen.dart';
import 'package:fitness_tracker/style/app_color.dart';
import 'package:fitness_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          onPressed: () {},
        ),
      ),
    );
  }
}
