import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/today/cubit/save_data_cubit.dart';
import 'package:glad/utils/app_utls.dart';
import 'package:intl/intl.dart';

import '../components/app_text.dart';
import '../legacy/daily_entry/utils/contants.dart';
import '../legacy/daily_entry/widget/custom_textfield.dart';
import '../utils/app_colors.dart';

class TodayPage extends StatelessWidget {
  final DateTime? dateTime;
  final Map<String, dynamic>? data;

  const TodayPage({
    super.key,
    this.dateTime,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SaveDataCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocListener<SaveDataCubit, SaveDataState>(
            listener: (context, state) {
              if (state is SaveDataSuccess) {
                AppUtils.hideLoading(context);
                AppUtils.showSuccessSnackBar(context, "Data Added Successful");
              } else if (state is SaveDataFailure) {
                AppUtils.hideLoading(context);
                AppUtils.showErrorSnackBar(context, state.error);
              } else if (state is SaveDataValidFailure) {
                AppUtils.showErrorSnackBar(context, state.error);
              } else if (state is SaveDataLoading) {
                AppUtils.showLoading(context);
              }
            },
            child: BlocBuilder<SaveDataCubit, SaveDataState>(
              builder: (context, state) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi, ${FirebaseAuth.instance.currentUser?.displayName}",
                                style: const TextStyle(fontSize: 32),
                              ),
                              Text(
                                dateTime == null
                                    ? DateFormat("yyyy-MM-dd")
                                        .format(DateTime.now())
                                    : DateFormat("yyyy-MM-dd")
                                        .format(dateTime!),
                              )
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: Constants.GRATEFULTITLE,
                        hint: Constants.GRATEFULHINT,
                        controller: cubit.gratefulC,
                        enabled: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: Constants.LEARNEDTITLE,
                        hint: Constants.LEARNEDHINT,
                        controller: cubit.learnedC,
                        enabled: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: Constants.APPRECIATEDTITLE,
                        hint: Constants.APPRECIATEDHINT,
                        controller: cubit.appreciatedC,
                        enabled: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: Constants.DELIGHTEDTITLE,
                        hint: Constants.DELIGHTEDHINT,
                        controller: cubit.delightedC,
                        enabled: true,
                      ),
                      const SizedBox(height: 20),
                      if (data == null)
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.secondaryColor,
                              ),
                            ),
                            onPressed: () {
                              cubit.onAddData();
                            },
                            child: const AppText(
                              text: 'Save Data',
                              color: AppColors.headingColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
