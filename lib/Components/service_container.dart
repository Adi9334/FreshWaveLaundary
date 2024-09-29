import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class service_container extends StatefulWidget {
  const service_container({super.key});

  @override
  State<service_container> createState() => _service_cardState();
}

class _service_cardState extends State<service_container> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.white,
      child: Container(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Content',
              ),
              Text(
                'from price',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset('assets/images/slider1.jpeg')),
          ),
        ]),
      ),
    );
  }
}
