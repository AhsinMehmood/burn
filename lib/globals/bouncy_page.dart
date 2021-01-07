import 'package:flutter/material.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;

  BouncyPageRoute({
    @required this.widget,
  }) : super(
            transitionDuration: Duration(
              milliseconds: 300,
            ),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child,
            ) {
              animation = CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              );
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.centerLeft,
              );
            },
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
            ) {
              return widget;
            });
}
