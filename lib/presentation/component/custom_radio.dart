
import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/core/resources/text_styles.dart';
import 'package:q_trip_user/presentation/component/spaces.dart';
import 'package:q_trip_user/presentation/component/texts/black_texts.dart';




class CustomRadio<T> extends StatelessWidget {
  final String _title;
  final T _value;
  final T? _groupValue;
  final ValueChanged<T> _onChanged;
  final Widget? _widget;
  const CustomRadio({
    super.key,
    required String title,
    required T value,
    T? groupValue,
    required ValueChanged<T> onChanged,Widget? widget,
  })  : _title = title,
        _value = value,
        _widget = widget,
        _groupValue = groupValue,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: _value,
          groupValue: _groupValue,
          onChanged: (value) => _onChanged(_value),
        ),
        if(_widget !=null)
          _widget!
        else
        Expanded(child: BlackMediumText(label: _title,fontSize: 18,)),
    
      ],
    );
  }
}

class CustomRadioText<T> extends StatelessWidget {
  final String _title;
  final T _value;
  final T? _groupValue;
  final ValueChanged<T> _onChanged;

  const CustomRadioText({
    super.key,
    required String title,
    required T value,
    T? groupValue,
    required ValueChanged<T> onChanged,
  })  : _title = title,
        _value = value,
        _groupValue = groupValue,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HorizontalSpace(10.w),
        Expanded(child: BlackMediumText(label: _title,fontSize: 18,)),
        Radio<T>(
          value: _value,
          groupValue: _groupValue,
          onChanged: (value) => _onChanged(_value),
        ),
      ],
    );
  }
}
