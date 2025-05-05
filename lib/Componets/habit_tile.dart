import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final String habitDescription;

  const HabitTile(
      {super.key, required this.habitName, required this.habitDescription});

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
              habitName,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              habitDescription,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.check_circle),
              onPressed: () {
                // Handle habit completion
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: HeatMap(
              showColorTip: false,
              textColor: Theme.of(context).colorScheme.primary,
              startDate: DateTime.now().subtract(
                const Duration(
                  days: 86,
                ),
              ),
              endDate: DateTime.now(),
              datasets: {
                DateTime(2025, 5, 6): 3,
              },
              size: 14,
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
