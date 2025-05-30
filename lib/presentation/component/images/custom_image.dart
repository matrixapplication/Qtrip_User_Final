import 'dart:io';

import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/resources/decoration.dart';

import '../../../../generated/assets.dart';
import '../../../core/assets_constant/images.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/utils/attach_image.dart';
import '../../../core/utils/validators.dart';
class CustomImage extends StatelessWidget {
  final double radius;
  final BorderRadius? borderRadius;
  final Border? border;

  final double? width;
  final double height;

  final String? imageUrl;
  final BoxFit? fit;
  final String? error;

  final bool canEdit;
  final bool showBorder;
  final bool showPlaceholder;
  final Function(String path)? onAttachImage;

  const CustomImage(
      {Key? key,
        this.radius = 16,
        this.borderRadius,
        this.border,
        this.error,
        this.fit= BoxFit.fill ,
        this.canEdit=false,
        this.showBorder=true,
        this.showPlaceholder=true,
        this.height =140,
        this.onAttachImage,
        this.width,
        required this.imageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Stack(
        children:[ ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius.r)),
          child: Container(
            decoration: const BoxDecoration().listStyle().borderStyle(color: error!=null?Theme.of(context).canvasColor:Theme.of(context).hintColor,width: showBorder?1:0).customRadius(borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius.r))),
            child: (imageUrl ?? '' ).isEmpty
                ? _buildPlaceholder()
                : imageUrl!.endsWith('.svg')
                ? SvgPicture.network(imageUrl! ,width: width ?? deviceWidth, height: height)
                : imageUrl!.contains('assets/images/')
                ? Image.asset(imageUrl! ,width: width ?? deviceWidth, height: height)
                : !Validators.isURL(imageUrl)
                ? Image.file(File(imageUrl!), width: width ?? deviceWidth, height: height, fit: BoxFit.fill)
                : CachedNetworkImage(
              placeholder: (ctx, url) => _buildPlaceholder(),
              width: width ?? deviceWidth,
              height: height,
              fit: fit,
              imageUrl: imageUrl ?? '',
              errorWidget: (c, o, s) => _buildPlaceholder(),
            ),
          ),
        ),
          if (canEdit)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                height: 32.r,
                width: 32.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:showBorder? border??Border.all(width: 3, color: Theme.of(context).scaffoldBackgroundColor,):null,
                  color: Theme.of(context).primaryColor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      String? path = await onPickImagesPressed(context);
                      if (path != null && onAttachImage != null) {
                        onAttachImage!(path);
                      }
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ]);
  }
  _buildPlaceholder(){
    return showPlaceholder?Image.asset(AppImages.holder,
      width: width ?? deviceWidth,
      height: height,
      fit: fit?? BoxFit.fill,
    ):const SizedBox();
  }
}
