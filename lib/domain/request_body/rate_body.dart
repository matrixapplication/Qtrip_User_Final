
class RateBody {
 final String _tripId;
  double? _rate;
  String? _notes;
  String? _report;

 RateBody({
    required String tripId,
     double rate =0,
     String notes ='',
     String report ='',
  })  : _tripId = tripId,
        _rate = rate,
      _report = report,
        _notes =notes;


 setRate(double rate)=>_rate = rate;
 setReport(String report)=>_report = report;
 setNotes(String notes)=>_notes = notes;



 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['trip_id'] = _tripId;
  data['rate'] = _rate;
  data['notes'] = _notes;
  data['report'] = _report;
  return data;
 }

}
