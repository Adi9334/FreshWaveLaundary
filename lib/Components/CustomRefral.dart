import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';

class CustomRefral extends StatelessWidget {
  final title;
  final subtitle;
  final Subtitle1;
  final image;
  CustomRefral({
    Key? key,
    this.title,
    this.subtitle,
    this.Subtitle1,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.indigoAccent.shade100,
        elevation: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: heading().copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(Subtitle1,
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(image.toString())))
          ],
        ));
  }
}
