import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/app_router.dart';
import 'package:glad/signup/cubit/signup_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/app_colors.dart';
import '../components/app_text.dart';
import '../components/app_text_field.dart';
import '../utils/app_assets.dart';
import '../utils/app_utls.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupFailure) {
                AppUtils.hideLoading(context);
                AppUtils.showErrorSnackBar(context, state.error);
              }
              if (state is SignupValidFailure) {
                AppUtils.showErrorSnackBar(context, state.error);
              }
              if (state is SignupLoading) {
                AppUtils.showLoading(context);
              }
              if (state is SignupSuccess) {
                AppUtils.hideLoading(context);
                AppUtils.showSuccessSnackBar(
                    context, 'Account created successfully');
                context.push(Routes.homeRoute);
              }
            },
            builder: (context, state) {
              return Column(
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
                  SvgPicture.asset(
                    AppAssets.signUpSvg,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: AppUtils.height(context) * .054),
                  Text(
                    'Create your account',
                    style: AppUtils.headTextStyle.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppUtils.height(context) * .04),
                  TextFieldWidget(
                    controller: cubit.nameC,
                    iconData: Icons.person_outline,
                    filledColor: AppColors.white,
                    hintText: 'Name',
                  ),
                  SizedBox(
                    height: AppUtils.height(context) * .02,
                  ),
                  TextFieldWidget(
                    controller: cubit.emailC,
                    iconData: Icons.email_outlined,
                    filledColor: AppColors.white,
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: AppUtils.height(context) * .02,
                  ),
                  TextFieldWidget(
                    controller: cubit.passwordC,
                    iconData: Icons.lock_outlined,
                    filledColor: AppColors.white,
                    hintText: 'Password',
                    isPasswordField: true,
                  ),
                  SizedBox(height: AppUtils.height(context) * .04),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            AppColors.secondaryColor)),
                    onPressed: () => cubit.signUp(),
                    child: const AppText(
                      text: 'Create Account',
                      color: AppColors.headingColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: AppUtils.height(context) * .06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: AppColors.headingColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          ' Login ',
                          style: TextStyle(
                              // fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.headingColor),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
