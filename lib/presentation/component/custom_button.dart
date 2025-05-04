import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import '../../core/resources/color.dart';
import '../../core/resources/text_styles.dart';
import '../../core/resources/values_manager.dart';
import '../component/component.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback _onTap;
  final Widget? _child;
  final String? _title;
  final Color? _color;
  final Color? _textColor;
  final double? _width;
  final double? _raduis;
  final double? _height;
  final double? _fontSize;
  final bool _isRounded;
  final bool _isOutlined;
  final bool _widerPadding;
  final bool _loading;
  final bool _boxShadow;
  final bool _expanded;
  final bool _enable;
  final EdgeInsetsGeometry? _padding;

  const CustomButton({super.key,
    required VoidCallback onTap,
    Widget? child,
    String? title,
    Color? color,
    Color? textColor,
    EdgeInsetsGeometry? padding,
    double? width,
    double? fontSize,
    double? raduis,
    double? height,
    bool isRounded= true,
    bool boxShadow= false,
    bool enable= true,
    bool isOutlined= false,
    bool widerPadding= false,
    bool loading= false,
    bool expanded= true,
  })  : _onTap = onTap,
        _child = child,
        _title = title,
        _expanded = expanded,
        _padding = padding,
        _boxShadow = boxShadow,
        _color = color,
        _raduis = raduis,
        _textColor = textColor,
        _width = width,
        _fontSize = fontSize,
        _enable = enable,
        _height = height,
        _isRounded = isRounded,
        _isOutlined = isOutlined,
        _widerPadding = widerPadding,
        _loading = loading;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin:_padding,
      decoration: BoxDecoration(
          color:_isOutlined?Colors.white: _color??primaryColor,
          borderRadius: _isRounded?BorderRadius.circular(_raduis??10):null,
          boxShadow:
          _isOutlined==true? [BoxShadow()]:
          [
            _boxShadow==false?const BoxShadow():
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(2, 3), // changes position of shadow
            ),
          ]
      ),
      width:_expanded?(_width??deviceWidth):null ,
      height: (_height??46).h,
      child: TapEffect(
        isClickable: ! (!_enable||_loading),
        onTap: (!_enable||_loading)?null:_onTap,

        child: MaterialButton(
          color: _isOutlined ? Colors.white :( _color??Theme.of(context).primaryColor),
          highlightElevation: 0,
          onPressed: (!_enable||_loading)?(){}: _onTap,
          padding: !_widerPadding ? EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w) : EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          elevation: 0,
          shape:
          _isOutlined==true?
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(_raduis??kFormRadiusSmall.r), side: BorderSide(color:  Theme.of(context).primaryColor, width: 1.5.w)):

          _isRounded
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(_raduis?? kFormRadiusSmall.r), side: BorderSide(color: _color ?? Theme.of(context).primaryColor, width: 1.5.w))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(_raduis??kFormRadiusSmall.r), side: BorderSide(color: _color ?? Theme.of(context).primaryColor, width: 1.5.w)),
          child: _loading
              ? CustomLoadingSpinner( size: (_height ?? 20).h,color: Theme.of(context).cardColor)
              :_title!=null?
         FittedBox(
           fit: BoxFit.scaleDown,
           child:  Center(child: Text(_title!,style: const TextStyle().regularStyle(fontSize: _fontSize??16,).customColor(_isOutlined==true?primaryColor:_textColor??Colors.white).copyWith(
             fontWeight: FontWeight.w500
         ),),),): _child??const SizedBox(),
        ),
      ),
    );
  }

}
