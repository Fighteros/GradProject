import 'package:flutter/material.dart';
import 'package:mobile_app/modules/loginscreen.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/network/local/cache_helper.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              const Image(
                image: AssetImage('images/cherry-medical-business.png'),
                height: 301,
                width: 279,
              ),
              const SizedBox(
                height: 180,
              ),
              defultButton(
                  changeText: 'GET STARTED',
                  changeColor: btnsColor,
                  fontWeight: FontWeight.bold,
                  height: 84,
                  width: 301,
                  radius: 13,
                  onPressed: () {
                    CacheHelper.saveData(key: 'home', value: true)
                        .then((value) {
                      if (value) navigatePushAndRemove(context, LoginScreen());
                    });
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
