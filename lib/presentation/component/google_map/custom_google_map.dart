import 'dart:async';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../../../../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/decoration.dart';
import '../custom_elevated_button.dart';
import '../custom_text_field.dart';
import 'address_location_model.dart';

class CustomGoogleMapScreen extends StatefulWidget {
  final double lat;
  final double long;
  const CustomGoogleMapScreen({super.key, required this.lat, required this.long});

  @override
  State<CustomGoogleMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<CustomGoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng? markerPosition; // Initial position (San Francisco)
  @override
  void initState() {
    markerPosition =LatLng(widget.lat, widget.long);
    getAddressPosition(LatLng(widget.lat, widget.long));
    super.initState();
  }
  TextEditingController searchController = TextEditingController();
   var getLat='';
   var getLong='';
   var getCountry='';
   var getBigCity='';
   var getCity='';
   var getLocality='';
   var getStreet='';
  var titlePosition='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${LocaleKeys.mapTitle.tr()}',
        style: TextStyle(
          fontSize: 25.sp,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w700,
        ),
        )),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
            child: CustomTextField(
                hintText: '${LocaleKeys.search.tr()}',
                controller: searchController,
                prefixIcon:
                Icon(Icons.search_sharp, color: Colors.grey.shade400),
                onFieldSubmitted: (String val){
                  _searchPlace();
                },
                textInputAction: TextInputAction.search,
                borderColor: Colors.grey.shade300),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onTap: (LatLng position) {
                _updateMarker(position);
                getAddressPosition(position);
              },
              initialCameraPosition: CameraPosition(
                target: markerPosition!,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('markerId'),
                  infoWindow: InfoWindow(title: titlePosition),
                  position: markerPosition!,
                  draggable: true,
                  onDragEnd: (LatLng newPosition) {
                    _updateMarker(newPosition);
                  },
                ),
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w ,vertical: 10.h),
            child: CustomElevatedButton(
                height: 40.h,
                width: MediaQuery.of(context).size.width*0.6,
                backgroundColor: primaryColor,
                onTap: (){
                  if(getCountry.isEmpty){
                    LatLng latLng=LatLng(widget.lat, widget.long);
                    setState(() {
                      getAddressPosition(latLng);
                    });
                  }
                  AddressLocationModel addressModel =AddressLocationModel(
                    lat: getLat.isEmpty?widget.lat.toString():getLat ,
                    long: getLong.isEmpty?widget.long.toString():getLong,
                    country: getCountry.isEmpty?'':getCountry,
                    bigCity: getBigCity.isEmpty?'':getBigCity,
                    city: getCity.isEmpty?'':getCity,
                    street: getStreet.isEmpty?'':getStreet,
                    locality: getLocality.isEmpty?'':getLocality,
                  );
                  if(getCountry.isNotEmpty){
                    // AddressCubit a =AddressCubit.get(context);
                    // a.lat=getLat.isNotEmpty?double.parse(getLat):double.parse(widget.lat.toString());
                    // a.long=getLong.isNotEmpty?double.parse(getLong):double.parse(widget.long.toString());
                    // a.locationController.text='${getCity}/${getStreet}';
                   // context.pop();
                  }
                },
                fontSize: 25,
                buttonText: '${LocaleKeys.save.tr()}'),
          ),

        ],
      ),
    );
  }
  Future<void> getAddressPosition(LatLng position)async {
    List<Placemark> p = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      getCountry=p[0].country.toString();
      getBigCity=p[0].administrativeArea.toString();
      getCity=p[0].subAdministrativeArea.toString();
      getLocality=p[0].locality.toString();
      getStreet=p[0].street.toString();
      titlePosition = '${p[0].street}';
    });
  }
  void _updateMarker(LatLng newPosition) {
    setState((){
      getAddressPosition(newPosition);
      getLat=newPosition.latitude.toString();
      getLong=newPosition.longitude.toString();
      markerPosition = newPosition;
    });
  }
  Future<void> _searchPlace() async {
    try {
      List<Location> locations = await locationFromAddress(searchController.text);
      LatLng latLng =LatLng(locations.first.latitude, locations.first.longitude);
      if (locations.isNotEmpty) {
        mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
        _updateMarker(latLng);
      } else {
      }
    } catch (e) {
    }
  }

}

