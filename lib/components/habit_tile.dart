import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
 final String habitName;
 final bool habitCompleted;
 final Function(bool?)? onChanged;
 final Function(BuildContext)? settingsTapped;
 final Function(BuildContext)? deleteTapped;



  HabitTile({super.key, required this.habitName, required this.habitCompleted, required this.onChanged, this.settingsTapped, this.deleteTapped});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane:  ActionPane(
          motion: StretchMotion(),
          children: [
// settings option
          SlidableAction(onPressed: settingsTapped,
          backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(12),
          ),
          // delete option
            SlidableAction(onPressed: deleteTapped,
              backgroundColor: Colors.red.shade800,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        // startActionPane: ,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child:  Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Row(
                  children: [
                    // checkbox
                    Checkbox(
                        value: habitCompleted,
                        onChanged: onChanged  ),
                    // habit name
                    Text(habitName),
                  ],
                )),
                Icon(Icons.arrow_back),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
