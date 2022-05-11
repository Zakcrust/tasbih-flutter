import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasbih_flutter/consts.dart';
import 'package:tasbih_flutter/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String routeName = "/";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    timedScreen();
    super.initState();
  }

  Future<void> timedScreen() {
    return Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/icon_tasbih.svg",
                color: Colors.white,
              ),
              const SizedBox(
                height: 100,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          )),
    );
  }
}
