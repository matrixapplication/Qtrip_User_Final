

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';

import '../../../../generated/assets.dart';
import '../../../core/assets_constant/images.dart';
import '../../../core/resources/resources.dart';
import '../../../core/utils/attach_image.dart';
import '../texts/primary_texts.dart';
import 'item_picked_image.dart';







class AttachImageView extends StatelessWidget {
  final _tag ='AttachImageView';
  final String? _selectedImage ;
  final String _title ;
  final double? _fontSize;
  final String? _error ;
  final Function(String? path)? _onAttachImage ;


  const AttachImageView({super.key,
     String? selectedImage,
    String title='',
    double? fontSize,
     String? error,
     Function(String? path)? onAttachImage,
  })  : _selectedImage = selectedImage,
        _title = title,
        _fontSize = fontSize,
        _error = error,
        _onAttachImage = onAttachImage;
  @override
  Widget build(BuildContext context) {
    return buildPictures(context, _selectedImage, _title);
  }

  Widget buildPictures(BuildContext context, String? selectedImage,String title) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Expanded(child:  Text(
               tr(title),
               style: const TextStyle().regularStyle(fontSize:_fontSize??14 ).copyWith(color: _error == null?Theme.of(context).primaryColor:Theme.of(context).canvasColor),
             ),)

            ],
          ),
          const SizedBox(height: 8),
          (selectedImage ?? '').isEmpty
              ? buildEmptyPictures(context, () async {
                    String? path = await onPickImagesPressed(context);
                    if (path != null && _onAttachImage != null) {_onAttachImage!(path);}
                  },
                )
              : buildImages(context, selectedImage),
          // if(error != null)
          // Text(
          //   error??'',
          //   style: TextStyle().regularStyle().copyWith(color:Theme.of(context).errorColor),
          // ),
        ],
      ),
    );
  }
  Widget buildImages(BuildContext context, String? selectedImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(4),
          strokeCap: StrokeCap.square,
          padding:  const EdgeInsets.all(kFormPaddingAllSmall),
          child: ItemPickedImage(
              path: selectedImage,
              onRemovePressed: () async {
                if (_onAttachImage != null) {
                  _onAttachImage!(null);
                }
              }),
        ),

      ],
    );
  }

  Widget buildEmptyPictures(BuildContext context, GestureTapCallback onPickImagesPressed) {
    return GestureDetector(
      onTap: onPickImagesPressed,
      child: DottedBorder(
        color: _error!=null?Theme.of(context).canvasColor:Colors.black,
        borderType: BorderType.RRect,
        radius: const Radius.circular(4),
        strokeCap: StrokeCap.butt,
        dashPattern: const [10],
        padding:  const EdgeInsets.all(kFormPaddingAllSmall),
        child: Center(
          child: Stack(
            children: [
              Image.asset(AppImages.holder,height: 150,fit: BoxFit.cover,),
              SizedBox(
                height: 25,
                width: 25,
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon:  Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () => {},
                ),
              )

            ],
          ),
        ),
      ),
    );
  }



}








class AttachCircleImageView extends StatelessWidget {
  final _tag ='AttachImageView';
  final String? _selectedImage ;
  final String _title ;
  final String? _error ;
  final Function(String? path)? _onAttachImage ;


  const AttachCircleImageView({super.key,
    String? selectedImage,
    String title='',
    String? error,
    Function(String? path)? onAttachImage,
  })  : _selectedImage = selectedImage,
        _title = title,
        _error = error,
        _onAttachImage = onAttachImage;
  @override
  Widget build(BuildContext context) {
    return buildPictures(context, _selectedImage, _title);
  }

  Widget buildPictures(BuildContext context, String? selectedImage,String title) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(title),
                style: const TextStyle().regularStyle().copyWith(color: _error == null?Theme.of(context).primaryColor:Theme.of(context).canvasColor),
              ),

            ],
          ),
          const SizedBox(height: 8),
          (selectedImage ?? '').isEmpty
              ? buildEmptyPictures(context, () async {
            String? path = await onPickImagesPressed(context);
            if (path != null && _onAttachImage != null) {_onAttachImage!(path);}
          },
          )
              : buildImages(context, selectedImage),
          // if(error != null)
          // Text(
          //   error??'',
          //   style: TextStyle().regularStyle().copyWith(color:Theme.of(context).errorColor),
          // ),
        ],
      ),
    );
  }
  Widget buildImages(BuildContext context, String? selectedImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DottedBorder(
          borderType: BorderType.Circle,
          radius: const Radius.circular(500),
          strokeCap: StrokeCap.butt,
          dashPattern: const [5],
          padding:  const EdgeInsets.all(kFormPaddingAllSmall),
          child:
      Center(
        child:   SizedBox(
          height: 200,
          width: 200,
          child:  ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(500)),
            child:  ItemPickedImage(

                path: selectedImage,
                onRemovePressed: () async {
                  if (_onAttachImage != null) {
                    _onAttachImage!(null);
                  }
                }),
          ),
        ),
      )
        ),

      ],
    );
  }

  Widget buildEmptyPictures(BuildContext context, GestureTapCallback onPickImagesPressed) {
    return GestureDetector(
      onTap: onPickImagesPressed,
      child:
      Stack(
        children: [
          Padding(padding: 20.paddingVert,
          child: DottedBorder(
            color: _error!=null?Theme.of(context).canvasColor:Colors.black,
            borderType: BorderType.Circle,
            radius: const Radius.circular(4),
            strokeCap: StrokeCap.butt,
            dashPattern: const [10],
            padding:  const EdgeInsets.all(kFormPaddingAllSmall),
            child:
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500),

                ),
                // Stack(
                //   children: [
                //     ClipRRect(
                //       borderRadius: const BorderRadius.all(Radius.circular(500)),
                //       child: Image.asset(Assets.imagesPlaceholder,height: 200,width: 200,fit: BoxFit.cover,),
                //     ),
                //
                //   ],
                // ),
              ),
            )
          ),
          ),
          Positioned(
              bottom: 10,
              right: 100.w,
              child:Container(
                padding: 16.paddingHorizontal+4.paddingVert,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(AppImages.imagesUpload),
                    10.width,
                    const PrimaryMediumText(label: 'Upload',fontSize: 16,),
                  ],
                ),
              ) ),
        ],
      )
    );
  }



}
