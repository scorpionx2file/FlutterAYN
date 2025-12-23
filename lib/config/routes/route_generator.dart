import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveller/config/routes/app_routes.dart';

import '../../main.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings){
    final argument = settings.arguments;
    switch(settings.name)
    {
      case AppRoutes.Home : return MaterialPageRoute(builder: (context){
        return MyHomePage(title: 'Flutter Demo Home Page');
      });
      default : return MaterialPageRoute(builder: (context){
        return Scaffold(
          body: Center(
            child: Text("Page not found"),
          ),
        );
      }) ;
    }
  }
}