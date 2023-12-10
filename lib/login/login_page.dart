import 'package:flutter/material.dart';
import '../components/app_text.dart';
import '../components/app_text_field.dart';
import '../utils/app_colors.dart';
import '../utils/app_utls.dart';

class LoginPage extends StatelessWidget {
  Color gradientStart = Colors.transparent;
  Color gradientEnd = AppColors.lightPrimaryColor;

  final void Function() navigateToSignupView;
  final void Function() navigateToForgotPasswordView;

  LoginPage({super.key, required this.navigateToSignupView, required this.navigateToForgotPasswordView});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: <Widget>[
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
              flex:1,
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
                  const SizedBox(height: 40,)
                ],
              ),
            ),

            Expanded(
                flex: 1,
                child: PhysicalModel(
                  color: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.blue,
                  borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(25), left: Radius.circular(25)),
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
                          const TextFieldWidget(
                            iconData: Icons.email_outlined,
                            hintText: 'Email Address',
                          ),
                          SizedBox(
                            height: AppUtils.height(context) * .04,
                          ),
                          const TextFieldWidget(
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
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.secondaryColor)),
                              onPressed: () {

                              },
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
                ))
          ],
        ),
      ]),
    );
  }
}
