import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/resources.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/presentation/component/component.dart';
import 'package:q_trip_user/presentation/modules/setting/change_password/change_password_cubit.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../generated/locale_keys.g.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

 late TextEditingController _oldPasswordController ;
 late TextEditingController _newPasswordController ;
 late TextEditingController _confirmPasswordController ;

  _onChangePassword() async{
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ResponseModel responseModel = await BlocProvider.of<ChangePasswordCubit>(context,listen: false).changePassword(
            password: _newPasswordController.text,
        );

        if (responseModel.isSuccess) {
          NavigationService.goBack();
        }
      }
    }
  }
@override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }
  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title:
          tr(LocaleKeys.passwordManager),
      // tr(LocaleKeys.changePassword),
      ),
      body: _buildForm(),
    );
  }

  _buildForm() {
    ChangePasswordState state = context.watch<ChangePasswordCubit>().state;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(kScreenPaddingNormal.r),
        child: ListAnimator(
          children: [

            VerticalSpace(kScreenPaddingNormal.h),
            CustomTextFieldPassword(label: tr(LocaleKeys.oldPassword), controller: _oldPasswordController),
            CustomTextFieldPassword(label: tr(LocaleKeys.newPassword), controller: _newPasswordController),
            CustomTextFieldPassword(
              label: tr(LocaleKeys.confirmPassword),
              controller: _confirmPasswordController,
              validateFunc: (value) {
                if (_newPasswordController.text != _confirmPasswordController.text) {
                  return tr(LocaleKeys.passwordNotSame);
                }
              },
            ),

            VerticalSpace(kScreenPaddingNormal.h),
            CustomButton(
              loading: state is ChangePasswordLoading,
              onTap: () => _onChangePassword(),
              title: tr(LocaleKeys.submit),
            ),
          ],
        ),
      ),
    );
  }



}
