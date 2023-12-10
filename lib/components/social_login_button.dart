import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../utils/app_utls.dart';


class SocialLoginBtn extends StatelessWidget {
  const SocialLoginBtn(
      this.icon,
      this.label, {
        super.key,
        this.startMargin,
        this.onTap,
      });
  final String label;
  final String icon;
  final double? startMargin;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: startMargin ?? AppUtils.width(context) * .2),
            Image.asset(
              icon,
              width: 25,
              height: 25,
            ),
            SizedBox(width: AppUtils.width(context) * .03),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.headingColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}