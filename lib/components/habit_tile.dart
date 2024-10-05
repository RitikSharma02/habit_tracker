import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
 final String habitName;
 final bool habitCompleted;
 final Function(bool?)? onChanged;



  HabitTile({super.key, required this.habitName, required this.habitCompleted, required this.onChanged});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child:  Padding(
          padding: EdgeInsets.all(24.0),
          child: Row(
            children: [
              // checkbox
              Checkbox(value: habitCompleted,

                  onChanged: onChanged  ),
              // habit name
              Text(habitName),
            ],
          ),
        ),
      ),
    );
  }
}
