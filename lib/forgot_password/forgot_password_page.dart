import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/app_colors.dart';
import '../components/app_text.dart';
import '../components/app_text_field.dart';
import '../utils/app_assets.dart';
import '../utils/app_utls.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordLoading) {
            AppUtils.showLoading(context);
          } else if (state is ForgotPasswordSuccess) {
            AppUtils.showSuccessSnackBar(context, state.success);
            AppUtils.hideLoading(context);
          } else if (state is ForgotPasswordFailure) {
            AppUtils.hideLoading(context);
            AppUtils.showErrorSnackBar(context, state.error);
          } else if (state is ForgotPasswordValidFailure) {
            AppUtils.showErrorSnackBar(context, state.error);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: AppUtils.height(context) * .05),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.headingColor.withOpacity(.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.headingColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppUtils.height(context) * .09),
                Text(
                  'Forgot your password?',
                  style: AppUtils.headTextStyle.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppUtils.height(context) * .05),
                SvgPicture.asset(
                  AppAssets.forgotPasswordSvg,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: AppUtils.height(context) * .07),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      const AppText(
                        text:
                            'Enter your registered email below to receive \npassword reset instruction',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppUtils.height(context) * .05),
                      TextFieldWidget(
                        controller: context.read<ForgotPasswordCubit>().emailC,
                        hintText: 'Email',
                      ),
                      SizedBox(height: AppUtils.height(context) * .05),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.secondaryColor)),
                        onPressed: () // {},
                            =>
                            context
                                .read<ForgotPasswordCubit>()
                                .forgotPassword(),
                        child: const AppText(
                          text: 'Send Reset Link',
                          color: AppColors.headingColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                SizedBox(height: AppUtils.height(context) * .2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remember password? ',
                      style: TextStyle(
                        color: AppColors.headingColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        ' Login ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.headingColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
