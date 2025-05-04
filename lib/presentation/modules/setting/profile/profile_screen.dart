import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/utils/globals.dart';
import 'package:q_trip_user/domain/request_body/profile_body.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/component/inputs/custom_text_field_phone_country_network.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/resources.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/selector/gender_selector_widget.dart';
import 'profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late ProfileCubit _profileCubit;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();




  void _onSubmit(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        String name = _nameController.text;
        String phone = _phoneController.text;
        String email = _emailController.text;


        var response = await _profileCubit.updateProfile(name: name, phone: phone, email: email);
        if (response.isSuccess) {
          NavigationService.goBack(kUser);
          // NavigationService.pushReplacement(Routes.settingScreen);
          // NavigationService.push(Routes.otpScreen,arguments: {'phone':_phoneController.text ,'code':_viewModel.body.code,'checkOTPType':CheckOTPType.register});

        }
      }
    }
    }

  @override
  void initState() {
    super.initState();
    _profileCubit =  BlocProvider.of<ProfileCubit>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    ProfileBody body = context.watch<ProfileCubit>().body;
    _phoneController.text=body.mobile.toString();

        ProfileState state = context.watch<ProfileCubit>().state;
    return  Scaffold(
      appBar: CustomAppBar(title:tr(LocaleKeys.profile),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kScreenPaddingNormal),
          child: Column(
            children: [
              CustomPersonImage(onAttachImage: _profileCubit.onAttachImage,imageUrl: body.image,size: 120.r,canEdit: true,),
              Expanded(
                child: ListAnimator(
                  children: [
                    VerticalSpace(kScreenPaddingNormal.h),
                    _buildForm(),
                    VerticalSpace(kScreenPaddingNormal.h),
                  ],
                ),
              ),
              // CustomButton(
              //   onTap: () {
              //     // NavigationService.push(Routes.changePasswordScreen)
              //   },
              //   isRounded: true,
              //   color: Theme.of(context).primaryColorDark,
              //   title: 'Change Password',
              // ),
              // VerticalSpace(kScreenPaddingNormal.h),

              CustomButton(
                onTap: () => _onSubmit(context),
                isRounded: true,
                loading: (state is ProfileLoading),
                color: Theme.of(context).primaryColor,
                title: tr(LocaleKeys.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
    _buildForm(){
      ProfileBody body = context.watch<ProfileCubit>().body;
      String? countryError = context.watch<ProfileCubit>().countryError;
      return Form(key: _formKey,child: Column (
        children: [
          CustomTextFieldNormal(
              label:tr(LocaleKeys.name) ,
              controller: _nameController, hint: tr(LocaleKeys.name),textInputAction: TextInputAction.next,autofocus: true,defaultValue: body.name),
          const VerticalSpace(kScreenPaddingNormal),
          // CustomTextFieldPhoneCode(label: tr(LocaleKeys.yourPhoneNumber),initialCountryCode:body.code ,controller: _phoneController,textInputAction: TextInputAction.next,onCountryChanged: _profileCubit.onCountryCode,defaultValue: body.mobile),
          // CustomTextFieldPhoneCountryNetwork(
          //   selectedValue: body.country,
          //   controller: _phoneController,
          //   onSelected: _profileCubit.onCountry,
          //   defaultValue: body.mobile,
          //   error: countryError,
          // ),
          CustomTextFieldNormal(
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.phone,
            onSubmit: ()=>_onSubmit(context),
            prefixWidget: const Icon(Icons.phone_enabled_rounded,color: primaryColor,),
            label: tr(LocaleKeys.phoneNumber) ,
            hint: tr(LocaleKeys.phoneNumber),
            controller: _phoneController,
          ),
          const VerticalSpace(kScreenPaddingNormal),
          CustomTextFieldEmail(label: tr(LocaleKeys.email),controller: _emailController,textInputAction: TextInputAction.next,defaultValue: body.email),
          const VerticalSpace(kScreenPaddingNormal),
          GenderSelectorWidget(selectedValue: body.gender,onSelected:_profileCubit.onGenderChange ),
          const VerticalSpace(kScreenPaddingNormal),
          // DeliveryTypeSelectorWidget(selectedValue: body.deliveryType,onSelected:_profileCubit.onDeliveryTypeChange ),
          const VerticalSpace(kScreenPaddingNormal),
        ],
      ),
    );
  }
}
