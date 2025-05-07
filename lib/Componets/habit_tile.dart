import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitTile extends StatefulWidget {
  final String habitName;
  final String habitDescription;
  HabitTile(
      {super.key, required this.habitName, required this.habitDescription});

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  Map<DateTime, int> habitData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //open the box
    Box habitBox = Hive.box('habitBox');
    //check if the box is empty

    if (habitBox.get(widget.habitName) != null) {
      //if not empty, get the data from the box
      Map<DateTime, int> data =
          habitBox.get(widget.habitName).cast<DateTime, int>();
      //add the data to the habitData map
      habitData.addAll(data);
    } else {
      //if empty, create a new map
      habitData = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.habitName,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              widget.habitDescription,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.check_circle),
              onPressed: () {
                // Handle habit completion
                Box habitBox = Hive.box('habitBox');
                DateTime dateOnly = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                );
                // Check if the date already exists in the map
                if (habitData.containsKey(dateOnly)) {
                  // If it exists, increment the value
                  setState(() {
                    // Remove the date from the map
                    // and delete the habitdata from the box
                    habitData.remove(dateOnly);
                    habitBox.delete(widget.habitName);
                  });
                } else {
                  if (mounted) {
                    setState(() {
                      habitData.addAll(
                        {dateOnly: 1},
                      );
                    });
                  }
                  habitBox.put(widget.habitName, habitData);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: HeatMap(
              showColorTip: false,
              textColor: Theme.of(context).colorScheme.primary,
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 90)),
              datasets: habitData,
              size: 16,
              colorsets: const {
                0: Colors.red,
              },
            ),
          ),
        ],
      ),
    );
  }
}
