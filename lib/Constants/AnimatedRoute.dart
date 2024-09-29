import 'package:flutter/material.dart';

Route AnimatedRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    // Add a transitionDuration if you want a specific duration for the animation
    transitionDuration: Duration(milliseconds: 500), // Example duration
    // Set `opaque` to false to make sure the previous route is not visible during the transition
    opaque: false,
    // Define the transition type as a push replacement
    maintainState: true,
    fullscreenDialog: false,
  );
}
