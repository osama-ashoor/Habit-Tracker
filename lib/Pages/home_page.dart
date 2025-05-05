import 'package:flutter/material.dart';
import 'package:habit_tracker/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Habit Tracker',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).themeData.brightness ==
                      Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              size: 26,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Habit Tracker',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
