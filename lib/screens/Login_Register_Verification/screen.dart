import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/screens/Login_Register_Verification/screens/login.dart';
import 'package:material_kit_flutter/screens/Login_Register_Verification/screens/register.dart';
import 'package:material_kit_flutter/screens/home.dart';

import '../../constants/Theme.dart';

class AnimationScreen extends StatefulWidget{
  const AnimationScreen({Key? key}): super(key: key);

  @override
  _AnimationScreen createState() => _AnimationScreen();
}

class _AnimationScreen extends State<AnimationScreen> with TickerProviderStateMixin{
  AnimationController? _animationController;
  @override 
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  MaterialColors.bgPrimary,
                  MaterialColors.bgSecondary,
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          ),
          LoginView(animationController: _animationController!),
          RegisterView(animationController: _animationController!)
        ],
      ),
    );
  }

  void home() {
    Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true,
        builder: (context) => Home(),
      ),
    );
  }
}