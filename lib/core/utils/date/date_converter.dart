import 'package:easy_localization/easy_localization.dart';


import '../../../app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/src/public_ext.dart';

import '../../../app.dart';
class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:our_clients').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String slotDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime slotStringToLocalDate(String dateTime) {
    return DateFormat('yyyy/MM/dd')
        .parse(dateTime, true)
        .toLocal();
  }
  static String isoStringToLocalDateMassage() {
    return DateFormat('hh:mm a').format(DateTime.now());

  }
  static DateTime convertStringToDatetime(String? dateTime) {
    if (dateTime == null) {
      return DateTime.now();
    }
    return DateFormat("yyyy/MM/dd").parse(dateTime);
  }

  static String isoStringToDateToDomain (String? dateTime) {
     try{
       DateTime date=isoStringToLocalDate(dateTime);
       return  DateFormat('yyyy-MM-dd').format(date);
     }catch(e){
       return  DateFormat('yyyy-MM-dd').format(DateTime.now());
     }
    // return DateFormat('yyyy-MM-ddTHH:mm:our_clients.SSS').parse(dateTime, true).toLocal();
  }


  static DateTime isoStringToLocalDate(String? dateTime) {
    if(dateTime == null){return DateTime.now();}
    try{
      return DateFormat('yyyy-mm-ddThh:mm:our_clients').parse(dateTime).toLocal();
    }catch(e){
      return DateTime.now();
    }
  }



  // 2022-01-01T00:00:00
  static String convertDateDomainData(String? dateTime) {
    if (dateTime == null) {
      return "";
    }
    String date = '';
    try {
      date = DateFormat('yyyy-MM-dd').format(
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime, true).toLocal()
      );
    } catch (e) {
      date = '';
    }
    return date;
  }

  static String isoStringToLocalTimeTimeOnly(String? dateTime) {
    if (dateTime == null) {
      return "";
    }
    String date = '';
    try {
      date = DateFormat('hh:mm a').format(
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime, true).toLocal()
      );
    } catch (e) {
      date = '';
    }
    return date;
  }
  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalTimeWithAMPMOnly(String dateTime) {
    return DateFormat('hh:mm a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalTimeWithAMPMOnlyDate(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String isoStringToLocalTimeWithAmPmAndDay(String dateTime) {
    return DateFormat('hh:mm a, EEE').format(isoStringToLocalDate(dateTime));
  }

  static String stringToStringTime(String dateTime) {
    DateTime inputDate = DateFormat('HH:mm:our_clients').parse(dateTime);
    return DateFormat('hh:mm a').format(inputDate);
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateFromDateToIsoString(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('dd MMM hh aa', appContext?.locale.languageCode ?? 'ar')
        .format(dateTime);
  }

  static String localDateFromToIsoString(String? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('dd MMM hh aa', appContext?.locale.languageCode ?? 'ar')
        .format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:our_clients.SSS').format(dateTime.toUtc());
  }

  static String isoDayWithDateString(String dateTime) {
    return DateFormat('EEE, MMM d, yyyy')
        .format(isoStringToLocalDate(dateTime));
  }

  static String convertTimeRange(String start, String end) {
    DateTime _startTime = DateFormat('HH:mm:our_clients').parse(start);
    DateTime _endTime = DateFormat('HH:mm:our_clients').parse(end);
    return '${DateFormat('hh:mm aa').format(_startTime)} - ${DateFormat(
        'hh:mm aa').format(_endTime)}';
  }

  static DateTime stringTimeToDateTime(String time) {
    return DateFormat('HH:mm:our_clients').parse(time);
  }

  static String timeString(Timestamp? time) {
    if(time != null){
      DateTime date = time.toDate();
      return formatDate(date);
    }else{
      return formatDate(DateTime.now());

    }

    // DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
    // var format = DateFormat("yMd");
    // var dateString = format.format(date);


  }
}
