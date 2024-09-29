import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Constants/AnimatedRoute.dart';

void SuccessDialog(
    BuildContext context, String title, String content, Widget Screen) {
  try {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(AnimatedRoute(Screen));
        });
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/images/righttick.png')),
              Text(content),
            ],
          ),
        );
      },
    );
  } catch (e) {
    print('Error: $e');
  }
}

void SuccessDialogwithoutNavigation(
    BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/righttick.png')),
            Text(content),
          ],
        ),
      );
    },
  );
}

void ErrorDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'))
          ],
        );
      });
}

void ErrorDialogwithNavigation(
    BuildContext context, String title, String content, Widget page) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(AnimatedRoute(page));
                },
                child: Text('Ok'))
          ],
        );
      });
}
