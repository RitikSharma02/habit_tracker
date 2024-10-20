import 'package:flutter/material.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/my-alert-box.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List todayHabitList =
  [

    ['morning run', true,],
    ['after run', true,],
    ['evening run', false]
  ];


// checkbox was tapped
  void checkBoxTapped(bool ? value, int index ){
    setState(() {
      todayHabitList[index][1] = value!;
    });
  }
// create a new habit
final _newHabitController = TextEditingController();
  void createNewHabit (){
    // showAlert dialog to show info to user
showDialog(context: context,
    builder: (context){
  return MyAlertBox(
    controller: _newHabitController,
    onSave: saveNewHabit,
    onCancel: cancelDialogBox,
    hintText: 'Enter Habit Name..',
  );
});
  }
 // save new habit
  void saveNewHabit( ){

    setState(() {
      todayHabitList.add([_newHabitController.text, false]);
    });


//clear text field
    _newHabitController.clear();
// pop dialog box
    Navigator.pop(context);
  }
  // cancel new habit
  void cancelDialogBox(){
// clear text field
    _newHabitController.clear();
// pop dialog box
    Navigator.pop(context);
  }
//open habit Settings

  void openHabitSettings(int index){
    showDialog(context: context, builder: (context){

return MyAlertBox(
    controller: _newHabitController ,
    onSave : ()=> saveExistingHabit(index),
    onCancel: cancelDialogBox,
     hintText: todayHabitList[index][0],
);

    });
  }

  // save Existing habit

  void saveExistingHabit(int index){
    setState(() {
      todayHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.pop(context);
  }

  // delete index
  void deleteHabit(int index){
    setState(() {
      todayHabitList.removeAt(index);

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
   settingsTapped: (context) => openHabitSettings(index),
   deleteTapped: (context) => deleteHabit(index),
);
        
      },

      ),

    );
  }
}

