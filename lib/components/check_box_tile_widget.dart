import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../utils/app_utls.dart';
import 'app_text.dart';

class CheckBoxTileWidget extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool?> onChanged;

  const CheckBoxTileWidget({
    super.key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CheckBoxTileWidget> createState() => _CheckBoxTileWidgetState();
}

class _CheckBoxTileWidgetState extends State<CheckBoxTileWidget> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _handleCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          fillColor: MaterialStateProperty.all(AppColors.primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          checkColor: AppColors.headingColor,
          side: BorderSide.none,
          value: _isChecked,
          onChanged: _handleCheckboxChanged,
        ),
        SizedBox(height: AppUtils.height(context) * .01),
        Expanded(
          child: AppText(text: widget.label),
        )
      ],
    );
  }
}