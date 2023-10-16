import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  String title;
  String hint;
  TextEditingController controller;
  bool enabled = true;

  CustomTextField(
      {super.key, required this.title, required this.hint, required this.controller, required this.enabled});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          width: 70.w,
          child: TextField(
            minLines: 1,
            maxLines: 200,
            enabled: widget.enabled,
            controller: widget.controller,
            onChanged: (value) {
              widget.controller.text = value;
              widget.controller.selection =
                  TextSelection.collapsed(offset: widget.controller.text.length);
            },

            onTap: () {
              widget.controller.selection =
                  TextSelection.collapsed(offset: widget.controller.text.length);
            },

            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              hintText: widget.hint,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
