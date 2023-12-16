import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.iconData,
    this.hintText,
    this.inputType,
    this.filledColor,
    this.suffixWidget,
    this.isPasswordField,
    this.controller,
  });

  final IconData? iconData;
  final String? hintText;
  final Color? filledColor;
  final TextInputType? inputType;
  final bool? isPasswordField;
  final Widget? suffixWidget;
  final TextEditingController? controller;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool showHidePassword;

  @override
  void initState() {
    if (widget.isPasswordField != null) {
      showHidePassword = widget.isPasswordField!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      scrollPadding: EdgeInsets.zero,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.black),
      decoration: InputDecoration(
        fillColor: widget.filledColor ?? AppColors.lightPrimaryColor,
        filled: true,
        hintStyle: TextStyle(color: AppColors.headingColor.withOpacity(0.3)),
        isDense: true,
        prefixIcon: widget.iconData == null
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      widget.iconData,
                      size: 20,
                      // color: AppColors.headingColor.withOpacity(0.3),
                    ),
                  ),
                  // Vertical divider
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.primaryColor.withOpacity(.4),
                    margin: const EdgeInsets.only(right: 15, left: 5),
                  ),
                ],
              ),
        hintText: widget.hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        suffixIcon: (widget.isPasswordField != null)
            ? InkWell(
                onTap: () {
                  setState(() {
                    if (!showHidePassword) {
                      showHidePassword = true;
                    } else {
                      showHidePassword = false;
                    }
                  });
                },
                child: Container(
                  width: 10,
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(
                    (showHidePassword) ? 'Show' : 'hide',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ))
            : widget.suffixWidget ?? const SizedBox.shrink(),
      ),
      obscureText:
          (widget.isPasswordField != null && showHidePassword) ? true : false,
      keyboardType: widget.isPasswordField != null
          ? TextInputType.visiblePassword
          : widget.inputType ?? TextInputType.text,
    );
  }
}
