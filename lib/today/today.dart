import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../legacy/daily_entry/utils/contants.dart';
import '../legacy/daily_entry/widget/custom_textfield.dart';

class TodayPage extends StatelessWidget{
  TextEditingController etGrateful = TextEditingController();
  TextEditingController etLearned = TextEditingController();
  TextEditingController etAppreciated = TextEditingController();
  TextEditingController etDelighted = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi, John Doe", style: TextStyle(fontSize: 32),),
                          Text("15th Dec 2023")
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    title: Constants.GRATEFULTITLE,
                    hint: Constants.GRATEFULHINT,
                    controller: etGrateful,
                    enabled: true,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    title: Constants.LEARNEDTITLE,
                    hint: Constants.LEARNEDHINT,
                    controller: etLearned,
                    enabled: true,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    title: Constants.APPRECIATEDTITLE,
                    hint: Constants.APPRECIATEDHINT,
                    controller: etAppreciated,
                    enabled: true,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    title: Constants.DELIGHTEDTITLE,
                    hint: Constants.DELIGHTEDHINT,
                    controller: etDelighted,
                    enabled: true,
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

}