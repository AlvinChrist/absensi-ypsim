import 'package:flutter/material.dart';
import 'package:material_kit_flutter/screens/Login_Register_Verification/screen.dart';
import 'package:material_kit_flutter/screens/history.dart';
// screens
import 'package:material_kit_flutter/screens/home.dart';
import 'package:material_kit_flutter/screens/profile.dart';
import 'package:material_kit_flutter/screens/register.dart';
import 'package:material_kit_flutter/screens/verification.dart';

void main() => runApp(MaterialKitPROFlutter());

class MaterialKitPROFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Material Kit PRO Flutter",
        debugShowCheckedModeBanner: false,
        initialRoute: "/home",
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => AnimationScreen(),
          "/register": (BuildContext context) => Register(),
          "/verification": (BuildContext context) => Verification(),
          // "/onboarding": (BuildContext context) => Onboarding(),
          // "/pro": (BuildContext context) => Pro(),
          "/home": (BuildContext context) => Home(),
          "/history": (BuildContext context) => History(),
          // "/components": (BuildContext context) => Components(),
          "/profile": (BuildContext context) => Profile(),
          // "/settings": (BuildContext context) => Settings(),
        });
  }
}
