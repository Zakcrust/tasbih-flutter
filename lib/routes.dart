import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbih_flutter/views/home.dart';
import 'package:tasbih_flutter/views/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
  HomeScreen.routeName: (BuildContext context) => const HomeScreen()
};
