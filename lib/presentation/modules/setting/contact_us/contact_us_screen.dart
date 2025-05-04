import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/utils/show_toast.dart';



import '../../../../core/resources/resources.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../data/model/base/response_model.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/component.dart';
import '../../../component/social_media_widget.dart';
import '../../get_social_media/get_social_media_screen.dart';
import 'contact_us_cubit.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();

 late TextEditingController _nameController ;
 late TextEditingController _emailController ;
 late TextEditingController _mobileController ;
 late TextEditingController _massageController ;

  _onContactUs() async{
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ResponseModel responseModel = await BlocProvider.of<ContactUsCubit>(context,listen: false).sendContactUsRequest(
          name: _nameController.text,
          email: _emailController.text,
          mobile: _mobileController.text,
          message: _massageController.text,
        );

        if (responseModel.isSuccess) {
          showToast(text: responseModel.message??'');
          
          NavigationService.goBack();
        }
      }
    }
  }
@override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _mobileController = TextEditingController();
    _massageController = TextEditingController();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _massageController.dispose();
    super.dispose();


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: tr(LocaleKeys.contactUs2),),
      body: _buildForm(),
    );
  }

  _buildForm() {
    ContactUsState state = context.watch<ContactUsCubit>().state;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(kScreenPaddingNormal.r),
        child: ListAnimator(
          children: [
            SvgPicture.asset(AppImages.contact2,height: 170.h,),
            VerticalSpace(kScreenPaddingNormal.h),
            CustomTextFieldNormal(
                label: tr(LocaleKeys.name), controller: _nameController),
            CustomTextFieldEmail(
                label: tr(LocaleKeys.email), controller: _emailController),
            CustomTextFieldPhone(
                label: tr(LocaleKeys.yourPhoneNumber), controller: _mobileController),
            CustomTextFieldArea(
              label: tr(LocaleKeys.massage),
              controller: _massageController,

            ),
            12.height,
            CustomButton(
              loading: state is ContactUsLoading,
              onTap: () => _onContactUs(),
              title: tr(LocaleKeys.submit),
            ),

            // 16.height,
            const GetSocialMediaWidget(),
          ],
        ),
      ),
    );
  }



}
