
import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive/hive.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
 List todayHabitList = [];
 final Map<DateTime, int>? heatMapDataSet ={};

 /// to create the data
void createDefaultData(){
  todayHabitList = [
   ['Run', false],
   ['Read', false]
  ];
  
  _myBox.put("START_DATE", todaysDateFormatted());
}

/// to load the existing data
void loadData(){
  // if its new day, get habitlist from db
if(_myBox.get(todaysDateFormatted()) == null){
  todayHabitList = _myBox.get("CURRENT_HABIT_LIST");
  // set all the habits to false since its a new day
  for(int i = 0; i< todayHabitList.length; i++){
    todayHabitList[i][1] = false;
  }
}
//if its not a new day, get todays list
else{
    todayHabitList = _myBox.get(todaysDateFormatted());
  }
} 

/// update database

void updateDatabase(){
// update todays entry
_myBox.put(todaysDateFormatted(), todayHabitList);
// update universal list in case it changed(new habit, changes habit, update habit)

_myBox.put("CURRENT_HABIT_LIST", todayHabitList);

// calculate daily habit percentage
  calculateHabitPercentages();
// load heat map
  loadHeatMap();
}



void calculateHabitPercentages(){
int countCompleted = 0;
for(int i =0; i< todayHabitList.length; i++){
  if(todayHabitList[i][1]==true){
    countCompleted++;
  }
}
String percent = todayHabitList.isEmpty ? '0.0' :  (countCompleted/todayHabitList.length).toStringAsFixed(1);

// key : "PERCENTAGE_SUMMARY_yyyymmdd"
// value : string of 1dp number between 0.0-1.0 inclusive

_myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);

}

 void loadHeatMap() {
   DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));
   int daysInBetween = DateTime.now().difference(startDate).inDays;

   for (int i = 0; i < daysInBetween + 1; i++) {
     String yyyymmdd = convertDateTimeString(startDate.add(Duration(days: i)));
     double strengthAsPercent = double.parse(_myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0");

     int year = startDate.add(Duration(days: i)).year;
     int month = startDate.add(Duration(days: i)).month;
     int day = startDate.add(Duration(days: i)).day;

     // Update the heat map data set
     heatMapDataSet?.addEntries({
       DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
     }.entries);
   }
 }



}

