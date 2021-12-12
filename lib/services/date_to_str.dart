import 'package:intl/intl.dart';
import 'package:location/location.dart';
class DateToStr{
 
 static DateToStr instance = DateToStr._();
 DateToStr._();

  Map<int, String> _intToStr= {
   1: "Jan",
   2: "Feb",
   3: "Mar",
   4: "Apr",
   5: "May",
   6: "Jun",
   7: "Jul",
   8: "Aug",
   9: "Sep",
   10: "Oct",
   11: "Nov",
   12: "Dec"
  };
   

  
  String datetostr(String datetime){
    
    DateTime date = DateTime.parse(datetime);
    String day = date.day <=9 ? "0${date.day.toString()}": "${date.day.toString()}";
    String expdate =  day + " "+ _intToStr[date.month]! +" "+ date.year.toString();
    return expdate;            
  }

  String datetoTime(String datetime){
    DateTime date = DateTime.parse(datetime);
    return DateFormat('jms').format(date);            
  }

  String datetostrWithSpace(String datetime){
    
    DateTime date = DateTime.parse(datetime);
    String day = date.day <=9 ? "0${date.day.toString()}": "${date.day.toString()}";
    String expdate =  day + " " + _intToStr[date.month]! + " " + date.year.toString();
    return expdate;            
  }
}