import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

ThemeData themes() => ThemeData(
      scaffoldBackgroundColor: scaffoldColor,
      primaryColor: pinkColor,
      appBarTheme: AppBarTheme(
        shape: CustomAppBar(),
        backgroundColor: pinkColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: pinkColor,
        ),
      ),
    );
