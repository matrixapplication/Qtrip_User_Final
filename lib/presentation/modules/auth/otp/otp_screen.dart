import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/domain/request_body/check_otp_body.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';
import 'package:q_trip_user/presentation/component/texts/primary_texts.dart';
import 'package:q_trip_user/presentation/modules/auth/otp/otp_cubit.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../domain/entities/country_entity.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/component.dart';
import '../widgets/auth_header_widget.dart';

class OTPScreen extends StatefulWidget {
  final String _phone;
  final CheckOTPType _checkOTPType;

  @override
  _OTPScreenState createState() => _OTPScreenState();

  const OTPScreen({
    super.key,
    required String phone,
    required CheckOTPType checkOTPType,
  })  : _phone = phone,
        _checkOTPType = checkOTPType;
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _codeController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _onResendCode() async {
    await BlocProvider.of<OtpViewModelCubit>(context,listen: false).reSendCode(phone: widget._phone);
  }
  void _onSubmit(context) async {

    // NavigationService.push(Routes.driverRegistrationScreen,);

    String otp = _codeController.text;
    if (otp.length==4) {
      var response = await BlocProvider.of<OtpViewModelCubit>(context,listen: false).otpCode(phone: widget._phone,otp: otp,type: widget._checkOTPType );


      if (response.isSuccess) {
        if (widget._checkOTPType == CheckOTPType.register) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.congratulationsScreen, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, Routes.driverHomeScreen, (route) => false);
        }
      } else {
        _codeController.clear();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<OtpViewModelCubit>().isLoading;
    return Scaffold(
      // appBar: CustomAppBar(title: el.tr(LocaleKeys.phoneVerification)),
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpace(24.h),
             AuthHeaderWidget(title: '${LocaleKeys.verification.tr()}'),
            Padding(padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(24.h),
                 BlackBoldText(label: LocaleKeys.Hi.tr(),fontSize: 20,),
                 BlackRegularText(label: LocaleKeys.pleaseEnterDigitActivationCode.tr(),fontSize: 16,fontWeight: FontWeight.w300,),
                 PrimaryRegularText(label: widget._phone??'',fontSize: 16,),
                VerticalSpace(32.h),
                Directionality(textDirection: TextDirection.ltr, child: _buildForm(),),
                Center(child:   _buildResendCode(),),
                VerticalSpace(kScreenPaddingNormal.h),
                Center(child: CustomButton(loading: isLoading,title: LocaleKeys.verifyNow.tr(), onTap: ()=> _onSubmit(context))),
                VerticalSpace( kScreenPaddingNormal.h),
              ],
            ),)
          ],
        ),
      ),
    );
  }

  _buildResendCode(){
    bool isLoading = context.watch<OtpViewModelCubit>().isResendLoading;
    bool isTimerDone = context.watch<OtpViewModelCubit>().isTimerDone;
    return Column(
     children: [
       VerticalSpace( kScreenPaddingNormal.h),
       if(!isTimerDone && !isLoading)
         Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             TimerCountdown(
               format: CountDownTimerFormat.minutesSeconds,
               enableDescriptions: false,
               endTime: DateTime.now().add(const Duration(minutes: 1)),
               spacerWidth: 1.0,
               timeTextStyle: const TextStyle().regularStyle(),
               onEnd: () => BlocProvider.of<OtpViewModelCubit>(context,listen: false).onTimerEnd(),
             ),
             Text(' ${LocaleKeys.secLeft.tr()}',style:const TextStyle().regularStyle(),)
           ],
         ),
       16.height,
       isLoading?const CustomLoadingSpinner():
       TextClickWidget(
         text: LocaleKeys.iDidNotReceiveCode.tr(),
         subText: LocaleKeys.resendCode.tr(),
         onTap: ()=> _onResendCode(),
       ),
     ],
   );
  }

  _buildForm(){
    return  Center(child: PinCodeTextField(
      appContext: context,
      length: 4,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      obscureText: false,
      showCursor: false,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        inactiveColor: Colors.transparent,
        disabledColor: Theme.of(context).cardColor,
        activeColor: Colors.transparent,
        selectedColor: Colors.transparent,
        errorBorderColor: Theme.of(context).canvasColor,
        inactiveFillColor: Theme.of(context).cardColor,
        selectedFillColor: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(kFormRadius),
        fieldHeight: 48.r,
        fieldWidth: 48.r,
        activeFillColor: Theme.of(context).cardColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      textStyle: const TextStyle().titleStyle(fontSize: 24).activeColor(),
      enableActiveFill: true,
      boxShadows: const [ BoxShadow(color: grayScaleLiteColor, spreadRadius: 1, blurRadius: 5)],
      controller: _codeController,
      beforeTextPaste: (text) {return true;}, onChanged: (String value) {},
    ),);
  }
}
