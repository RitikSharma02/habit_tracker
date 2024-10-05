import 'package:flutter/material.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/new_habit_box.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List todayHabitList =

  [
  // ['habit', bool ]
    ['morning run', true,],
    ['evening run', false]
  ];


// checkbox was tapped
  void checkBoxTapped(bool ? value, int index ){
    setState(() {
      todayHabitList[index][1] = value!;
    });
  }
// create a new habit

  void createNewHabit (){
    // showAlert dialog to show info to user
showDialog(context: context,
    builder: (context){
  return EnterNewHabitBox();
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        itemCount: todayHabitList.length,
        itemBuilder: (BuildContext context, int index)
        {
          return HabitTile(
    habitName: todayHabitList[index][0],
    habitCompleted: todayHabitList[index][1],
    onChanged: (value) => checkBoxTapped(value, index),
);
        
      },

      ),

    );
  }
}

