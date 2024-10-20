/// return todays date formatted as yyymmdd

String todaysDateFormatted() {
  //today
  var dateTimeObject = DateTime.now();


// year in format yyyy
  String year = dateTimeObject.year.toString();
  // month in format mm

  String month = dateTimeObject.month.toString();
  if(month.length==1){
    month = '0$month';
  }

  // day in format dd
  String day = dateTimeObject.day.toString();
  if(day.length==1){
    day = '0$day';
  }

  // final format
 String yyyymmdd = year + month + day;

  return yyyymmdd;
}

// convert string yyymmmdd to DateTime object

DateTime createDateTimeObject(String yyyymmdd){
  int yyyy = int.parse(yyyymmdd.substring(0,4));
  int mm = int.parse(yyyymmdd.substring(4,6));
  int dd = int.parse(yyyymmdd.substring(6,8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;


}

// convert DateTime object to string yyyymmdd

String convertDateTimeString(DateTime dateTime){
  /// year in format yyyt

  String year = dateTime.year.toString();

  // month in mm
  String month = dateTime.month.toString();
  if(month.length ==1 ){
    month = '0$month';
  }


  // day in dd
  String day = dateTime.day.toString();
  if(day.length==1){
    day = '0$day';
  }

  //final format

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}