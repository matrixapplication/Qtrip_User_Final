import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/core/resources/resources.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/domain/provider/local_auth_cubit.dart';
import 'package:q_trip_user/domain/request_body/check_otp_body.dart';
import 'package:q_trip_user/domain/request_body/login_body.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/modules/auth/login/login_cubit.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/utils/check_update/check_upgrade.dart';
import '../../../component/inputs/custom_text_field_phone_country_network.dart';
import '../widgets/auth_header_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  late LoginViewModel _viewModel;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    UpdateChecker.checkForUpdate(context);

    _viewModel = BlocProvider.of<LoginViewModel>(context,listen: false);

  }

  void _onSubmit(context) async {
    bool checkCountry = _viewModel.checkCountry();

    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        String phone = _phoneController.text;
        String password = _passwordController.text;
        var response = await BlocProvider.of<LoginViewModel>(context,listen: false).sendOtp(  phone:phone.toString(),);

        if (response?.isSuccess??false) {
          NavigationService.push(Routes.otpScreen,arguments: {'phone':_phoneController.text ,'checkOTPType':CheckOTPType.login});
       }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if(kDebugMode){
      _phoneController.text=  '01122336619';
      // _phoneController.text=  '1007982550';
      _passwordController.text=  '123456';
    }
    LoginViewModelState state = context.watch<LoginViewModel>().state;
    LoginBody body = context.watch<LoginViewModel>().body;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      SafeArea(
        child: SingleChildScrollView(
          padding: 6.paddingHorizontal,
          child: Column(
            children: [
              5.height,
              AuthHeaderWidget(title:tr(LocaleKeys.login)),
              ListAnimator(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpace(24.h),
                        BlackBoldText(label: tr(LocaleKeys.HiWelcomeBack),fontSize: 20.sp,),
                        BlackRegularText(label: tr(LocaleKeys.weBeenMissed),fontSize: 16.sp,fontWeight: FontWeight.w300,),
                        VerticalSpace(24.h),
                        _buildForm(body),
                        VerticalSpace(24.h),
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: kFormPaddingAllSmall),
                        //     child: GestureDetector(
                        //       onTap: () {},
                        //       child: Text(
                        //         tr(LocaleKeys.forgetPassword),
                        //         textAlign: TextAlign.end,
                        //         style: const TextStyle().regularStyle().underLineStyle().copyWith(color: primaryColor,decorationColor: primaryColor),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // VerticalSpace(kScreenPaddingNormal.h),
                        Center(
                          child: CustomButton(
                            loading: (state is SendOtpLoading),
                            title: tr(LocaleKeys.login),
                            onTap: () => _onSubmit(context),
                          ),
                        ),
                        VerticalSpace(kScreenPaddingNormal.h),
                        Center(
                          child: TextClickWidget(
                            text: tr(LocaleKeys.questionCreateAccount),
                            subText: tr(LocaleKeys.signUp),
                            onTap: ()=>NavigationService.push(Routes.registerScreen),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )

    );
  }

  _buildForm(LoginBody body){
    String? countryError = context.watch<LoginViewModel>().countryError;
    return Form(key: _formKey,child: Column(
      children: [

        CustomTextFieldNormal(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.phone,
          onSubmit: ()=>_onSubmit(context),
          prefixWidget: const Icon(Icons.phone_enabled_rounded,color: primaryColor,),
          label: tr(LocaleKeys.phoneNumber) ,
          hint: tr(LocaleKeys.phoneNumber),
          controller: _phoneController,
        ),
        // CustomTextFieldPhoneCountryNetwork(
        //   selectedValue: body.country,
        //   controller: _phoneController,
        //   onSelected: _viewModel.onCountry,
        //   error: countryError,
        // ),
/*
        CustomTextFieldPhoneCode(
              label: tr(LocaleKeys.yourPhoneNumber),
              initialCountryCode: body.code,
              controller: _phoneController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              onCountryChanged: _viewModel.onCountryCode,
            ),*/
        const VerticalSpace(kScreenPaddingNormal),
        // CustomTextFieldPassword(hint: tr(LocaleKeys.password),controller: _passwordController),
      ],
    ));
  }
}


