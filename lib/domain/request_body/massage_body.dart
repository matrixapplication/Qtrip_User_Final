
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/date/date_converter.dart';
import '../../core/utils/globals.dart';

class   MassageBody  {
  final String? _massage;
  String? _messageId;
  final LatLng? _latLng;
  final String _tripId;

  MassageBody({
    String? massage,
    String? messageId,
    required String tripId,
    LatLng? latLng,
  })  : _massage = massage,
        _latLng = latLng,
        _messageId = messageId,
        _tripId = tripId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_id'] = 'user-${kUser?.id}';
    data['isRead'] = false;
    data['message'] = _massage;
    data['messageId'] = _messageId;
    data['lat'] = _latLng?.latitude??0;
    data['lng'] = _latLng?.longitude??0;
    data['time'] = DateConverter.isoStringToLocalDateMassage();

    return data;
  }
  pushMessageId(String messageId) => _messageId = messageId;
  String get tripId => _tripId;
}
