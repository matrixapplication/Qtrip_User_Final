// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:q_trip_user_captain/core/extensions/num_extensions.dart';
// import 'package:q_trip_user_captain/core/resources/text_styles.dart';
// import 'package:q_trip_user_captain/core/routing/navigation_services.dart';
// import 'package:q_trip_user_captain/presentation/component/component.dart';
// import 'package:q_trip_user_captain/presentation/component/images/attach_image.dart';
//
// import '../../../../core/resources/resources.dart';
// import '../../../../domain/request_body/document_body.dart';
// import '../../../../generated/locale_keys.g.dart';
// import 'document_management_cubit.dart';
//
// class DocumentManagementScreen extends StatefulWidget {
//   const DocumentManagementScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DocumentManagementScreen> createState() => _DocumentManagementScreenState();
// }
//
// class _DocumentManagementScreenState extends State<DocumentManagementScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late DocumentManagementCubit _cubit;
//
//   final TextEditingController _driverLicenseNumberController = TextEditingController();
//   final TextEditingController _driverLicenseDueDateController = TextEditingController();
//
//
//
//
//   void _onSubmit(context) async {
//     if (_formKey.currentState != null) {
//       if (_formKey.currentState!.validate()) {
//         _formKey.currentState!.save();
//
//         String licenseNumber = _driverLicenseNumberController.text;
//         String licenseDueDate = _driverLicenseDueDateController.text;
//
//
//         var response = await _cubit.updateDocumentManagement(licenseNumber: licenseNumber, licenseDueDate: licenseDueDate);
//         if (response.isSuccess) {
//           NavigationService.goBack();
//         }
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _cubit =  BlocProvider.of<DocumentManagementCubit>(context,listen: false);
//     _cubit.getUser();
//   }
//   @override
//   Widget build(BuildContext context) {
//     DocumentBody body = context.watch<DocumentManagementCubit>().body;
//     DocumentManagementState state = context.watch<DocumentManagementCubit>().state;
//     return  Scaffold(
//       appBar: CustomAppBar(title: tr(LocaleKeys.documentManagement)),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(kScreenPaddingNormal),
//           child: ScreenStateLayout(
//             isLoading: state is DocumentManagementProfileLoading ,
//             builder:(context) => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Expanded(
//                   child:  Form(key: _formKey,
//                     child: ListAnimator(
//                       children: [
//                         VerticalSpace(kScreenPaddingNormal.h),
//                         Text(tr(LocaleKeys.nationalIDCard),style:const TextStyle().titleStyle(),),
//                         Row(
//                           children: [
//                             Expanded(child: AttachImageView(title: tr(LocaleKeys.frontSide),selectedImage:body.nationalIdImageFront ,onAttachImage: _cubit.updateNationalIdImageFront)),
//                             HorizontalSpace(kFormPaddingAllLarge.w),
//                             Expanded(child: AttachImageView(title: tr(LocaleKeys.backSize),selectedImage:body.nationalIdImageBack ,onAttachImage: _cubit.updateNationalIdImageBack)),
//                           ],
//                         ),
//                         VerticalSpace(kScreenPaddingNormal.h),
//                         Text(tr(LocaleKeys.license),style: const TextStyle().titleStyle(),),
//
//
//                         Row(
//                           children: [
//                             Expanded(child: AttachImageView(title: tr(LocaleKeys.frontSide),selectedImage:body.driverLicenseImageFront ,onAttachImage: _cubit.updateDriverLicenseImageFront)),
//                             HorizontalSpace(kFormPaddingAllLarge.w),
//                             Expanded(child: AttachImageView(title: tr(LocaleKeys.backSize),selectedImage:body.driverLicenseImageBack ,onAttachImage: _cubit.updateDriverLicenseImageBack)),
//                           ],
//                         ),
//                         CustomTextFieldNumber(controller: _driverLicenseNumberController, hint: tr(LocaleKeys.driverLicenseNumber), label: tr(LocaleKeys.driverLicenseNumber),defaultValue: body.driverLicenseNumber),
//                         // CustomTextFieldNumber(controller: _driverLicenseNumberController, hint: tr(LocaleKeys.driverLicenseNumber), label: tr(LocaleKeys.driverLicenseNumber),textInputAction: TextInputAction.next,autofocus: true,defaultValue: body.driverLicenseNumber),
//                         CustomTextFieldDate(controller: _driverLicenseDueDateController, hint: tr(LocaleKeys.driverLicenseDueDate), label: tr(LocaleKeys.driverLicenseDueDate),textInputAction: TextInputAction.next,autofocus: true,defaultValue: body.driverLicenseDueDate),
//                         VerticalSpace(kScreenPaddingNormal.h),
//                       ],
//                     ),
//                   ),
//                 ),
//                 CustomButton(
//                   onTap: () => _onSubmit(context),
//                   isRounded: true,
//                   loading: (state is DocumentManagementLoading),
//                   color: Theme.of(context).primaryColor,
//                   title: tr(LocaleKeys.submit),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
