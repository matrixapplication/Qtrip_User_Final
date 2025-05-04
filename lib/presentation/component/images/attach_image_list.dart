import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/resources.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/component.dart';


import '../../../../domain/logger.dart';
import '../../../../generated/assets.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/vehicle_entity.dart';

import 'item_picked_image.dart';

class AttachImageListView extends StatelessWidget {
  final _tag = 'AttachImageListView';
  final List<ImageEntity> selectedImages;

  final String title;
  final String? error;

  final ValueChanged<ImageEntity> onRemoveImage;

  final double height;

  final ValueChanged<ImageEntity> onRemoveSelectedImage;

  final Function(List<String> path)? onAttachImage;

  const AttachImageListView(
      {Key? key,
      required this.selectedImages,
      this.title = '',
      this.error ,
      required this.onRemoveImage,
      required this.onRemoveSelectedImage,
       this.onAttachImage,
      this.height = 170})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPictures(context, selectedImages, title);
  }

  Widget _buildPictures(BuildContext context, List<ImageEntity> selectedImages, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle().regularStyle()),
            if (onAttachImage != null)
              GestureDetector(
                  child: Icon(Icons.add, color: Theme.of(context).primaryColorDark,size: 20.r ),
                  onTap: () => onPickImagesPressed(context),
                ),
          ],
        ),
        VerticalSpace(5.h),
        selectedImages.isEmpty
            ? _buildEmptyPictures(context, () => onPickImagesPressed(context))
            : _buildImageList(context, selectedImages),
        if(error!=null)
          Text(error!, style: const TextStyle().descriptionStyle().errorStyle()),
      ],
    );
  }

  Widget _buildImageList(BuildContext context, List<ImageEntity> images) {
    return DottedBorder(
      borderType: BorderType.RRect,

      radius: const Radius.circular(4),
      strokeCap: StrokeCap.square,
      padding: EdgeInsets.all(kFormPaddingAllSmall.r),
      child: GridView.builder(
        shrinkWrap: true,
        primary: true,

        physics: const ClampingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80.w,
          mainAxisSpacing: 20,
          childAspectRatio: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: (height - 90).h,
        ),
        itemBuilder: (c, i) => ItemPickedImage(
          path: images[i].image,
          onRemovePressed: () => Validators.isURL(images[i].image)
              ? onRemoveImage(images[i])
              : onRemoveSelectedImage(images[i]),
        ),
        itemCount: images.length,
      ),
    );
  }

  Widget _buildEmptyPictures(BuildContext context, GestureTapCallback onPickImagesPressed) {
    return GestureDetector(
      onTap: onPickImagesPressed,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(4),
        strokeCap: StrokeCap.butt,
        dashPattern: const [10],
        padding: const EdgeInsets.all(kFormPaddingAllSmall),
        child: Center(
          child: Image.asset(
            // Assets.imagesPlaceholder,
            AppImages.holder,
            // height: (height / 2.5).h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void onPickImagesPressed(BuildContext context) async {
    List<PlatformFile>? paths;
    const multiPick = true;
    const filesType = FileType.custom;
    const extensions = 'jpg , png , jpeg';
    FocusManager.instance.primaryFocus!.unfocus();

    try {
      paths = (await FilePicker.platform.pickFiles(
        type: filesType,
        allowMultiple: multiPick,
        allowedExtensions: (true) ? extensions.replaceAll(' ', '').split(',') : null,
      ))?.files;
    } on PlatformException catch (e) {
      log(_tag, "Unsupported operation $e");
    } catch (ex) {
      log(_tag, ex.toString());
    }

    if (paths != null && onAttachImage != null) {
      log(_tag, 'onPickImagesPressed ${paths.map((e) => e.name).toString()}');
      onAttachImage!(paths.map((e) => e.path ?? '').toList());
    }
  }
}
