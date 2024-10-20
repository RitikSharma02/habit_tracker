import 'package:flutter/material.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive/hive.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/my-alert-box.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

HabitDatabase db = HabitDatabase();
final _myBox = Hive.box("Habit_Database");

@override
  void initState() {
   // if there is no habit list this is first time opening the app
  // then create default data
  if(_myBox.get("CURRENT_HABIT_LIST")==null){
db.createDefaultData();
  }
  // this means theres already data present
  else{
    db.loadData();
  }
  //update the database
  db.updateDatabase();
    super.initState();
  }


// checkbox was tapped
  void checkBoxTapped(bool ? value, int index ){
    setState(() {
      db.todayHabitList[index][1] = value!;
      db.updateDatabase();
      db.loadHeatMap();
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
      db.todayHabitList.add([_newHabitController.text, false]);
    });


//clear text field
    _newHabitController.clear();
// pop dialog box
    Navigator.pop(context);
    db.updateDatabase();
  }
  // cancel new habit
  void cancelDialogBox(){
// clear text field
    _newHabitController.clear();
// pop dialog box
    Navigator.pop(context);
    db.updateDatabase();
  }
//open habit Settings

  void openHabitSettings(int index){
    showDialog(context: context, builder: (context){

return MyAlertBox(
    controller: _newHabitController ,
    onSave : ()=> saveExistingHabit(index),
    onCancel: cancelDialogBox,
     hintText:  db.todayHabitList[index][0],
);

    });
  }

  // save Existing habit

  void saveExistingHabit(int index){
    setState(() {
      db.todayHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete index
  void deleteHabit(int index){
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      backgroundColor: Colors.grey[300],
      body:ListView(
        children: [
          // monthly summary heat map 
          
          MonthlySummary(startDate: _myBox.get("START_DATE"), datasets: db.heatMapDataSet,),

          // list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:  db.todayHabitList.length,
            itemBuilder: (BuildContext context, int index)
            {
              return HabitTile(
                habitName:  db.todayHabitList[index][0],
                habitCompleted:  db.todayHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );

            },

          ),
        ],
      )

    );
  }
}

