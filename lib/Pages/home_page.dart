import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/Componets/habit_tile.dart';
import 'package:habit_tracker/Theme/theme_provider.dart';
import 'package:hive/hive.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    habitDataBox = Hive.box('habitDataBox');
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
                  setState(() {
                    habitDataBox.add({
                      'name': habitNameController.text,
                      'description': habitDescriptionController.text,
                    });
                  });
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
      body: ListView.builder(
        itemCount: habitDataBox.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: habitDataBox.getAt(index)['name'],
            habitDescription: habitDataBox.getAt(index)['description'],
          );
        },
      ),
    );
  }
}
