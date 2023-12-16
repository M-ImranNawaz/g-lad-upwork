import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/login/cubit/login_cubit.dart';

import '../components/app_text.dart';
import '../components/app_text_field.dart';
import '../utils/app_colors.dart';
import '../utils/app_utls.dart';

class LoginPage extends StatelessWidget {
  Color gradientStart = Colors.transparent;
  Color gradientEnd = AppColors.lightPrimaryColor;

  final void Function() navigateToSignupView;
  final void Function() navigateToForgotPasswordView;
  final void Function() navigateToHomePage;

  LoginPage(
      {super.key,
      required this.navigateToSignupView,
      required this.navigateToForgotPasswordView,
      required this.navigateToHomePage});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginValidFailure) {
            AppUtils.showErrorSnackBar(context, state.error);
          }
          if (state is LoginFailure) {
            AppUtils.hideLoading(context);
            AppUtils.showErrorSnackBar(context, state.error);
          }
          if (state is LoginLoading) {
            AppUtils.showLoading(context);
            return;
          }
          if (state is LoginSuccess) {
            AppUtils.hideLoading(context);
            AppUtils.showSuccessSnackBar(context, 'Logged in successfully');
            navigateToHomePage(); // Navigate to home page
          }
        },
        builder: (context, state) {
          return Stack(children: <Widget>[
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [gradientStart, gradientStart],
                ).createShader(
                    Rect.fromLTRB(0, -280, rect.width, rect.height - 140));
              },
              blendMode: BlendMode.darken,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/splash_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          'Welcome to glad',
                          style: AppUtils.headTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Expanded(
                        flex: 1,
                        child: PhysicalModel(
                          color: Colors.white,
                          elevation: 5,
                          shadowColor: Colors.blue,
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(25),
                              left: Radius.circular(25)),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Login in with email',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.headingColor,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFieldWidget(
                                    controller: cubit.emailC,
                                    iconData: Icons.email_outlined,
                                    hintText: 'Email Address',
                                  ),
                                  SizedBox(
                                    height: AppUtils.height(context) * .04,
                                  ),
                                  TextFieldWidget(
                                    controller: cubit.passwordC,
                                    iconData: Icons.lock_outlined,
                                    hintText: 'Password',
                                    isPasswordField: true,
                                  ),
                                  SizedBox(
                                    height: AppUtils.height(context) * .05,
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 1,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.secondaryColor)),
                                      onPressed: () => cubit.logIn(),
                                      child: const AppText(
                                        text: 'Login',
                                        color: AppColors.headingColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppUtils.height(context) * .02,
                                  ),
                                  InkWell(
                                    onTap: () => navigateToForgotPasswordView(),
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppUtils.height(context) * .02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Don’t have an account?',
                                        style: TextStyle(
                                          color: AppColors.headingColor,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => navigateToSignupView(),
                                        child: const Text(
                                          ' Sign up ',
                                          style: TextStyle(
                                              // fontSize: 16,
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
                        ));
                  },
                )
              ],
            ),
          ]);
        },
      ),
    );
  }
}
