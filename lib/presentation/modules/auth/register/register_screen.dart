import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/core/extensions/extensions.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/domain/request_body/register_body.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/modules/auth/register/register_cubit.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../domain/request_body/check_otp_body.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/inputs/custom_text_field_phone_country_network.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/gender_widget.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late RegisterCubit _viewModel;
  
  
  void _onSubmit(context) async {


    bool isValid = _viewModel.checkTermsError();
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()&&isValid) {
        _formKey.currentState!.save();

        String name = _nameController.text;
        String phone = _phoneController.text;
        String email = _emailController.text;
        String password = _passwordController.text;


         var response = await BlocProvider.of<RegisterCubit>(context,listen: false).register(name: name, phone: phone, email: email, password: password, gender: gender);
        if (response.isSuccess) {
          NavigationService.push(Routes.otpScreen,arguments: {'phone':_phoneController.text ,'checkOTPType':CheckOTPType.register});
        }
      }
    }

    // NavigationService.push(Routes.otpScreen,arguments: {'phone':_phoneController.text ,'country':_viewModel.body.country,'checkOTPType':CheckOTPType.register});


  }
  @override
  void initState() {
    super.initState();
    _viewModel=  BlocProvider.of<RegisterCubit>(context,listen: false);
  }
  bool isConfirmed=false;
  String gender ='male';
  @override
  Widget build(BuildContext context) {
    RegisterBody body = context.watch<RegisterCubit>().body;
    RegisterState state = context.watch<RegisterCubit>().state;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:  Column(

          children: [
             AuthHeaderWidget(title: tr(LocaleKeys.signUp)),
                   Expanded(
                child:
                Padding(
                  padding:  16.paddingHorizontal,
                  child:  ListAnimator(
                    children: [
                      Center(
                        child: CustomPersonImage(
                          size: 104.r,
                          imageUrl: body.image,
                          canEdit: true,
                          onAttachImage: _viewModel.onAttachImage,
                        ),
                      ),
                      VerticalSpace(kScreenPaddingNormal.h),
                      _buildForm(),
                      // CheckboxListTile(
                      //   checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0.r),),
                      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0.r),),
                      //   side: MaterialStateBorderSide.resolveWith((states) => BorderSide(width: 1.w, color: Colors.black12),),
                      //   value: body.isConfirmTerms,
                      //   title:
                      //   Text('I agree with Terms & Condition', style: const TextStyle().regularStyle().customColor(_viewModel.termsError!=null?Theme.of(context).errorColor:textPrimary)),
                      //   onChanged: (value) => _viewModel.onChangeTerms(value!),
                      // ),

                      InkWell(
                        onTap: (){
                          _viewModel.onChangeTerms(!body.isConfirmTerms);
                        },
                        child: Row(
                          children: [
                            Checkbox(
                                value: body.isConfirmTerms,
                                onChanged:(value)=> _viewModel.onChangeTerms(value!)),
                            Text(tr(LocaleKeys.iAgreeTermCondition), style: const TextStyle().regularStyle().customColor(_viewModel.termsError!=null?Theme.of(context).canvasColor:textPrimary)),

                          ],
                        ),
                      ),
                      16.height,
                      // VerticalSpace(kScreenPaddingNormal.h),
                    ],
                  ),
                )
            ),
                   Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),
                   child:  CustomButton(

                     onTap: () => _onSubmit(context),
                     isRounded: true,
                     loading: (state is RegisterLoading),
                     color: Theme.of(context).primaryColor,
                     title: tr(LocaleKeys.register),
                   ),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kScreenPaddingNormal),
              child: TextClickWidget(
                text: tr(LocaleKeys.questionLoginAccount),
                subText: tr(LocaleKeys.login),
                onTap: ()=>NavigationService.push(Routes.loginScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildForm(){
    RegisterBody body = context.watch<RegisterCubit>().body;
    String? countryError = context.watch<RegisterCubit>().countryError;

    return Form(key: _formKey,child: Column (
      children: [


        CustomTextFieldNormal(
            title: tr(LocaleKeys.fullName),
             controller: _nameController, hint: tr(LocaleKeys.name),textInputAction: TextInputAction.next,autofocus: true),
        const VerticalSpace(kScreenPaddingNormal),
        // CustomTextFieldPhoneCode(label: tr(LocaleKeys.yourPhoneNumber),initialCountryCode:body.code ,controller: _phoneController,textInputAction: TextInputAction.next,onCountryChanged: _viewModel.onCountryCode,),
        CustomTextFieldNormal(
          title:tr(LocaleKeys.yourPhoneNumber),
          textInputType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          prefixWidget: const Icon(Icons.phone_enabled_rounded,color: primaryColor,),
          label: tr(LocaleKeys.phoneNumber) ,
          hint: tr(LocaleKeys.phoneNumber),
          controller: _phoneController,
        ),
        // CustomTextFieldPhoneCountryNetwork(
        //   title: tr(LocaleKeys.phoneNumber),
        //   selectedValue: body.country,
        //   controller: _phoneController,
        //   onSelected: _viewModel.onCountry,
        //   error: countryError,
        // ),
        const VerticalSpace(kScreenPaddingNormal),
        CustomTextFieldEmail(
          validateFunc: (value){
            return null;
          },
          title: tr(LocaleKeys.emailAddress),
            label: tr(LocaleKeys.email),controller: _emailController,textInputAction: TextInputAction.next),
        const VerticalSpace(kScreenPaddingNormal),
         GenderWidget(
          title:tr(LocaleKeys.gender),

          onChanged: (String value){
            gender =value;
          },
        ),
        // const VerticalSpace(kScreenPaddingNormal),
        // CustomTextFieldNormal(
        //   validateFunc: (pass) {
        //    return null;
        //   },
        //     title: 'Shared Code',
        //     controller: _codeController, hint: 'Code',
        //     textInputAction: TextInputAction.next,autofocus: true),

        const VerticalSpace(kScreenPaddingNormal),
        // CustomTextFieldPassword(
        //     title: tr(LocaleKeys.password),
        //     label: tr(LocaleKeys.password),controller: _passwordController,textInputAction: TextInputAction.next),
        // const VerticalSpace(kScreenPaddingNormal),
        //
        // CustomTextFieldPassword(
        //   title: tr(LocaleKeys.confirmPassword),
        //   label: tr(LocaleKeys.confirmPassword),
        //   controller: _confirmPasswordController,
        //   textInputAction: TextInputAction.done,
        //   validateFunc: (pass) {
        //     if (pass != _passwordController.text) {
        //       return tr(LocaleKeys.passwordNotSame);
        //     }
        //   },
        // ),
        // const VerticalSpace(kScreenPaddingNormal),


      ],
    ));
  }
}
