import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/Componets/habit_tile.dart';
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
        title: Text(
          'Habit Tracker',
          style: GoogleFonts.ibmPlexMono(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
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
      body: ListView(
        children: [
          HabitTile(
            habitName: 'Drink Water',
            habitDescription: 'Drink 2 liters of water daily',
          ),
          HabitTile(
            habitName: 'Code Daily',
            habitDescription: 'Code for at least 2 hours daily',
          ),
        ],
      ),
    );
  }
}
