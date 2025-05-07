import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/Componets/habit_tile.dart';
import 'package:habit_tracker/Theme/theme_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController habitNameController = TextEditingController();
  TextEditingController habitDescriptionController = TextEditingController();
  late Box habitDataBox;
  late Box habitIdBox;
  late int habitId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    habitDataBox = Hive.box('habitDataBox');
    habitIdBox = Hive.box('habitIdBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            title: Text(
              'Add Habit',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: habitNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter habit name',
                      hintStyle: GoogleFonts.ibmPlexMono(),
                    ),
                  ),
                  TextField(
                    controller: habitDescriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter habit description',
                      hintStyle: GoogleFonts.ibmPlexMono(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.ibmPlexMono(),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add habit to the list
                  habitId = habitIdBox.get('habitId', defaultValue: 0);
                  habitDataBox.put(habitId, {
                    'name': habitNameController.text,
                    'description': habitDescriptionController.text,
                  });

                  // Increment the habitId for the next habit
                  habitIdBox.put('habitId', habitId + 1);

                  // Clear the text fields
                  habitNameController.clear();
                  habitDescriptionController.clear();

                  Navigator.pop(context);
                },
                child: Text(
                  'Add',
                  style: GoogleFonts.ibmPlexMono(),
                ),
              ),
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Provider.of<ThemeProvider>(context).themeData.brightness ==
                  Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
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
      body: ValueListenableBuilder(
        valueListenable: habitDataBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text(
                'No habits added yet!',
                style: GoogleFonts.ibmPlexMono(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }
          // Display the list of habits
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final habit = box.getAt(index);
              return HabitTile(
                habitName: habit['name'],
                habitDescription: habit['description'],
                habitId: habitDataBox.keyAt(index),
              );
            },
          );
        },
      ),
    );
  }
}
